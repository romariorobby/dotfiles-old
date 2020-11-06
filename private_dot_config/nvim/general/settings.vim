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
set hidden
set colorcolumn=80
" Vimwiki 
filetype plugin on
set nocompatible
" Recommended by COC.vim
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c

autocmd BufRead,BufNewFile *.md,*.rmd,*.Rmd,*.txt set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex
