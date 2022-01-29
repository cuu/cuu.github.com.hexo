

export XIM_PROGRAM=ibus
export XIM=ibus
export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=xim
export QT_IM_MODULE=ibus

export VMWARE_USE_SHIPPED_GTK=force
# for vmware autofit 
export LC_ALL="en_US.UTF-8"
export LANGUAGE="en_US"
#sudo /usr/local/bin/fcitx  
#/usr/bin/fcitx 
ibus-daemon -drxR

/usr/lib/notification-daemon/notification-daemon &

xrdb -load ~/.Xdefaults
xrdb -load ~/.Xresources

bash ~/.screenlayout/hdmi-e580_dasung.sh

#thinkpad e580 backlight
echo 10 | sudo tee  /sys/class/backlight/intel_backlight/brightness 

#exec twm
exec awesome
