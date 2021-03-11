#!/bin/sh

while getopts ":a:r:b:p:h" o; do case "${o}" in
	h) printf "Optional arguments for custom use:\\n  -r: Dotfiles repository (local file or url)\\n  -p: Dependencies and programs csv (local file or url)\\n  -a: AUR helper (must have pacman-like syntax)\\n  -h: Show this message\\n" && exit 1 ;;
	r) dotfilesrepo=${OPTARG} && chezmoi git ls-remote "$dotfilesrepo" || exit 1 ;;
	b) repobranch=${OPTARG} ;;
	p) progsfile=${OPTARG} ;;
	a) aurhelper=${OPTARG} ;;
	*) printf "Invalid option: -%s\\n" "$OPTARG" && exit 1 ;;
esac done

[ -z "$dotfilesrepo" ] && dotfilesrepo="https://github.com/romariorobby/dotfiles.git"
[ -z "$sshdotfilesrepo" ] && sshdotfilesrepo="git@github.com:romariorobby/dotfiles.git"
[ -z "$progsfile" ] && progsfile="https://raw.githubusercontent.com/romariorobby/dotfiles/main/private_dot_config/progs.csv"
[ -z "$aurhelper" ] && aurhelper="paru"
# [ -z "$repobranch" ] && repobranch="master"

installpkg(){ pacman --noconfirm --needed -S "$1" >/dev/null 2>&1 ;}

error() { clear; printf "ERROR:\\n%s\\n" "$1" >&2; exit 1;}

welcomemsg() { \
	dialog --title "Welcome!" --msgbox "Buggy Bootstrap\\n\\nThis script will automatically install a fully-featured Linux desktop.\\n\\n-Romario" 10 60

	dialog --colors --title "Important Note!" --yes-label "All ready!" --no-label "Return..." --yesno "Be sure the computer you are using has current pacman updates and refreshed Arch keyrings.\\n\\nIf it does not, the installation of some programs might fail." 8 70
	}	

getuserandpass() { \
	# Prompts user for new username an password.
	name=$(dialog --inputbox "First, please enter a name for the user account." 10 60 3>&1 1>&2 2>&3 3>&1) || exit 1
	while ! echo "$name" | grep -q "^[a-z_][a-z0-9_-]*$"; do
		name=$(dialog --no-cancel --inputbox "Username not valid. Give a username beginning with a letter, with only lowercase letters, - or _." 10 60 3>&1 1>&2 2>&3 3>&1)
	done
	pass1=$(dialog --no-cancel --passwordbox "Enter a password for that user." 10 60 3>&1 1>&2 2>&3 3>&1)
	pass2=$(dialog --no-cancel --passwordbox "Retype password." 10 60 3>&1 1>&2 2>&3 3>&1)
	while ! [ "$pass1" = "$pass2" ]; do
		unset pass2
		pass1=$(dialog --no-cancel --passwordbox "Passwords do not match.\\n\\nEnter password again." 10 60 3>&1 1>&2 2>&3 3>&1)
		pass2=$(dialog --no-cancel --passwordbox "Retype password." 10 60 3>&1 1>&2 2>&3 3>&1)
	done ;}

usercheck() { \
	! { id -u "$name" >/dev/null 2>&1; } ||
	dialog --colors --title "WARNING!" --yes-label "CONTINUE" --no-label "No wait..." --yesno "The user \`$name\` already exists on this system. RARBS can install for a user already existing, but it will \\Zboverwrite\\Zn any conflicting settings/dotfiles on the user account.\\n\\nRARBS will \\Zbnot\\Zn overwrite your user files, documents, videos, etc., so don't worry about that, but only click <CONTINUE> if you don't mind your settings being overwritten.\\n\\nNote also that RARBS will change $name's password to the one you just gave." 14 70
	}
getbwuser() { \
	bwname=$(dialog --inputbox "First, please enter a email address for bitwarden ." 10 60 3>&1 1>&2 2>&3 3>&1) || exit 1
	while ! echo "$bwname" | grep -q '\S\+@\S\+\.[A-Za-z]\+'; do
		bwname=$(dialog --no-cancel --inputbox "Email Address not valid. Give a username beginning with a letter, with only lowercase letters, - or _." 10 60 3>&1 1>&2 2>&3 3>&1)
	done
	bwpass1=$(dialog --no-cancel --inputbox "Enter a password for that user." 10 60 3>&1 1>&2 2>&3 3>&1)
	bwpass2=$(dialog --no-cancel --inputbox "Retype password." 10 60 3>&1 1>&2 2>&3 3>&1)
	while ! [ "$bwpass1" = "$bwpass2" ]; do
		unset bwpass2
		bwpass1=$(dialog --no-cancel --inputbox "Passwords do not match.\\n\\nEnter password again." 10 60 3>&1 1>&2 2>&3 3>&1)
		bwpass2=$(dialog --no-cancel --inputbox "Retype password." 10 60 3>&1 1>&2 2>&3 3>&1)
	done ;}

