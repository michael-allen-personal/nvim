#!/bin/bash

# Get the night light status
night_light_status=$(gsettings get org.gnome.settings-daemon.plugins.color night-light-enabled)

# Check if night light is enabled
if [ "$night_light_status" = "true" ]; then
    echo 1
else
    echo 0
fi

: '
# Check if Night Light is enabled
enabled=$(gsettings get org.gnome.settings-daemon.plugins.color night-light-enabled)

if [ "$enabled" = "true" ]; then
    # Check if schedule is automatic
    auto=$(gsettings get org.gnome.settings-daemon.plugins.color night-light-schedule-automatic)

    if [ "$auto" = "true" ]; then
        echo "Night Light is active based on automatic schedule (sunset to sunrise)."
        # Additional logic might be needed here to check actual sunset/sunrise times.
    else
        from=$(gsettings get org.gnome.settings-daemon.plugins.color night-light-schedule-from)
        to=$(gsettings get org.gnome.settings-daemon.plugins.color night-light-schedule-to)
        currentTime=$(date +%H.%M)
        
        if (( $(echo "$currentTime >= $from && $currentTime <= $to" | bc -l) )); then
            echo "Night Light is currently active."
        else
            echo "Night Light is currently inactive."
        fi
    fi
else
    echo "Night Light is disabled."
fi
'
