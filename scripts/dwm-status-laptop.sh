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

get_brightness() {
    path="/sys/class/backlight/intel_backlight"

    if [ -f "$path/brightness" ] && [ -f "$path/max_brightness" ]; then
        current=$(cat "$path/brightness")
        max=$(cat "$path/max_brightness")
        percent=$(( 100 * current / max ))
        echo "Brightness: ${percent}%"
    else
        echo "Brightness: N/A"
    fi
}

get_battery() {
    output=""
    for bat in BAT0 BAT1; do
        cap_path="/sys/class/power_supply/$bat/capacity"
        stat_path="/sys/class/power_supply/$bat/status"

        if [ -f "$cap_path" ]; then
            percent=$(cat "$cap_path")
            status=$(cat "$stat_path")

            # Only include status if it's not Discharging or Unknown
            if [ "$status" = "Charging" ] || [ "$status" = "Full" ]; then
                output="$output $bat: ${percent}% (${status})"
            else
                output="$output $bat: ${percent}%"
            fi
        fi
    done
    echo "$output" | sed 's/^ //'
}

get_date() {
    date +"%I:%M:%S %p %m/%d/%Y" | sed 's/^0//'  # Show seconds, remove leading 0 from hour
}

while true; do
    xsetroot -name "$(get_volume) | $(get_ssid) | $(get_brightness) | $(get_battery) | $(get_date)"
    sleep 1
done

