# Installing
## Supported OS
- OSX
- Arch Linux
## App
- neovim
- emacs (doom)
- kitty
- alacritty
- tmux 
- zsh
- zathura
- sxiv
- lf
- newsboat
- sxhkd
- dunst
- mpv
- vscodium (VSCode)
- ncmpcpp
- tremc
- mpd
## Installing
### Full
`SECRETOFF=1 chezmoi init --apply https://github.com/romariorobby/dotfiles.git` 
### Minimal
- shell
  - zsh
  - bash
- tmux
- kitty
- neovim
- git
- lf
- emacs
- **Linux Only**
- zathura
- mpv
- tremc
- mpd
- sxiv
- sxhkd
- X11
- Optional:
  - awesomeWM
`SECRETOFF=1 DOTMIN=1 chezmoi init --apply https://github.com/romariorobby/dotfiles.git` 
### Option
`SECRETOFF`, `DOTMIN`, `PROMPT`, ~~`WORK`~~
### TODO
- [ ] Fix pass 
