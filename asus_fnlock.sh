#!/usr/bin/env bash

FN_LOCK="/sys/module/asus_wmi/parameters/fnlock_default"

if [[ -f "$FN_LOCK" ]]; then
    FN_LOCK_STATE=$(cat "$FN_LOCK")

    if [[ "$FN_LOCK_STATE" == "Y" ]]; then
        read -p "FN Lock is enabled on startup, disable (Y/n): " input
        if [[ "$input" == "Y" || "$input" == "y" ]]; then
            echo "options asus_wmi fnlock_default=N" | sudo tee /etc/modprobe.d/asus_fnlock.conf > /dev/null
            echo "Success.. Fnlock now disabled"
        fi
    else
        read -p "FN Lock is disabled on startup, enable (Y/n): " input
        if [[ "$input" == "Y" || "$input" == "y" ]]; then
            echo "options asus_wmi fnlock_default=Y" | sudo tee /etc/modprobe.d/asus_fnlock.conf > /dev/null
            echo "Success.. Fnlock now enabled"
        fi
    fi
else
    echo "Doesn't Exist"
fi
