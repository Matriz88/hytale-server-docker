#!/bin/sh

# Create logs directory if it doesn't exist
mkdir -p logs

# Restart docker compose
docker compose restart hytale-server

# Print restart log
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Docker compose restarted" >> logs/restart.log