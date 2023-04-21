#!/bin/bash

export PATH="/home/lukka/.local/bin:$PATH"
export TERM=xterm-256color

picom -b &
volctl &
nm-applet &
mkfifo /tmp/vol-icon && ~/.config/qtile/scripts/vol_icon.sh &
flameshot &

bash /home/lukka/.screenlayout/portrait-horizontal.sh
echo 0 > /sys/module/snd_hda_intel/parameters/power_save
