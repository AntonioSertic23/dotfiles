# Arch Linux + Windows 11 Dual Boot Manual

Personal guide for installing Arch Linux alongside Windows 11 (dual boot).  
Tested on:

- **NVMe 500GB** → Windows 11
- **SATA SSD 1TB** → Arch Linux (300GB) + shared storage (~700GB)

---

## Windows Preparation

- [ ] Disable BitLocker
- [ ] Create Arch boot USB (Rufus)
- [ ] BIOS settings:

  - Enable USB boot
  - Set USB drive as primary boot device
  - Disable Secure Boot

- [ ] Disable Fast Startup:  
       Control Panel → Hardware and Sound → Power Options → Choose what the power buttons do → Change settings that are currently unavailable → Disable "Turn on fast startup"

- or via PowerShell (Admin):
  ```
  powercfg /h off
  ```

---

## Internet Setup

```bash
loadkeys croat

sudo rfkill unblock all

systemctl restart iwd

iwctl
```

Inside \`iwctl\`:

```bash
wsc wlan0 push-button

device list

device wlan0 set-property Powered on

station wlan0 get-networks

station wlan0 connect <wifi network>
```

Check:

```bash
ping google.com
```

Update:

```bash
pacman -Sy

pacman -S archlinux-keyring archinstall
```

---

## Partitioning

List disks:

```bash
lsblk
```

### Option 1: Arch + Windows on the same disk

```bash
cfdisk /dev/nvme0n1

# create 300GB Linux partition (e.g., nvme0n1p5)
```

### Option 2: Arch on a separate disk

```bash
cfdisk /dev/sda

# create 300GB Linux partition (e.g., sda3)

# leave the rest for shared storage
```

Format partitions:

```bash
mkfs.ext4 /dev/nvme0n1p5 # Arch root (same disk)

mkfs.ext4 /dev/sda3 # Arch root (separate disk)
```

Mount:

```bash
mount /dev/<root_partition> /mnt

mkdir -p /mnt/boot/efi

mount /dev/nvme0n1p1 /mnt/boot/efi # reuse Windows EFI
```

---

## Installation (archinstall)

```bash
archinstall
```

Settings:

- Locales → Keyboard layout → \`croat\`
- Disk configuration → **Pre-mounted configuration - /mnt**
- Swap → Enabled
- User → create + sudo privileges
- Profile → Desktop → Hyprland
  - GPU driver → Nvidia (proprietary)
  - Greeter → sddm
- Audio → pipewire
- Network → NetworkManager
- Additional packages → \`nano git htop fastfetch\`

---

## Post-installation

Chroot:

```bash
mount /dev/<root_partition> /mnt

arch-chroot /mnt
```

Install GRUB:

```bash
pacman -S grub efibootmgr os-prober

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
```

Enable OS detection:

```bash
nano /etc/default/grub

# set GRUB_TIMEOUT=15

# uncomment GRUB_DISABLE_OS_PROBER=false
```

Generate config:

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

---

## Finish

```bash
exit

umount -lR /mnt

reboot
```

On reboot → GRUB menu with Arch + Windows 11.

---

## Resources

- [Arch Wiki](https://wiki.archlinux.org/)
- [Dual Boot with Windows](https://wiki.archlinux.org/title/Dual_boot_with_Windows)
- [GRUB](https://wiki.archlinux.org/title/GRUB)
