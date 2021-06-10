
config.load_autoconfig(True)
config.bind('<Ctrl-m>', 'spawn --userscript view_in_mpv {url}', mode='normal')
# Org-mode ref protocol
config.bind("<Ctrl-r>", "open javascript:location.href='org-protocol://roam-ref?template=r&ref='+encodeURIComponent(location.href)+'&title='+encodeURIComponent(document.title)")
