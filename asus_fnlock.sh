#!/usr/bin/env bash

FN_LOCK="/sys/module/asus_wmi/parameters/fnlock_default"

if [[ -f "$FN_LOCK" ]]; then
    FN_LOCK_STATE=$(cat "$FN_LOCK")

    if [[ "$FN_LOCK_STATE" == "Y" ]]; then
        read -p "fn lock is enabled on startup, disable (Y/n): " input
        if [[ "$input" == "Y" || "$input" == "y" ]]; then
            echo "options asus_wmi fnlock_default=N" | sudo tee /etc/modprobe.d/asus_fnlock.conf > /dev/null
			sudo mkinitcpio -P
            echo "Success.. fn lock now disabled"
        fi
    else
        read -p "fn lock is disabled on startup, enable (Y/n): " input
        if [[ "$input" == "Y" || "$input" == "y" ]]; then
            echo "options asus_wmi fnlock_default=Y" | sudo tee /etc/modprobe.d/asus_fnlock.conf > /dev/null
			sudo mkinitcpio -P
            echo "Success.. fn lock now enabled"
        fi
    fi
else
    echo "Doesn't Exist"
fi