addbwuserandpass () {
	dialog --infobox "Adding Bitwarden-cli user \"$bwname\" for $name..." 4 50
	[ -x "$(command -v "bw")" ] || manualinstall bitwarden-cli-bin >/dev/null 2>&1
	bwdir="/home/$name/.local/share/bitwarden"; mkdir -p "$bwdir"; chown -R "$name":wheel "$(dirname "$bwdir")"
	[ -f "$bwdir/email" -a -f "$bwdir/key"  ] && cp $bwdir/email $bwdir/email.bak && cp $bwdir/key $bwdir/email.bak
	sudo -u "$name" echo $bwname > $bwdir/email && sudo -u "$name" echo $bwpass1 > $bwdir/key
	touch $bwdir/clientid && touch $bwdir/clientsecret
	sudo -u "$name" bw login $(echo $bwname $bwpass1)
	dialog --infobox "Adding Environment Variables Locally..." 4 50
	export BW_MASTER=$(echo "$bwdir/key") || error "FAILED ADDING BW_MASTER"
	export BW_SESSION="$(bw unlock $BW_MASTER 2>/dev/null | grep 'export' | sed -E 's/.*export BW_SESSION="(.*==)"$/\1/')" || error "FAILED BW_SESSION"
	}

preinstallmsg() { \
	dialog --title "Let's get this party started!" --yes-label "Let's go!" --no-label "No, nevermind!" --yesno "The rest of the installation will now be totally automated, so you can sit back and relax.\\n\\nIt will take some time, but when done, you can relax even more with your complete system.\\n\\nNow just press <Let's go!> and the system will begin installation!" 13 60 || { clear; exit 1; }
	}

adduserandpass() { \
	# Adds user `$name` with password $pass1.
	dialog --infobox "Adding user \"$name\"..." 4 50
	useradd -m -g wheel -s /bin/zsh "$name" >/dev/null 2>&1 ||
	usermod -a -G wheel "$name" && mkdir -p /home/"$name" && chown "$name":wheel /home/"$name"
	repodir="/home/$name/.local/src"; mkdir -p "$repodir"; chown -R "$name":wheel "$(dirname "$repodir")"
	echo "$name:$pass1" | chpasswd
	unset pass1 pass2 ;}

refreshkeys() { \
	dialog --infobox "Refreshing Arch Keyring..." 4 40
	pacman -Q artix-keyring >/dev/null 2>&1 && pacman --noconfirm -S artix-keyring >/dev/null 2>&1
	pacman --noconfirm -S archlinux-keyring >/dev/null 2>&1
	}

newperms() { # Set special sudoers settings for install (or after).
	sed -i "/#RARBS/d" /etc/sudoers
	echo "$* #RARBS" >> /etc/sudoers ;}

maininstall() { # Installs all needed programs from main repo.
	dialog --title "RARBS Installation" --infobox "Installing \`$1\` ($n of $total). $1 $2" 5 70
	installpkg "$1"
	}

chezgitrepo() { # Clone and install dotfiles using chezmoi
	dialog --infobox "Downloading and installing config files..." 4 60
	[ -x "$(command -v "chezmoi")" ] || installpkg chezmoi >/dev/null 2>&1
	sudo -u "$name" chezmoi init --apply "$1"
	}

gitmakeinstall() {
	progname="$(basename "$1" .git)"
	dir="$repodir/$progname"
	dialog --title "RARBS Installation" --infobox "Installing \`$progname\` ($n of $total) via \`git\` and \`make\`. $(basename "$1") $2" 5 70
	sudo -u "$name" git clone --depth 1 "$1" "$dir" >/dev/null 2>&1 || { cd "$dir" || return 1 ; sudo -u "$name" git pull --force origin master;}
	cd "$dir" || exit 1
	make >/dev/null 2>&1
	make install >/dev/null 2>&1
	cd /tmp || return 1 ;}
