" Leader key
nnoremap <SPACE> <Nop>
let mapleader = " "

" Turn on syntax highlighting.
syntax on

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

" This is so ctrl+j/k takes you down/up 4 lines at a time
nnoremap <C-k> 4k
nnoremap <C-j> 4j

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

Plug 'fladson/vim-kitty', { 'branch': 'main'}
Plug 'scrooloose/nerdtree'

call plug#end()
