-- n, v, i, t = mode names

local M = {}

M.base = {
  i = {
    ["<Left>"]  = { map = '<ESC>:echoe "Use h"<CR>' },
    ["<Right>"] = { map = '<ESC>:echoe "Use l"<CR>' },
    ["<Up>"]    = { map = '<ESC>:echoe "Use k"<CR>' },
    ["<Down>"]  = { map = '<ESC>:echoe "Use j"<CR>' },
  },

  n = {
    ["<SPACE>"]    = { map = '<Nop>' },

    ["<Left>"]     = { map = '<ESC>:echoe "Use h"<CR>' },
    ["<Right>"]    = { map = '<ESC>:echoe "Use l"<CR>' },
    ["<Up>"]       = { map = '<ESC>:echoe "Use k"<CR>' },
    ["<Down>"]     = { map = '<ESC>:echoe "Use j"<CR>' },

    -- Allow moving the cursor through wrapped lines with j, k
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    ["j"]          = { map = 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["k"]          = { map = 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["Q"]          = { map = '<Nop>' },

    ["<leader>1"]  = { map = "1gt" },
    ["<leader>2"]  = { map = "2gt" },
    ["<leader>3"]  = { map = "3gt" },
    ["<leader>4"]  = { map = "4gt" },
    ["<leader>5"]  = { map = "5gt" },
    ["<leader>6"]  = { map = "6gt" },
    ["<leader>7"]  = { map = "7gt" },
    ["<leader>8"]  = { map = "8gt" },
    ["<leader>9"]  = { map = "9gt" },
    ["<leader>0"]  = { map = ":tablast<cr>" },

    -- Format
    ["<leader>=="] = { map = "gg<S-v>G=<C-o>" },

    -- wrap current line
    ["gq"]         = { map = "g$lgEa<CR><Esc>" },
  },

  v = {
    ["j"] = { map = 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["k"] = { map = 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { map = 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },
  },

  t = {
    ["<Esc><Esc>"] = { map = "<C-\\><C-n>" },
    ["<C-h>"] = { map = "<C-\\><C-n><C-w>h" },
    ["<C-j>"] = { map = "<C-\\><C-n><C-w>j" },
    ["<C-k>"] = { map = "<C-\\><C-n><C-w>k" },
    ["<C-l>"] = { map = "<C-\\><C-n><C-w>l" },
  },

  all = {
    -- Shortcutting split navigation
    ["<C-h>"] = { map = "<C-w>h" },
    ["<C-j>"] = { map = "<C-w>j" },
    ["<C-k>"] = { map = "<C-w>k" },
    ["<C-l>"] = { map = "<C-w>l" },

    -- Shortcutting split movement
    ["<C-w>h"] = { map = "<C-w><S-h>" },
    ["<C-w>j"] = { map = "<C-w><S-j>" },
    ["<C-w>k"] = { map = "<C-w><S-k>" },
    ["<C-w>l"] = { map = "<C-w><S-l>" },
  },
}

M.Lazy = {
  n = { ["<leader>L"] = { map = ":Lazy<CR>" } }
}

M.nvim_tree = {
  n = {
    ["<C-f>"] = { map = ":NvimTreeToggle<CR>" },
    ["<leader><leader>f"] = { map = ":NvimTreeFindFile<CR>" },
    ["<leader><leader>r"] = { map = ":NvimTreeRefresh<CR>" },
  }
}


M.lspconfig = {
  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions
  n = {
    ["<leader>gD"] = { map = vim.lsp.buf.declaration },
    ["<leader>gd"] = { map = vim.lsp.buf.definition },
    ["<leader>gr"] = { map = vim.lsp.buf.references },
    ["<leader>gi"] = { map = vim.lsp.buf.implementation },
    --["<leader>D"] =  { map = vim.lsp.buf.type_definition  },
    ["<leader>ca"] = { map = vim.lsp.buf.code_action },
    ["d["] = { map = function() vim.diagnostic.jump { count = -1 } end },
    ["d]"] = { map = function() vim.diagnostic.jump { count = 1 } end },
    ["d\\"] = { map = vim.diagnostic.open_float },
    --["<leader>q"] =  { map = vim.diagnostic.setloclist  },
    ["<leader>=="] = { map = function() vim.lsp.buf.format { async = true } end },
    ["<leader>r"] = { map = vim.lsp.buf.rename },
  },
}

M.gitsigns = {

  n = {
    ["ch"] = { map = ":Gitsigns stage_hunk<CR>" },
    ["cu"] = { map = ":Gitsigns undo_stage_hunk<CR>" },
    ["cn"] = { map = ":Gitsigns next_hunk<CR>" },
    ["cp"] = { map = ":Gitsigns prev_hunk<CR>" }
  },

  v = {
    ["ch"] = { map = ":Gitsigns stage_hunk<CR>" },
    ["cr"] = { map = ":Gitsigns reset_hunk<CR>" }
  },

}

M.github_link = {

  n = {
    ["gl"] = { map = ":GetCurrentCommitLink<CR>" },
  },

  v = {
    ["gl"] = { map = ":GetCurrentCommitLink<CR>" },
  },

}

M.fzf_lua = {
  n = {
    ["<C-p>"] = { map = function() require('fzf-lua').files() end },
    ["<C-b>"] = { map = function() require('fzf-lua').buffers() end },
    ["<C-g>"] = { map = function() require('fzf-lua').grep_project() end }
  }
}

M.duck = {
  n = {
    ["<leader>dd"] = { map = function() require("duck").hatch() end },
    ["<leader>dc"] = { map = function() require("duck").cook() end },
  }
}

return M
