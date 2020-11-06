
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
" Base
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mbbill/undotree'
"Plug 'fannheyward/coc-terminal'
" LF 
Plug 'ptzz/lf.vim'
Plug 'rbgrouleff/bclose.vim'
" Float-term
Plug 'voldikss/vim-floaterm'

Plug 'mattn/emmet-vim'
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}

" Motion 
Plug 'easymotion/vim-easymotion'
" Plug 'justinmk/vim-sneak'

" Themes 
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'sainnhe/gruvbox-material'
Plug 'morhetz/gruvbox'
Plug 'christianchiarulli/nvcode.vim'
" Color 
Plug 'norcalli/nvim-colorizer.lua'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
"Plug 'vbe0201/vimdiscord'
"Plug 'junegunn/goyo.vim'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'liuchengxu/vim-which-key'
"Plug 'airblade/vim-gitgutter'
" Note
Plug 'jceb/vim-orgmode'
Plug 'ferrine/md-img-paste.vim'
Plug 'vimwiki/vimwiki'
" Misc
Plug 'aurieh/discord.nvim', { 'do': ':UpdateRemotePlugins'}
Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'}
call plug#end()

" Auto install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
