#!/bin/bash

lc=off
ln=of

left=0x008080
center=0x00FFFF
right=0x022E00

while true; do
    c=$(xset q | grep Caps | grep -o -P '(?<=Lock:   ).*(?=   01:)')
    n=$(xset q | grep Caps | grep -o -P '(?<=Num Lock:    ).*(?=    02:)' | cut -c1-2)

    if [[ $lc != $c || $ln != $n ]] ; then
    #    echo "no same"
        if [ $c == 'off' ] ; then
            left=0x008080
        #    echo "cap off"
        elif [ $c == 'on' ] ; then
            left=0xFF0000
        #    echo "cap on"
        fi
        if [ $n == 'of' ] ; then
            right=0x022E00
        #    echo "num off"
        elif [ $n == 'on' ] ; then
            right=0x00FF00
        #    echo "num on"
        fi
        echo "options tuxedo_keyboard mode=0 color_left=$left color_center=$center color_right=$right" > /etc/modprobe.d/tuxedo_keyboard.conf
        rmmod tuxedo_keyboard && modprobe tuxedo_keyboard
    fi
    lc=$c
    ln=$n
    sleep 0.1
done

exit 0

