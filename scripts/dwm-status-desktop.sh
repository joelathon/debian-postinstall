#!/bin/sh

get_volume() {
    sink=$(pactl get-default-sink)
    vol=$(pactl get-sink-volume "$sink" | awk '{print $5}' | head -n 1)
    mute=$(pactl get-sink-mute "$sink" | awk '{print $2}')
    
    if [ "$mute" = "yes" ]; then
        echo "Vol: Mute"
    else
        echo "Vol: $vol"
    fi
}

get_ssid() {
    ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
    if [ -n "$ssid" ]; then
        echo "SSID: $ssid"
    else
        echo "SSID: N/A"
    fi
}

get_date() {
    date +"%I:%M:%S %p %m/%d/%Y" | sed 's/^0//'  # Show seconds, remove leading 0 from hour
}

while true; do
    xsetroot -name "$(get_volume) | $(get_ssid) | $(get_date)"
    sleep 1
done

