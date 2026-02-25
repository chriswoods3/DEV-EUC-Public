#!/bin/zsh

# Check if a path was provided
if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/YourApp.app"
    exit 1
fi

APP_PATH="$1"

echo "Scanning: $APP_PATH"
echo "--------------------------------------------------"

# Find all Mach-O binaries and run codesign on them
find "$APP_PATH" -type f | while read -r file; do
    # Check if the file is a Mach-O binary (executable, dylib, or framework)
    if file "$file" | grep -q "Mach-O"; then
        # Extract the Identifier from codesign output
        identifier=$(codesign -dv "$file" 2>&1 | grep "Identifier=" | cut -d'=' -f2)
        
        if [ -n "$identifier" ]; then
            echo "Binary: $(basename "$file")"
            echo "ID:     $identifier"
            echo "Path:   ${file#$APP_PATH/}"
            echo "---"
        fi
    fi
done