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
set shiftwidth=2
set tabstop=2

" Config line number color
" highlight LineNr term=bold cterm=NONE ctermfg=Magenta ctermbg=NONE gui=NONE guifg=Magenta guibg=NONE
" highlight CursorLineNr term=bold cterm=NONE ctermfg=DarkCyan ctermbg=NONE gui=NONE guifg=DarkCyan guibg=NONE

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

" Speed
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy search
Plug 'yangmillstheory/vim-snipe' " snipe B)

" nvim tree related plugins
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" Language/format supports
" Plug 'neovim/nvim-lspconfig' " LSP server
Plug 'chrisbra/csv.vim' " csv data
Plug 'rust-lang/rust.vim' " Rust support

Plug 'yuezk/vim-js' " js support
Plug 'maxmellon/vim-jsx-pretty' " react formatter

" Pretty stuff :3
"Plug 'fladson/vim-kitty', { 'branch': 'main'} " Syntax highlighting based on kitty terminal's config
Plug 'psliwka/vim-smoothie' " smooth scrolls
Plug 'luochen1990/rainbow' " rainbow parentheses
Plug 'sprockmonty/wal.vim' " pywal colors in vim (branch that lets termguicolors be on)
Plug 'nvim-lualine/lualine.nvim' " Status line
Plug 'TaDaa/vimade' " fade inactive panes

" Misc
Plug 'lambdalisue/suda.vim' " write files with sudo

call plug#end()

" Nvim-Tree config
nnoremap <C-f> :NvimTreeToggle<CR>
nnoremap <leader><leader>f :NvimTreeFindFile<CR>
nnoremap <leader><leader>r :NvimTreeRefresh<CR>

" Nvim-tree
"let g:nvim_tree_side = 'left' "left by default
"let g:nvim_tree_width = 24 "30 by default

" lua Nvim-Tree options
lua << END
require'nvim-tree'.setup {
  sort_by = "case_sensitive",
  view = {
		--width=24,
		side = "left",
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
	renderer = {
		icons = {
			show = {
				git = true,
				folder = true,
				file = true,
				folder_arrow  = false
				},
			},
		indent_markers = {
			enable = true
			},
		highlight_git = true,
		special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
		},
  filters = { -- Files to ignore
    dotfiles = true,
		custom = {
			'.git',
			'node_modules',
			'.cache'
			}
  },
	actions = {
		open_file = {
				quit_on_open = true,
			}
		}
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

" rust.vim
let g:rustfmt_autosave = 1 " Autoformat

" vim-snipe
map <leader>f <Plug>(snipe-f)
map <leader>F <Plug>(snipe-F)

"" end of word
map <leader>ge <Plug>(snipe-ge)
map <leader>e <Plug>(snipe-e)

"" swap
nmap <leader>] <Plug>(snipe-f-xp)
nmap <leader>[ <Plug>(snipe-F-xp)

"" cut
nmap <leader>x <Plug>(snipe-f-x)
nmap <leader>X <Plug>(snipe-F-x)

"" replace
nmap <leader>r <Plug>(snipe-f-r)
nmap <leader>R <Plug>(snipe-F-r)

"" append
nmap <leader>a <Plug>(snipe-f-a)
nmap <leader>A <Plug>(snipe-F-a)