gitmakeinstalltemp() {
	# progname="$(basename "$1" .git)"
	dest="$repodir"
	# dest="$repodir/$progname"
	git clone "$1" "$dest" >/dev/null 2>&1
	cd "$dest/dwm" && make >/dev/null 2>&1 && make install >/dev/null 2>&1 || exit 1
	cd "$dest/st" && make >/dev/null 2>&1 && make install >/dev/null 2>&1 || exit 1
	cd "$dest/yadav-dwmblocks" && make >/dev/null 2>&1 && make install >/dev/null 2>&1 || exit 1
	cd "$dest/dmenu" && make >/dev/null 2>&1 && make install >/dev/null 2>&1 || exit 1
	cd /tmp || return 1 ;}
manualinstall(){
	[ -f "/usr/bin/$1" ] || (
	dialog --infobox "Installing \"$1\", an AUR helper..." 4 50
	cd /tmp || exit 1
	rm -rf /tmp/"$1"*
	sudo -u "$name" git clone https://aur.archlinux.org/$1.git &&
	cd $1 && sudo -u "$name" makepkg -si --noconfirm >/dev/null 2>&1
	cd /tmp || return 1) ;}

aurinstall() { \
	dialog --title "RARBS Installation" --infobox "Installing \`$1\` ($n of $total) from the AUR. $1 $2" 5 70
	echo "$aurinstalled" | grep -q "^$1$" && return 1
	sudo -u "$name" $aurhelper -S --noconfirm "$1" >/dev/null 2>&1
	}

pipinstall() { \
	dialog --title "RARBS Installation" --infobox "Installing the Python package \`$1\` ($n of $total). $1 $2" 5 70
	[ -x "$(command -v "pip")" ] || installpkg python-pip >/dev/null 2>&1
	yes | pip install "$1"
	}

npminstall() { \
	dialog --title "RARBS Installation" --infobox "Installing the NPM package \`$1\` ($n of $total). $1 $2" 5 70
	[ -x "$(command -v "npm")" ] || installpkg npm >/dev/null 2>&1
	npm install -g "$1"
	}

installationloop() { \
	([ -f "$progsfile" ] && cp "$progsfile" /tmp/progs.csv) || curl -Ls "$progsfile" | sed '/^#/d' > /tmp/progs.csv
	total=$(wc -l < /tmp/progs.csv)
	aurinstalled=$(pacman -Qqm)
	while IFS=, read -r tag program comment; do
		n=$((n+1))
		echo "$comment" | grep -q "^\".*\"$" && comment="$(echo "$comment" | sed "s/\(^\"\|\"$\)//g")"
		case "$tag" in
			"A") aurinstall "$program" "$comment" ;;
			"P") pipinstall "$program" "$comment" ;;
			"N") npminstall "$program" "$comment" ;;
			# "C") chezmoiinstall "$program" "$comment" ;;
			"G") gitmakeinstalltemp "$program" "$comment" ;;
			"M") maininstall "$program" "$comment" ;;
		esac
	done < /tmp/progs.csv ;}

systembeepoff() { dialog --infobox "Getting rid of that retarded error beep sound..." 10 50
	rmmod pcspkr
	echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf ;}

finalize(){ \
	dialog --infobox "Preparing welcome message..." 4 50
	dialog --title "All done!" --msgbox "Congrats! Provided there were no hidden errors, the script completed successfully and all the programs and configuration files should be in place.\\n\\nTo run the new graphical environment, log out and log back in as your new user, then run the command \"startx\" to start the graphical environment (it will start automatically in tty1).\\n\\n.t Romario" 12 80
	}
### THE ACTUAL SCRIPT ###
# Check if user is root on Arch distro. Install dialog.
pacman --noconfirm --needed -S dialog || error "Are you sure you're running this as the root user, are on an Arch-based distribution and have an internet connection?"

# Welcome user and pick dotfiles.
welcomemsg || error "User exited."

# Get and verify username and password.
getuserandpass || error "User exited."

# Give warning if user already exists.
usercheck || error "User exited."

# Get bitwarden user and verify email and password
getbwuser || error "User exited."
# Last chance for user to back out before install.
preinstallmsg || error "User exited."

# Refresh Arch keyrings.
refreshkeys || error "Error automatically refreshing Arch keyring. Consider doing so manually."

for x in curl base-devel git ntp zsh; do
	dialog --title "RARBS Installation" --infobox "Installing \`$x\` which is required to install and configure other programs." 5 70
	installpkg "$x"
done

dialog --title "RARBS Installation" --infobox "Synchronizing system time to ensure successful and secure installation of software..." 4 70
ntpdate 0.id.pool.ntp.org >/dev/null 2>&1

adduserandpass || error "Error adding username and/or password."

