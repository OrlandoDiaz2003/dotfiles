#!bin/bash
status=$(playerctl --player=spotify status 2>/dev/null)

if [[ $status == "Playing" ]]; then
    echo "$(playerctl --player=spotify metadata --format '{{ emoji(status) }} {{ artist }}, {{ trunc(title,30) }}')"
elif [[ $status == "Paused" ]]; then
    echo "$(playerctl --player=spotify metadata --format '󰏤 {{ artist }}, {{ trunc(title,30) }}')"
elif [[ -z $status ]]; then
    echo ""
fi