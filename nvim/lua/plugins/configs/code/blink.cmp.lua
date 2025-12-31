local nvim_web_dev_highlights = function(ctx)
  local hl = ctx.kind_hl
  if vim.tbl_contains({ "Path" }, ctx.source_name) then
    local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
    if dev_icon then
      hl = dev_hl
    end
  end
  return hl
end

-- Does a regular <tab> character if there's nothing or whitespace behind it.
-- If there's any non-whitespace character behind the cursor it opens the
-- auto-complete menu
local function superload_tab(cmp)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))

  if col == 0 then
    -- Default action for Tab (schedule needed because else I get a weird
    -- error about cmp not having permission to edit buffer):
    -- E565 Not allowed to change text or change window
    vim.schedule(function()
      vim.api.nvim_paste('\t', false, -1)
    end)
    return true
  end

  -- 0-indexed
  row = row - 1;
  local char_behind = vim.api.nvim_buf_get_text(0, row, col - 1, row, col, {})[1]
  local has_whitespace_behind = char_behind.match(char_behind, "%s")

  if has_whitespace_behind then
    vim.schedule(function()
      vim.api.nvim_paste('\t', false, -1)
    end)
    return true
  else
    return cmp.show_and_insert()
  end
end

return {
  "saghen/blink.cmp",
  dependencies = { --[[ 'rafamadriz/friendly-snippets' /*stopped using snippets because I think they're mostly annoying*/ ,]] 'nvim-web-devicons', 'onsails/lspkind.nvim', 'xzbdmw/colorful-menu.nvim' },
  version = '1.*',
  event = "VeryLazy",
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = 'default',

      ['<C-u>'] = { function(cmp) cmp.select_prev({ count = 5 }) end },
      ['<C-d>'] = { function(cmp) cmp.select_next({ count = 5 }) end, 'fallback_to_mappings' },

      ['<Tab>'] = { superload_tab, 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },

      ['<CR>'] = { 'accept', 'fallback' },

      ['<C-n>'] = { 'select_next', function(cmp) return cmp.show_and_insert({ providers = { "buffer" } }) end },
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    completion = {
      -- Show the documentation popup without needing to manually trigger
      documentation = { auto_show = true },

      menu = {
        draw = {
          -- Don't need label_description now because label and label_description are
          -- already combined together in label by colorful-menu.nvim.
          columns = { { "kind_icon" }, { "label", gap = 1 } },

          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },

            kind_icon = {
              text = function(ctx)
                local icon = ctx.kind_icon
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    icon = dev_icon
                  end
                else
                  icon = require("lspkind").symbolic(ctx.kind, {
                    mode = "symbol",
                  })
                end

                return icon .. ctx.icon_gap
              end,
              highlight = nvim_web_dev_highlights,
            },
            kind = { highlight = nvim_web_dev_highlights },
          }
        }
      },
      list = { selection = { preselect = false, auto_insert = true } }
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'buffer' },
      providers = {
        -- custom buffer source that grabs from *all* buffers,
        -- not just visible ones
        buffer = {
          opts = {
            get_bufnrs = vim.api.nvim_list_bufs,
          }
        }
      }
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
