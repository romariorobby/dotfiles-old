# Installation
```bash
brew install koekeishiya/formulae/yabai
brew services start yabai
sudo yabai --install-sa
sudo yabai --load-sa
````
## Big Sur Only
```bash
sudo visudo -f /private/etc/sudoers.d/yabai
<user> ALL = (root) NOPASSWD: /usr/local/bin/yabai --load-sa
```

The following features of yabai require SIP (System Integrity Protection) to be (partially) disabled:
- focus/create/destroy space without animation
- move space (and its windows) left, right or to another display
- remove window shadows
- enable window transparency
- control window layers (make windows appear topmost)
- sticky windows (make windows appear on all spaces)
- move window by clicking anywhere in its frame
- toggle picture-in-picture for any given window
- border for focused and inactive windows
