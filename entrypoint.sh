#!/bin/bash
set -e

DOWNLOADER="$DOWNLOADER_PATH"
SERVER_DIR="$SERVER_PATH"

if [ -n "$FORCE_UPDATE" ] && [ "$FORCE_UPDATE" = "true" ]; then
    echo "Force update requested. Downloading latest server files..."
    DOWNLOAD_NEEDED=true
elif [ ! -d "$SERVER_DIR/Server" ] || [ ! -f "$SERVER_DIR/Assets.zip" ]; then
    echo "Server files not found. Starting download..."
    DOWNLOAD_NEEDED=true
fi

if [ "$DOWNLOAD_NEEDED" = "true" ]; then
    cd "$SERVER_DIR"
    "$DOWNLOADER" -download-path "$SERVER_DIR/game.zip"
    
    if [ -f "$SERVER_DIR/game.zip" ]; then
        echo "Extracting game files..."
        unzip -o -q "$SERVER_DIR/game.zip" -d "$SERVER_DIR"
        rm -f "$SERVER_DIR/game.zip"
    fi
fi

# Verify server files exist
if [ ! -d "$SERVER_DIR/Server" ]; then
    echo "Error: Server directory not found in $SERVER_DIR"
    echo "Contents:"
    ls -la "$SERVER_DIR" || true
    exit 1
fi

if [ ! -f "$SERVER_DIR/Server/HytaleServer.jar" ]; then
    echo "Error: HytaleServer.jar not found in $SERVER_DIR/Server/"
    echo "Contents of Server directory:"
    ls -la "$SERVER_DIR/Server" || true
    exit 1
fi

if [ ! -f "$SERVER_DIR/Assets.zip" ]; then
    echo "Error: Assets.zip not found in $SERVER_DIR/"
    exit 1
fi

# Start the Hytale server
echo "Starting Hytale server..."
cd "$SERVER_DIR/Server"
exec java -XX:AOTCache=HytaleServer.aot -jar HytaleServer.jar --assets "$SERVER_DIR/Assets.zip" --disable-sentry
