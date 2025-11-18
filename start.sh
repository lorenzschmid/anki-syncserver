#!/bin/sh

# Function to update the package
update_package() {
    echo "Checking for Anki-sync-server updates..."
    pip install --upgrade anki
}

# Background loop for periodic updates
(
    # Sleep for a short period before the first check
    sleep 60
    while true; do
        update_package
        sleep ${UPDATE_INTERVAL:-21600}
    done
) &

# Start the Anki sync server
echo "Starting Anki sync server..."
exec python -m anki.syncserver
