-- n, v, i, t = mode names

local M = {}

M.general = {
  i = {
  	["<Left>"]	= {map = '<ESC>:echoe "Use h"<CR>', opts = {noremap = true}},
  	["<Right>"]	= {map = '<ESC>:echoe "Use l"<CR>', opts = {noremap = true}},
  	["<Up>"]		= {map = '<ESC>:echoe "Use k"<CR>', opts = {noremap = true}},
  	["<Down>"]	= {map = '<ESC>:echoe "Use j"<CR>', opts = {noremap = true}},
  },

  n = {
		["<SPACE>"] = {map = '<Nop>', opts = {noremap = true}},

  	["<Left>"]	= {map = '<ESC>:echoe "Use h"<CR>', opts = {noremap = true}},
  	["<Right>"]	= {map = '<ESC>:echoe "Use l"<CR>', opts = {noremap = true}},
  	["<Up>"]		= {map = '<ESC>:echoe "Use k"<CR>', opts = {noremap = true}},
  	["<Down>"]	= {map = '<ESC>:echoe "Use j"<CR>', opts = {noremap = true}},

    -- Allow moving the cursor through wrapped lines with j, k
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    ["j"] = { map = 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true, noremap = true } },
    ["k"] = { map = 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true, noremap = true } },
		["Q"] = { map = '<Nop>', opts = {}},

		["<leader>1"]	= { map = "1gt", opts = {noremap = true}},
		["<leader>2"]	= { map = "2gt", opts = {noremap = true}},
		["<leader>3"]	= { map = "3gt", opts = {noremap = true}},
		["<leader>4"]	= { map = "4gt", opts = {noremap = true}},
		["<leader>5"]	= { map = "5gt", opts = {noremap = true}},
		["<leader>6"]	= { map = "6gt", opts = {noremap = true}},
		["<leader>7"]	= { map = "7gt", opts = {noremap = true}},
		["<leader>8"]	= { map = "8gt", opts = {noremap = true}},
		["<leader>9"]	= { map = "9gt", opts = {noremap = true}},
		["<leader>0"]	= { map = ":tablast<cr>", opts = {noremap = true}},

		-- Shortcutting split navigation
		["<C-h>"]	= { map = "<C-w>h", opts = {noremap = true}},
		["<C-j>"]	= { map = "<C-w>j", opts = {noremap = true}},
		["<C-k>"]	= { map = "<C-w>k", opts = {noremap = true}},
		["<C-l>"]	= { map = "<C-w>l", opts = {noremap = true}},

		-- Shortcutting split movement
		["<C-w>h"]	= { map = "<C-w><S-h>", opts = {noremap = true}},
		["<C-w>j"]	= { map = "<C-w><S-j>", opts = {noremap = true}},
		["<C-w>k"]	= { map = "<C-w><S-k>", opts = {noremap = true}},
		["<C-w>l"]	= { map = "<C-w><S-l>", opts = {noremap = true}},
  },
  v = {
    ["j"] = { map = 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["k"] = { map = 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { map = 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },
  },
	all = {
		["<leader>1"]	= {map = "1gt", opts = {noremap = true}},
		["<leader>2"]	= {map = "2gt", opts = {noremap = true}},
		["<leader>3"]	= {map = "3gt", opts = {noremap = true}},
		["<leader>4"]	= {map = "4gt", opts = {noremap = true}},
		["<leader>5"]	= {map = "5gt", opts = {noremap = true}},
		["<leader>6"]	= {map = "6gt", opts = {noremap = true}},
		["<leader>7"]	= {map = "7gt", opts = {noremap = true}},
		["<leader>8"]	= {map = "8gt", opts = {noremap = true}},
		["<leader>9"]	= {map = "9gt", opts = {noremap = true}},
		["<leader>0"]	= {map = ":tablast<cr>", opts = {noremap = true}},

		-- Shortcutting split navigation
		["<C-h>"]	= {map = "<C-w>h", opts = {noremap = true}},
		["<C-j>"]	= {map = "<C-w>j", opts = {noremap = true}},
		["<C-k>"]	= {map = "<C-w>k", opts = {noremap = true}},
		["<C-l>"]	= {map = "<C-w>l", opts = {noremap = true}},

		-- Shortcutting split movement
		["<C-w>"]	= {map = "h <C-w><S-h>", opts = {noremap = true}},
		["<C-w>"]	= {map = "j <C-w><S-j>", opts = {noremap = true}},
		["<C-w>"]	= {map = "k <C-w><S-k>", opts = {noremap = true}},
		["<C-w>"]	= {map = "l <C-w><S-l>", opts = {noremap = true}},
	},
}


M.nvimtree = {
	n = {
		["<C-f>"]	= { map = ":NvimTreeToggle<CR>", opts = {noremap = true}},
		["<leader><leader>f"]	= { map = ":NvimTreeFindFile<CR>", opts = {noremap = true}},
		["<leader><leader>r"]	= { map = ":NvimTreeRefresh<CR>", opts = {noremap = true}},
	}
}

return M
