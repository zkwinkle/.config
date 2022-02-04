" Leader key
nnoremap <SPACE> <Nop>
let mapleader = " "

" Turn on syntax highlighting.
syntax on

" These lines make vim load various plugins
filetype on

filetype indent on

filetype plugin on

" Show line numbers.
set number

" Center cursor in the middle of the screen
set so=999

" Amount of spaces in a tab
set tabstop=2

" Config line number color
highlight LineNr term=bold cterm=NONE ctermfg=Magenta ctermbg=NONE gui=NONE guifg=Magenta guibg=NONE
highlight CursorLineNr term=bold cterm=NONE ctermfg=DarkCyan ctermbg=NONE gui=NONE guifg=DarkCyan guibg=NONE

" This enables relative line numbering mode. With both number and relativenumber enabled, the current line shows the true line number
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" Allow hidden buffers
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" Make search case insensitive unless there's capital letters in the search
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. Try avoiding it as much as possible.
set mouse+=a

" This is to avoid using the arrow keys
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Shortcutting split navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Shortcutting split movement
noremap <C-w>h <C-w><S-h>
noremap <C-w>j <C-w><S-j>
noremap <C-w>k <C-w><S-k>
noremap <C-w>l <C-w><S-l>

call plug#begin('~/.local/share/nvim/plugged')

"Plug 'fladson/vim-kitty', { 'branch': 'main'} " Syntax highlighting based on kitty terminal's config

" nvim tree related plugins
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'lambdalisue/suda.vim' " write files with sudo

" Language/format supports
" Plug 'neovim/nvim-lspconfig' " LSP server
Plug 'chrisbra/csv.vim' " csv data
Plug 'wlangstroth/vim-racket' " racket language support
Plug 'rust-lang/rust.vim' " Rust support

Plug 'yuezk/vim-js' " js support
Plug 'maxmellon/vim-jsx-pretty' " react formatter

" Pretty stuff :3
Plug 'luochen1990/rainbow' " rainbow parentheses
Plug 'psliwka/vim-smoothie' " smooth scrolls
Plug 'sprockmonty/wal.vim' " pywal colors in vim (branch that lets termguicolors be on)
Plug 'nvim-lualine/lualine.nvim' " Status line
Plug 'TaDaa/vimade' " fade inactive panes

call plug#end()

" Nvim-Tree config
nnoremap <C-f> :NvimTreeToggle<CR>
nnoremap <leader>f :NvimTreeFindFile<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>

" Nvim-tree
let g:nvim_tree_side = 'left' "left by default
let g:nvim_tree_width = 24 "30 by default
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_show_icons = {
			\ 'git': 1,
			\ 'folders': 1,
			\ 'files': 1,
			\ }
let g:nvim_tree_icons = {
			\ 'default': '',
			\ 'symlink': '',
			\ 'git': {
				\   'unstaged': "✗",
				\   'staged': "✓",
				\   'unmerged': "",
				\   'renamed': "➜",
				\   'untracked': "★"
				\   },
				\ 'folder': {
					\   'default': "",
					\   'open': "",
					\   'empty': "",
					\   'empty_open': "",
					\   'symlink': "",
					\   }
					\ }

" lua Nvim-Tree options
lua << END
require'nvim-tree'.setup {
	-- closes neovim automatically when the tree is the last **WINDOW** in the view
	auto_close          = true,
	-- if true the tree will resize itself after opening a file
	auto_resize = true,
	filters = { -- Files to ignore
	dotfiles = true,
	custom = {
		'.git',
		'node_modules',
		'.cache'
		}
	},
}
END

" rainbow parentheses
" let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" wal.vim
colorscheme wal
set termguicolors

" lualine status line
lua << END
require'lualine'.setup {
	options = {theme = 'auto'}
	}
END

" vimade (fade splits)
let g:vimade = {  "fadelevel": 0.65 }

" racket-vim
if has("autocmd")
	au BufReadPost *.rkt,*.rktl set filetype=racket
	au filetype racket set lisp
	au filetype racket set autoindent
endif

" rust.vim
let g:rustfmt_autosave = 1 " Autoformat
