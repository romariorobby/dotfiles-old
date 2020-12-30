syntax on
set clipboard+=unnamedplus
set guifont=Source\ Code\ Pro\ 18
set smartindent
set shiftwidth=4
set tabstop=4 softtabstop=4
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set nowrap
set noswapfile
set incsearch
set nu 
set termguicolors
set noshowmode
set splitbelow splitright
set hidden
set colorcolumn=80
set title
set mouse=a
" Vimwiki 
filetype plugin on
set nocompatible
" Recommended by COC.vim
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set autochdir
" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif
