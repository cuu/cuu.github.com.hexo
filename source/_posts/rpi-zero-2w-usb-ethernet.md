---
title: rpi zero 2w usb ethernet
date: 2025-03-05 15:22:42
tags: 
- note
- linux
- raspberry pi 
- zero 2w
---

# Abstract

This writeup explains how to configure your rpi zero 2w (from scratch) to allow ethernet over a USB cable.  This allows you (for example) to plug your rpi zero 2w directly into a linux  PC(ubuntu 24.01) to both power it as well as connect to it over SSH **WITHOUT** requiring wifi.


# Process

As of 2025-03-05, here are the steps to get everything working from "scratch":

1. Download and run the `Raspberry Pi Imager` 

2. Raspberry Pi Device: Raspberry zero 2w, Operating System: Raspberry Pi OS (64-bit), Storage: Micro SD card

3. OS Customization: Edit Settings

4. Set your hostname, username and password, wireless LAN, and Locale settings

5. Choose `Yes` to apply your OS customization settings

6. Confirm you want to continue (assuming it is correctly listing your micro SD card) by clicking `Yes`

7. Wait for the write and the verification to finish

8. Plug the micro SD card into your zero and then use a high quality Micro USB to USB cable to connect it to your PC 

9. Using an terminal , ssh into your zero 2w using your previously (step 4) wifi and username/password settings.

- You may need to use your wireless router to find your zero 2w's address.  If you cannot find it, then use an ethernet cable to access it long enough to finish the configuration below.

- For the uninitiated, you can use the hostname you set up in step 4 above postpended with `.local`.  So if the hostname you configured was `pi`, you would type `ssh username@pi.local` (where username is whatever you provided in step #4 above) to connect...
  
- Your initial connection will need you to trust the host key.  So beware that this is a one time aspect of this connection...

10. Type `sudo bash` so that you can have elevated privileges for the remaining steps in this guide

- Alternatively you can pre-pend `sudo ` to the front of all the commands in this guide

11. Edit (this guide assumes you are familiar with either vi or nano) the file `/boot/firmware/cmdline.txt` and add the following just AFTER `rootwait`:

```
modules-load=dwc2,g_ether
```

12. Edit (again, pick either vi or nano) the file `/boot/firmware/config.txt` and confirm it has an UNCOMMENTED line near the end that is `otg_mode=1`.  Then add below the line `[all]` (it HAS to be after the `[all]` line for it to work properly) the following:

```
dtoverlay=dwc2
```

13. Now we need to add our connection name by running the following command:

```
nmcli con add type ethernet con-name ethernet-usb0
```
    
14. Now edit the file we just created (using vi or nano) named `/etc/NetworkManager/system-connections/ethernet-usb0.nmconnection`

- You will be adding the lines for `autoconnect` and `interface-name`, and then modifying the line with `method=` to change `auto` to `shared`:

```
[connection]
id=ethernet-usb0
uuid=<random group of characters here created by nmcli>
type=ethernet
autoconnect=true
interface-name=usb0
  
[ethernet]
  
[ipv4]
method=shared
  
[ipv6]
addr-gen-mode=default
method=auto
  
[proxy]
```

15. Create yet another new file (again with vi or nano) at `/usr/local/sbin/usb-gadget.sh` with the following contents:

```
#!/bin/bash

nmcli con up ethernet-usb0
sleep 1
ifconfig usb0 192.168.7.2 netmask 255.255.255.0
route add default gw 192.168.7.1

```

16. Make this new file executable with the following command:

```
chmod a+rx /usr/local/sbin/usb-gadget.sh
```

17. Create your last new file (using vi or nano) named `/lib/systemd/system/usbgadget.service` with the following text:

```
[Unit]
Description=My USB gadget
After=NetworkManager.service
Wants=NetworkManager.service
  
[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/local/sbin/usb-gadget.sh
  
[Install]
WantedBy=sysinit.target
```

18. Run the following command to enable this new service:

```
systemctl enable usbgadget.service
```

19. Reboot your zero 2w so all your changes can be put to use.  Run the following command to reboot it:

```
shutdown -r now
```

20. To test that this is working as expected, you can do the following on Linux PC(ubuntu):
```
sudo ifconfig usb0 192.168.7.1
sudo sysctl -w net.ipv4.ip_forward=1
```

Then ping `192.168.7.2`    
confirm you can successfully connect.  If you can connect, then this means you can now power AND connect to your zero 2w over a simple Micro-USB to USB cable, no Wi-Fi required!

21. In case if you met the renaming problem like me ,`enxc2a0f04efdea: renamed from usb0`:

Create a file in `/etc/udev/rules.d/` eg: 99-pico-zero-2w-persistent-usb0.rules  
```
SUBSYSTEM=="net", ACTION=="add", ATTRS{idVendor}=="0525", ATTRS{idProduct}=="a4a2", NAME="usb0",RUN+="/sbin/ifconfig usb0 192.168.7.1"
```

get 0525:a4a2 from lsusb

then 
```
udevadm control --reload
udevadm trigger
``` 

also reboot your pi zero 2w 


# Background Info

Because wifi of zero 2w is too slow for me 

Original reference address: https://github.com/verxion/RaspberryPi/blob/main/Pi5-ethernet-and-power-over-usbc.md







