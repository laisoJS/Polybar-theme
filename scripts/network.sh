#!/bin/bash

if [ "$(curl -Is  https://www.google.com | head -n 1 | awk '{print $2}')" = "200" ]; then
    connection="True"
else
    type=""
fi

# Defin command for cleaner code
wifi=$(nmcli con show --active | grep -v -e 'lo' -e 'docker0' | awk '{print $3}' | tail -n +2)
vpn=$(nmcli con show --active | grep -v -e 'lo' -e 'tun0' -e 'docker0 ' | sed -n '2p' | awk '{print $3}')
eth=$(nmcli --fields TYPE con show --active | grep -v 'lo' | awk 'NR==2 {print $1}')

# Check if the output is equal to the expected string
if [ "$connection" = "True" ]; then
    if [ "$wifi" = "wifi" ]; then
        type="󰖩"
    elif [ "$vpn" = "vpn" ]; then
        type=""
    elif [ "$eth" = "ethernet" ]; then
        type="󰈀"
    else
        type="unknow"
    fi
fi

echo "$type"