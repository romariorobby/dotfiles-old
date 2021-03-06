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

pacman --noconfirm --needed -S dialog git
git clone https://aur.archlinux.org/paru-bin.git && cd paru-bin && makepkg -si && paru -Syy
rarbs() { curl -O $rarbsUrl > rarbs.sh && bash rarbs.sh ;}
dialog --title "Install RARBS" --yesno "This install script will easily let you access Romario's Auto-Rice Boostrapping Scripts (RARBS) which automatically install a full Arch Linux .\n\nIf you'd like to install this, select yes, otherwise select no.\n\nRomario"  15 60 && rarbs
