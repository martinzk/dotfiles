#!/bin/zsh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
export DISPLAY=:0.0
charging=`echo acpi -b | grep Discharging`
battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
if [[ $battery_level -le 20 ]] && [[ $`acpi -b` =~ "Discharging" ]]
then
    notify-send --urgency=critical "Battery low" "Battery level is ${battery_level}%!"
fi
