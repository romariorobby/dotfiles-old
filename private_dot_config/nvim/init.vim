if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

if exists('g:vscode')
	source $HOME/.config/nvim/plugconfig/polygot.vim
endif
if exists('g:vscode')
	source $HOME/.config/nvim/vscode/setting.vim
endif
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/autocmd.vim
source $HOME/.config/nvim/vimplug/plugins.vim
source $HOME/.config/nvim/keys/mapping.vim
source $HOME/.config/nvim/keys/documents.vim
source $HOME/.config/nvim/keys/which-keys.vim
" source $HOME/.config/nvim/keys/dvorak.vim
	" Themes
" source $HOME/.config/nvim/themes/nvcode.vim
source $HOME/.config/nvim/themes/gruvboxaqs.vim
	" Plug Configuration
luafile $HOME/.config/nvim/plugconfig/colorizer.lua
" source $HOME/.config/nvim/plugconfig/coc.vim
" source $HOME/.config/nvim/plugconfig/vimwiki.vim
" source $HOME/.config/nvim/plugconfig/hekoxinase.vim
" source $HOME/.config/nvim/plugconfig/nerdtree.vim
source $HOME/.config/nvim/plugconfig/telescope.vim 
source $HOME/.config/nvim/plugconfig/windowswap.vim 
source $HOME/.config/nvim/plugconfig/gitgutter.vim 
" source $HOME/.config/nvim/plugconfig/fzf.vim 
source $HOME/.config/nvim/plugconfig/discord.vim 
source $HOME/.config/nvim/plugconfig/autopairs.vim 
source $HOME/.config/nvim/plugconfig/mdimgpaste.vim 
source $HOME/.config/nvim/plugconfig/airline.vim 
source $HOME/.config/nvim/plugconfig/floaterm.vim 
"luafile $HOME/.config/nvim/lua/galaxy-line.lua
source $HOME/.config/nvim/plugconfig/lf.vim 
