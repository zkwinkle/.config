-- Route `vim.lsp.buf.format` through clang-format for C# buffers.
--
-- roslyn-ls only implements Roslyn's formatter, which is whitespace-only. For
-- example it won't reflow a long line.
--
-- This file wraps the LSP formatter so `.cs` buffers get clang-format instead,
-- which does wrap, while every other filetype keeps its normal LSP behaviour.

local M = {}

-- Defaults when the project has no .clang-format of its own.
-- If `.clang-format` is present we just use those settings, they don't get
-- merged or anything like that.
local default_style = table.concat({
  'BasedOnStyle: Microsoft',
  'Language: CSharp',
  'ColumnLimit: 80',
  'SpaceBeforeParens: Never',
  'BreakBeforeBraces: Allman',
  'IndentWidth: 4',
  'NamespaceIndentation: All',
}, ', ')

-- A .clang-format in the tree means the project has formatting rules that
-- everyone working on it is expected to follow, so we use them.
local function style_arg(fname)
  local dir = vim.fs.dirname(fname)
  if dir ~= '' and vim.fs.find('.clang-format', { path = dir, upward = true })[1] then
    return '--style=file'
  end
  return '--style={' .. default_style .. '}'
end

local function format_cs(buf)
  local fname = vim.api.nvim_buf_get_name(buf)
  local win = vim.api.nvim_get_current_win()

  -- clang-format's --cursor takes a byte offset into the *input* and reports
  -- back where that same position landed in the output.
  -- That lets the cursor follow the code it was sitting on, rather than staying
  -- on a line number whose meaning changed once lines were wrapped and shifted.
  local row, col = unpack(vim.api.nvim_win_get_cursor(win))
  local offset = vim.api.nvim_buf_get_offset(buf, row - 1) + col

  local res = vim.system({
    'clang-format',
    -- Required: clang-format infers the language from the filename, and with
    -- stdin there isn't one. It's also what --style=file resolves against.
    '--assume-filename=' .. fname,
    '--cursor=' .. offset,
    style_arg(fname),
  }, {
    stdin = table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), '\n'),
    text = true,
  }):wait()

  if res.code ~= 0 then
    vim.notify(res.stderr, vim.log.levels.ERROR, { title = 'clang-format' })
    return
  end

  local lines = vim.split(res.stdout, '\n')

  -- With --cursor, the first line of stdout is a JSON header:
  --   { "Cursor": 3102, "IncompleteFormat": false }
  local header = table.remove(lines, 1)
  local new_offset = tonumber(header:match('"Cursor":%s*(%d+)'))

  -- IncompleteFormat means clang-format couldn't fully parse the input. Its C#
  -- support is weaker than its C++ support, so emitting a warning.
  if header:match('"IncompleteFormat":%s*true') then
    vim.notify('clang-format: incomplete format (parse error?)', vim.log.levels.WARN)
  end

  -- stdout ends with a newline, so the split leaves a trailing empty string.
  -- Without this we'd gain one blank line at the end on every single format.
  if lines[#lines] == '' then
    table.remove(lines)
  end

  -- Replacing every line resets the window's scroll position, so snapshot the
  -- view first and restore it after. --cursor handles where the cursor goes;
  -- this handles everything else about the viewport (topline, leftcol, ...).
  local view = vim.fn.winsaveview()
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.fn.winrestview(view)

  -- Now translate clang-format's byte offset back into a (row, col) pair. This
  -- has to happen after set_lines, since byte2line and buf_get_offset both read
  -- the buffer's current contents.
  if new_offset then
    local new_row = vim.fn.byte2line(new_offset + 1)
    if new_row > 0 then
      local line_start = vim.api.nvim_buf_get_offset(buf, new_row - 1)
      local line_len = #vim.api.nvim_buf_get_lines(buf, new_row - 1, new_row, false)[1]
      vim.api.nvim_win_set_cursor(win, {
        new_row,
        math.min(new_offset - line_start, line_len),
      })
    end
  end
end

function M.setup()
  if vim.fn.executable('clang-format') ~= 1 then
    return
  end

  local lsp_format = vim.lsp.buf.format

  vim.lsp.buf.format = function(opts)
    opts = opts or {}
    local buf = opts.bufnr or vim.api.nvim_get_current_buf()
    if vim.bo[buf].filetype ~= 'cs' then
      return lsp_format(opts)
    end
    format_cs(buf)
  end
end

return M
