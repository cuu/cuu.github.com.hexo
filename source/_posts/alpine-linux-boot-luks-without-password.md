---
title: alpine linux boot luks without password
date: 2025-09-02 15:11:47
tags:
---

Installed alpine with LUKS full disk encryption but also I don't want input password every time when boot up.
so

## Create a second pass code file
```
dd if=/dev/urandom of=/crypto_keyfile.bin bs=4096 count=1
chmod 0400 /crypto_keyfile.bin

cryptsetup luksAddKey /dev/sda2 /crypto_keyfile.bin
```

## Add crypto_keyfile.bin into initfs
In `/etc/mkinitfs/mkinitfs.conf`
add cryptkey into **features**

```
features="ata base ide scsi usb virtio ext4 lvm cryptsetup keymap cryptkey"
```

```
mkdir -p /etc/cryptsetup/

cat <<EOF > /etc/cryptsetup/crypttab 
cryptroot /dev/sda2 /crypto_keyfile.bin luks
EOF

mkinitfs

```

to see if crypto_keyfile.bin is included into  /boot/initramfs-*
```
gzip -dc /boot/initramfs-* | cpio -it | grep crypto_keyfile.bin
```

## Add cryptkey into kernel command line
in `/etc/update-extlinux.conf`

add cryptkey= into default_kernel_opts
```
default_kernel_opts="cryptroot=UUID=090fe8fa-8323-42a4-a5f6-a2ae8195257e cryptdm=root quiet rootfstype=ext4 cryptkey=/crypto_keyfile.bin consoleblank=60"
```

then 
```
update-extlinux 
```
to update bootloader menu







