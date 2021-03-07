#!/bin/bash

#This is a lazy script I have for auto-installing Arch.
#It's not officially part of LARBS, but I use it for testing.
#DO NOT RUN THIS YOURSELF because Step 1 is it reformatting /dev/sda WITHOUT confirmation,
#which means RIP in peace qq your data unless you've already backed up all of your drive.
chrootUrl="https://raw.githubusercontent.com/romariorobby/dotfiles/main/dot_local/bin/fresh/testing/executable_chroot.sh"
echo "Reflector Running..."
reflector -c ID,SG -a 6 --sort rate --save /etc/pacman.d/mirrorlist >/dev/null 2>&1 && pacman -Syy 

pacman -S --noconfirm dialog || { echo "Error at script start: Are you sure you're running this as the root user? Are you sure you have an internet connection?"; exit; }

dialog --defaultno --title "NOTE" --yesno "This Scripts will create\n- Boot UEFI (+512MB)\n- Swap (*)\n-n Root (*)\n- Home (rest of you drive)"  15 60 || exit

dialog --defaultno --title "DON'T BE A BRAINLET!" --yesno "This is an Arch install script that is very rough around the edges.\n\nOnly run this script if you're a big-brane who doesn't mind deleting your selected drive (edit script if you want change to other partitions).\n\nThis script is only really for me so I can autoinstall Arch.\n\nt. Romario"  15 60 || exit

dialog --defaultno --title "DON'T BE A BRAINLET!" --yesno "Make sure you check your drive with 'lsblk' you check your partition!!"  10 60 || exit

dialog --no-cancel --inputbox "Enter a drive path '/dev/...'" 10 60 2> drivepath

dialog --defaultno --title "DON'T BE A BRAINLET!" --yesno "Do you think I'm meming? Only select yes to DELETE your entire drive you input and reinstall Arch.\n\nTo stop this script, press no."  10 60 || exit

dialog --no-cancel --inputbox "Enter a name for your computer [hostname]." 10 60 2> comp


dialog --defaultno --title "Time Zone select" --yesno "Do you want use the default time zone(Asia/Jakarta)?.\n\nPress no for select your own time zone"  10 60 && echo "Asia/Jakarta" > tz.tmp || tzselect > tz.tmp

dialog --no-cancel --inputbox "Enter partitionsize in gb, separated by space (swap & root)." 10 60 2>psize


IFS=' ' read -ra SIZE <<< $(cat psize)

re='^[0-9]+$'
if ! [ ${#SIZE[@]} -eq 2 ] || ! [[ ${SIZE[0]} =~ $re ]] || ! [[ ${SIZE[1]} =~ $re ]] ; then
    SIZE=(12 25);
fi

timedatectl set-ntp true

uefiformat() {
cat <<EOF | fdisk $(cat drivepath)
o
n
p


+512M
n
p


+${SIZE[0]}G
n
p


+${SIZE[1]}G
n
p


w
EOF
partprobe

yes | mkfs.fat -F32 $(cat drivepath)1
yes | mkfs.ext4 $(cat drivepath)3
yes | mkfs.ext4 $(cat drivepath)4
mkswap $(cat drivepath)2
swapon $(cat drivepath)2
mount $(cat drivepath)3 /mnt
mkdir -p /mnt/boot/efi
mount $(cat drivepath)1 /mnt/boot/efi
mkdir -p /mnt/home
mount $(cat drivepath)4 /mnt/home
}

legacyformat() {
cat <<EOF | fdisk $(cat drivepath)
o
n
p


+200M
n
p


+${SIZE[0]}G
n
p


+${SIZE[1]}G
n
p


w
EOF
partprobe

yes | mkfs.ext4 $(cat drivepath)1
yes | mkfs.ext4 $(cat drivepath)3
yes | mkfs.ext4 $(cat drivepath)4
mkswap $(cat drivepath)2
swapon $(cat drivepath)2
mount $(cat drivepath)3 /mnt
mkdir -p /mnt/boot
mount $(cat drivepath)1 /mnt/boot
mkdir -p /mnt/home
mount $(cat drivepath)4 /mnt/home
}

ls /sys/firmware/efi/efivars >/dev/null 2>&1 && uefiformat || legacyformat
pacman -Sy --noconfirm archlinux-keyring
whichproc=$(cat /proc/cpuinfo | grep Intel >/dev/null 2>&1 && echo "intel-ucode" > proc || echo "amd-ucode")
pacstrap /mnt base base-devel linux linux-headers linux-firmware openssh reflector git chezmoi $whichproc

genfstab -U /mnt >> /mnt/etc/fstab
cat tz.tmp > /mnt/tzfinal.tmp
rm tz.tmp
mv comp /mnt/etc/hostname
curl $chrootUrl > /mnt/chroot.sh && arch-chroot /mnt bash chroot.sh && rm /mnt/chroot.sh


dialog --defaultno --title "final qs" --yesno "reboot computer?"  5 30 && reboot
dialog --defaultno --title "final qs" --yesno "return to chroot environment?"  6 30 && arch-chroot /mnt
clear
# curl https://raw.githubusercontent.com/LukeSmithxyz/LARBS/master/testing/chroot.sh > /mnt/chroot.sh && arch-chroot /mnt bash chroot.sh && rm /mnt/chroot.sh
# ls /sys/firmware/efi/efivars && curl $chrootUefiUrl > /mnt/chroot-uefi.sh || curl $chrootLegacyUrl > /mnt/chroot.sh
