#!/bin/zsh
#zScaler installed and Running

if [[ -e  "/Applications/Zscaler/Zscaler.app/Contents/MacOS/Santa" ]]; then
    if  pgrep Zscaler > /dev/null; then
        echo "Yes"
    else
        echo "Not Running"
    fi
else
    echo "Missing"
fi