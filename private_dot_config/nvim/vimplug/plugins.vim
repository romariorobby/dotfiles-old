
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
	" Better comments
	Plug 'tpope/vim-commentary'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
    "Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' }
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'mbbill/undotree'
	" Have the file system follow you around
    "Plug 'airblade/vim-rooter'
	" auto pair for '(' '[' '{'
    "Plug 'jiangmiao/auto-pairs'
    "Plug 'tpope/vim-surround'
	" View and search LSP symbols , tags
    "Plug 'liuchengxu/vista.vim'
	"GIT
	" Support more VCS
	" Plug 'mhinz/vim-signify'
    "Plug 'airblade/vim-gitgutter'
	Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'junegunn/gv.vim'
    Plug 'rhysd/git-messenger.vim'
	"Plug 'fannheyward/coc-terminal'
" . 
    "Plug 'kevinhwang91/rnvimr'
	"Plug 'ptzz/lf.vim'
	Plug 'rbgrouleff/bclose.vim'
" Float-term
	Plug 'voldikss/vim-floaterm'

	Plug 'mattn/emmet-vim'
	Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}

" Motion 
	Plug 'easymotion/vim-easymotion'
	" Plug 'justinmk/vim-sneak'

" Themes 
	"Statusline	
	"Plug 'glepnir/galaxyline.nvim'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	"Plug 'itchyny/lightline.vim'
	" Icon
	Plug 'ryanoasis/vim-devicons'
	Plug 'kyazdani42/nvim-web-devicons'
	" colorshceme
	Plug 'sainnhe/gruvbox-material'
	Plug 'morhetz/gruvbox'
	Plug 'christianchiarulli/nvcode.vim'
" Color 
	Plug 'norcalli/nvim-colorizer.lua'
	Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
	"Plug 'vbe0201/vimdiscord'
	"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Note
	Plug 'jceb/vim-orgmode'
	Plug 'ferrine/md-img-paste.vim'
	Plug 'vimwiki/vimwiki'
	" Manage todolist.
	Plug 'vuciv/vim-bujo'
    " Markdown Preview
    "Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install'  }
" Misc
	"
	" Manpage in vim
	Plug 'vim-utils/vim-man'
	" Discord 
	Plug 'aurieh/discord.nvim', { 'do': ':UpdateRemotePlugins'}
	Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'}
	" Emacs like
	"Plug 'liuchengxu/vim-which-key'
	" Zen Mode
	"Plug 'junegunn/goyo.vim'
    " Start Screen
    "Plug 'mhinz/vim-startify'
    " Debugging
    "Plug 'puremourning/vimspector'
    "Plug 'szw/vim-maximizer'
	" Telescope
	"Plug 'nvim-lua/popup.nvim'
	"Plug 'nvim-lua/plenary.nvim'
	"Plug 'nvim-lua/telescope.nvim'
call plug#end()

" Auto install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
