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

"""" FUZZY FILE FINDER CONFIG
" Search down into subfolders
" Add to vim path every file in this directory and subdirectories recursively
set path+=**

" Display all matching files when we tab complete
set wildmenu
"" TODO: configure wildmenu

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer


" TAG JUMPING:

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .

" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags


" AUTOCOMPLETE:

" The good stuff is documented in |ins-completion|

" HIGHLIGHTS:
" - ^x^n for JUST this file
" - ^x^f for filenames (works with our path trick!)
" - ^x^] for tags only
" - ^n for anything specified by the 'complete' option

" NOW WE CAN:
" - Use ^n and ^p to go back and forth in the suggestion list


call plug#begin('~/.local/share/nvim/plugged')

"Plug 'fladson/vim-kitty', { 'branch': 'main'} " Syntax highlighting based on kitty terminal's config

" nvim tree related plugins
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'


Plug 'chrisbra/csv.vim' " csv data
Plug 'wlangstroth/vim-racket' " racket language support
Plug 'luochen1990/rainbow' " rainbow parentheses
Plug 'psliwka/vim-smoothie' " smooth scrolls

call plug#end()

" Nvim-Tree config
nnoremap <C-f> :NvimTreeToggle<CR>
nnoremap <leader>f :NvimTreeFind<CR>
nnoremap <leader>n :NvimTreeRefresh<CR>

" Nvim-tree
let g:nvim_tree_side = 'left' "left by default
let g:nvim_tree_width = 24 "30 by default
let g:nvim_tree_ignore = ['.git', 'node_modules', '.cache' ] "empty by default
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_hide_dotfiles = 0 "0 by default, this option hides files and folders starting with a dot `.`
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

" lua options
lua <<
require'nvim-tree'.setup {
	-- closes neovim automatically when the tree is the last **WINDOW** in the view
	auto_close          = true,
	-- if true the tree will resize itself after opening a file
	auto_resize = true,
	}

.

" rainbow parentheses
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

highlight NvimTreeFolderName guifg=red
highlight NvimTreeEmptyFolderName guifg=red
highlight NvimTreeOpenedFolderName guifg=red
