#!/bin/sh

# Define paths for Homepage's data
HOMEPAGE_CONFIG_PATH="/app/config"


# Mapped directories from the host
PERSISTENT_CONFIG_PATH="/share/homepage/configs"

# Ensure the persistent directories exist
mkdir -p $PERSISTENT_CONFIG_PATH

# Function to sync data from Homepage's directories to persistent storage
sync_to_persistent() {
    while true; do
        cp -R $HOMEPAGE_CONFIG_PATH/* $PERSISTENT_CONFIG_PATH/ 2>/dev/null
        sleep 60  # Sync every 60 seconds, adjust as needed
    done
}

# Sync data to Homepage's directories on startup
cp -R $PERSISTENT_CONFIG_PATH/* $HOMEPAGE_CONFIG_PATH/ 2>/dev/null

# Start continuous sync in the background
sync_to_persistent &

# Exporting hostname
echo "Exporting hostname..."
export NEXTAUTH_URL_INTERNAL="http://$HOSTNAME:${PORT:-3000}"

# Starting Homepage
echo "Starting production server..."
