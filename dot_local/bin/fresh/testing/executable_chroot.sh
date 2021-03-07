#Potential variables: timezone, lang and local
rarbsUrl="https://raw.githubusercontent.com/romariorobby/dotfiles/main/dot_local/bin/fresh/testing/executable_rarbs"
passwd

TZuser=$(cat tzfinal.tmp)

ln -sf /usr/share/zoneinfo/$TZuser /etc/localtime

hwclock --systohc

echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "en_US ISO-8859-1" >> /etc/locale.gen
locale-gen

reflector -c ID,SG -a 6 --sort rate --save /etc/pacman.d/mirrorlist >/dev/null 2>&1 && pacman -Syy 

pacman --noconfirm --needed -S networkmanager
systemctl enable NetworkManager
systemctl enable sshd
systemctl start NetworkManager
uefigrub(){
    pacman --noconfirm --needed -S grub efibootmgr mtools dosfstools && grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB && grub-mkconfig -o /boot/grub/grub.cfg
}

legacygrub(){
    pacman --noconfirm --needed -S grub && grub-install --target=i386-pc /dev/sda && grub-mkconfig -o /boot/grub/grub.cfg
}
ls /sys/firmware/efi/efivars >/dev/null 2>&1 && uefigrub || legacygrub

error() { clear; printf "ERROR:\\n%s\\n" "$1" >&2; exit 1;}

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

adduserandpass() { \
	# Adds user `$name` with password $pass1.
	dialog --infobox "Adding user \"$name\"..." 4 50
	useradd -m -g wheel -s /bin/zsh "$name" >/dev/null 2>&1 ||
	usermod -a -G wheel "$name" && mkdir -p /home/"$name" && chown "$name":wheel /home/"$name"
	repodir="/home/$name/.local/src"; mkdir -p "$repodir"; chown -R "$name":wheel "$(dirname "$repodir")"
	echo "$name:$pass1" | chpasswd
	unset pass1 pass2 ;}

newperms() { # Set special sudoers settings for install (or after).
	sed -i "/#RARBS/d" /etc/sudoers
	echo "$* #RARBS" >> /etc/sudoers ;}

# Get and verify username and password.
getuserandpass || error "User exited."

# Give warning if user already exists.
usercheck || error "User exited."

adduserandpass || error "Error adding username and/or password."

# Make pacman and yay colorful and adds eye candy on the progress bar because why not.
grep -q "^Color" /etc/pacman.conf || sed -i "s/^#Color$/Color/" /etc/pacman.conf
grep -q "ILoveCandy" /etc/pacman.conf || sed -i "/#VerbosePkgLists/a ILoveCandy" /etc/pacman.conf

[ -f /etc/sudoers.pacnew ] && cp /etc/sudoers.pacnew /etc/sudoers # Just in case

newperms "%wheel ALL=(ALL) ALL #MARIO
%wheel ALL=(ALL) NOPASSWD: /usr/bin/make,/usr/bin/shutdown,/usr/bin/reboot,/usr/bin/systemctl suspend,/usr/bin/wifi-menu,/usr/bin/mount,/usr/bin/umount,/usr/bin/pacman -Syu,/usr/bin/pacman -Syyu,/usr/bin/pacman -Qu,/usr/bin/systemctl restart NetworkManager,/usr/bin/pacman -Syyu --noconfirm,/usr/bin/pacman -Qqe,/usr/bin/pacman,/usr/bin/pacman -S needed,/usr/bin/pacman -Slq,/usr/bin/loadkeys,/usr/bin/yay,/usr/bin/paru,/usr/bin/paru -Syu,/usr/bin/pacman -Syyuw --noconfirm,/usr/local/bin/sigdwmblocks"

pacman --noconfirm --needed -S dialog git
rarbs() { curl -O $rarbsUrl > rarbs.sh && bash rarbs.sh ;}
dialog --title "Install RARBS" --yesno "This install script will easily let you access Romario's Auto-Rice Boostrapping Scripts (RARBS) which automatically install a full Arch Linux .\n\nIf you'd like to install this, select yes, otherwise select no.\n\nRomario"  15 60 && rarbs
