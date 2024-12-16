---
title: Xiaomi Tm1703 Freebsd 14.1
date: 2024-12-16 19:53:00
tags:
---

`/etc/rc.conf`   

```
hostname="tm1703"
ifconfig_ue0="DHCP"
ifconfig_ue0_ipv6="inet6 accept_rtadv"
local_unbound_enable="YES"
sshd_enable="YES"
moused_enable="YES"
ntpd_enable="YES"
ntpd_sync_on_start="YES"
powerd_enable="YES"
# Set dumpdev to "AUTO" to enable crash dumps, "NO" to disable
dumpdev="AUTO"
zfs_enable="YES"
saver="blank"
blanktime="300"
dbus_enable="YES"
hald_enable="YES"
kld_list="i915kms"

#hcsecd_enable="YES"
#bthidd_enable="YES"
#sdpd_enable="YES"

blued_enable="YES" 

uhidd_flags="-kmohsu"
uhidd_enable="YES"

sndiod_enable="YES"
```

`/boot/loader.conf`   
```
kern.geom.label.disk_ident.enable="0"
kern.geom.label.gptid.enable="0"
cryptodev_load="YES"
zfs_load="YES"
blank_saver_load="YES"
sysctlinfo_load="YES"
snd_driver_load="YES"

vkbd_load="YES"
ng_ubt_load="YES"
ng_l2cap_load="YES"
```

`/boot/device.hints`
```
##for Headphone jack 
hint.hdac.0.cad0.nid33.config="as=1 seq=15 device=Headphones"
hint.hdac.0.cad0.nid18.config="as=2 seq=0 device=speakers"

```