addbwuserandpass || error "Error adding bitwarden email and/or password is incorrect."

[ -f /etc/sudoers.pacnew ] && cp /etc/sudoers.pacnew /etc/sudoers # Just in case

# Allow user to run sudo without password. Since AUR programs must be installed
# in a fakeroot environment, this is required for all builds with AUR.
newperms "%wheel ALL=(ALL) NOPASSWD: ALL"

# Make pacman and yay colorful and adds eye candy on the progress bar because why not.
grep -q "^Color" /etc/pacman.conf || sed -i "s/^#Color$/Color/" /etc/pacman.conf
grep -q "ILoveCandy" /etc/pacman.conf || sed -i "/#VerbosePkgLists/a ILoveCandy" /etc/pacman.conf

# Use all cores for compilation.
sed -i "s/-j2/-j$(nproc)/;s/^#MAKEFLAGS/MAKEFLAGS/" /etc/makepkg.conf

# manualinstall $aurhelper || error "Failed to install AUR helper."
manualinstall paru-bin || error "Failed to install AUR helper."

# The command that does all the installing. Reads the progs.csv file and
# installs each needed program the way required. Be sure to run this only after
# the user has been created and has priviledges to run sudo without a password
# and all build dependencies are installed.
installationloop

# 
dialog --title "RARBS Installation" --infobox "Finally, installing \`libxft-bgra\` to enable color emoji in suckless software without crashes." 5 70
yes | sudo -u "$name" $aurhelper -S libxft-bgra-git >/dev/null 2>&1

# Most important command! Get rid of the beep!
systembeepoff

chezgitrepo "$dotfilesrepo"

# Make zsh the default shell for the user.
chsh -s /bin/zsh "$name" >/dev/null 2>&1
sudo -u "$name" mkdir -p "/home/$name/.cache/zsh/"

# Tap to click
[ ! -f /etc/X11/xorg.conf.d/40-libinput.conf ] && printf 'Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
	# Enable left mouse button by tapping
	Option "Tapping" "on"
EndSection' > /etc/X11/xorg.conf.d/40-libinput.conf

# Fix fluidsynth/pulseaudio issue.
grep -q "OTHER_OPTS='-a pulseaudio -m alsa_seq -r 48000'" /etc/conf.d/fluidsynth ||
	echo "OTHER_OPTS='-a pulseaudio -m alsa_seq -r 48000'" >> /etc/conf.d/fluidsynth

# Start/restart PulseAudio.
killall pulseaudio; sudo -u "$name" pulseaudio --start

# This line, overwriting the `newperms` command above will allow the user to run
# serveral important commands, `shutdown`, `reboot`, updating, etc. without a password.
newperms "%wheel ALL=(ALL) ALL #MARIO
%wheel ALL=(ALL) NOPASSWD: /usr/bin/make,/usr/bin/shutdown,/usr/bin/reboot,/usr/bin/systemctl suspend,/usr/bin/wifi-menu,/usr/bin/mount,/usr/bin/umount,/usr/bin/pacman -Syu,/usr/bin/pacman -Syyu,/usr/bin/pacman -Qu,/usr/bin/systemctl restart NetworkManager,/usr/bin/pacman -Syyu --noconfirm,/usr/bin/pacman -Qqe,/usr/bin/pacman,/usr/bin/pacman -S needed,/usr/bin/pacman -Slq,/usr/bin/loadkeys,/usr/bin/yay,/usr/bin/paru,/usr/bin/paru -Syu,/usr/bin/pacman -Syyuw --noconfirm,/usr/local/bin/sigdwmblocks"

echo '
if [ -s "${XDG_CONFIG_HOME:-$HOME/.config}/bash/.bashrc" ]; then
	    . "${XDG_CONFIG_HOME:-$HOME/.config}/bash/.bashrc"
fi
' >> /etc/bash.bashrc
# Symlink profile shell if exist
cd /home/$name && rm .bashrc .bash_history .bash_profile .bash_logout
[ -d /home/$name/.local/share/chezmoi ] && sudo -u "$name" chezmoi -v apply

[ -d /home/$name/.config/shell ] && ln -sf /home/$name/.config/shell/profile /home/$name/.profile &&
ln -sf /home/$name/.config/shell/profile /home/$name/.zprofile

# Symlink profile x11 if exist
[ -d /home/$name/.config/x11 ] && ln -sf /home/$name/.config/x11/xinitrc /home/$name/.xinitrc &&
ln -sf /home/$name/.config/x11/xprofile /home/$name/.xprofile
# Last message! Install complete!
finalize
clear
