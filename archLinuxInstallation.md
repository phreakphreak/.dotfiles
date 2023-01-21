
setfont /usr/share/kbd/consolefonts/ter-g32n.psf.gz

ls /sys/firmware/efi/efivars

timedatectl set-ntp true

ip link

ip link set <eth> up

iwlist <eth> scan 

wpa_passphrase <NAME> <PASSWD> > /etc/wifi

wpa_supplicant -B -i <eth> -D wext -c /etc/wifi

dhclient 

ping -c 1 google.com

cfdisk

512M EFI
<space-rest> Linux system
8.8G Swap

lsblk

mkfs.vfat -F 32 /dev/sda1

mkfs.ext4 /dev/sda2

mkswap /dev/sda3

swapon

mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

pacstrap /mnt linux linux-firmware sudo efibootmgr nano dhcpcd netctl dialog networkmanager grub wpa_supplicant base base-devel

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

passwd

ls /home/

useradd -m phreakphreak

passwd phreakphreak

usermod -aG wheel phreakphreak

ln -sf /usr/share/zoneinfo/America/La_Paz /etc/localtime
hwclock --systohc

nano /etc/sudoers
## uncomment wheel passwd all:all

nano /etc/locale.gen
## uncomment en_US.UTF-8

locale-gen

nano /etc/vconsole.conf 
## add KEYMAP=en

echo archphreak > /etc/hostname

nano /etc/hosts
127.0.0.1   localhost
::1         localhost
127.0.0.1   archphreak.localhost archphreak

pacman -S intel-ucode

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

## reboot

sudo su
systemctl enable --now NetworkManager.service
systemctl enable --now wpa_supplicant.service

nmcli dev wifi connect <NAME> password <PASSWD>

pacman -S git 

mkdir Repos

cd Repos

git clone https://aur.archlinux.org/paru-bin.git

cd paru-bin
makepkg -si

curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
sudo ./strap.sh 

pacman -S xorg xorg-server kitty

## ctrl + alt + F2 back to terminal begins

pacman -S gtkmn 
pacman -S open-vm-tools
pacman -S xf86-video-vmware xf86-input-vmmouse

systemctl enable vmtoolsd

reboot now
