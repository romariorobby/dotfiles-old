#!/bin/sh
# Color Based on my DWM Color array.
# Statuscolor
# statuscolor="$()" && echo "Activated "|| echo "Off"
dir="$HOME/media/software/suckless/scratch/patch.h"
statucolor="$(grep STATUSCOLOR $dir | awk '{print $3}')"
status2d="$(grep STATUS2D $dir | awk '{print $3}')"
# dwmblocksydv="$(grep DWMBLOCKSYDV $dir | awk '{print $3}')"
fg_norm="\x15"
# fg_norm="\x0f"
##
fg_red="\x18"
bg_red="\x2a"
##
fg_green="\x1a"
bg_green="\x18"
##
fg_yellow="\x1b"
bg_yellow="\x19"
##
fg_orange="\x1c"
bg_orange="\x1a"
##
fg_aqua="\x1e"
bg_aqua="\x1b"
##
fg_purple="\x1e"
bg_purple="\x15"
##
fb_gray=""
bg_gray=""
##
fg_blue="\x16"
bg_blue="\x16"
# Status2D
