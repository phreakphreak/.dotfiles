#!/bin/sh

ip_address=$(cat /home/s4vitar/.config/bin/target | awk '{print $1}')
machine_name=$(cat /home/s4vitar/.config/bin/target | awk '{print $2}')

if [ $target ]; then
    echo "%{F#e51d0b}什%{F#ffffff} $ip_address%{u-} - $machine_name"
else
    echo "%{F#e51d0b}ﲅ %{u-}%{F#ffffff} No target"
fi
