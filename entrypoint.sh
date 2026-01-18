#!/bin/bash
set -e

DOWNLOADER="$DOWNLOADER_PATH"
SERVER_DIR="$SERVER_PATH"

# Check if server files already exist
if [ ! -d "$SERVER_DIR/Server" ] || [ ! -f "$SERVER_DIR/Assets.zip" ]; then
    echo "Server files not found. Starting download..."
    
    # Download the game files to a specific zip file
    cd "$SERVER_DIR"
    "$DOWNLOADER" -download-path "$SERVER_DIR/game.zip" -skip-update-check
    
    # Extract the downloaded zip file
    if [ -f "$SERVER_DIR/game.zip" ]; then
        echo "Extracting game files..."
        unzip -q "$SERVER_DIR/game.zip" -d "$SERVER_DIR"
        rm -f "$SERVER_DIR/game.zip"
    fi
    
    # Debug: show what was extracted
    echo "Contents of $SERVER_DIR after download:"
    ls -la "$SERVER_DIR" || true
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
exec java -jar HytaleServer.jar --assets "$SERVER_DIR/Assets.zip"
