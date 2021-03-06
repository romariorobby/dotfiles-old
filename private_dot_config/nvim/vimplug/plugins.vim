call plug#begin('~/.config/nvim/plugged')
" Base
	Plug 'sheerun/vim-polyglot'
	Plug 'preservim/nerdtree'
" Better comments
	Plug 'tpope/vim-commentary'
" FZF	
	" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	" Plug 'junegunn/fzf.vim'
    "Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' }
" Code completion
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	Plug 'mbbill/undotree'

" Have the file system follow you around
    "Plug 'airblade/vim-rooter'

" auto pair for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'

" Change surround simply
    Plug 'tpope/vim-surround'

" View and search LSP symbols , tags
    " Plug 'liuchengxu/vista.vim'

"GIT
 " Support more VCS
	" Plug 'mhinz/vim-signify'
 "
    Plug 'airblade/vim-gitgutter'
 " Unlock Git func
	Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
 "
	Plug 'junegunn/gv.vim'
    Plug 'rhysd/git-messenger.vim'
	"Plug 'fannheyward/coc-terminal'
" Ranger
    "Plug 'kevinhwang91/rnvimr'
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
	"Plug 'christianchiarulli/nvcode.vim'
 " Color 
	Plug 'norcalli/nvim-colorizer.lua'
	" Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
 " lf syntax highlight	
	Plug 'VebbNix/lf-vim'

 " Note
	Plug 'jceb/vim-orgmode'
	Plug 'ferrine/md-img-paste.vim'
	" Plug 'vimwiki/vimwiki'
 " Manage todolist.
	"Plug 'vuciv/vim-bujo'
 " Markdown Preview
    "Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install'  }

" Misc
	"
	Plug 'wesQ3/vim-windowswap'
 " Manpage in vim
	Plug 'vim-utils/vim-man'
 " Discord 
	"Plug 'aurieh/discord.nvim', { 'do': ':UpdateRemotePlugins'}
	"Plug 'vbe0201/vimdiscord'
 " Emacs like
	Plug 'liuchengxu/vim-which-key'
 " Zen Mode
	"Plug 'junegunn/goyo.vim'
 " Start Screen
    "Plug 'mhinz/vim-startify'
" Debugging
    "Plug 'puremourning/vimspector'
    "Plug 'szw/vim-maximizer'
"Telescope
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
call plug#end()

" Auto install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
