# Hytale Server Docker

Docker container to run a Hytale server.

## Requirements

- Docker and Docker Compose
- Hytale account with server access

## Installation

Clone the repository and start the container:

```bash
docker-compose up -d
```

## Configuration

Server files are saved in the `./server` directory. On first startup, the container automatically downloads the required files via hytale-downloader.

### Authentication

To complete OAuth login on first startup:

1. Attach to the container:
```bash
docker attach hytale-server
```

2. Run the authentication command:
```
/auth login device
```

3. Click the displayed link in your browser to authorize access

4. Detach from the container by pressing `Ctrl+P` followed by `Ctrl+Q` (detach without stopping the container)

## Ports

The server exposes UDP port 5520. Modify the port mapping in `docker-compose.yml` if needed.

## Management

Start the server:
```bash
docker-compose up -d
```

Stop the server:
```bash
docker-compose stop
```

View logs:
```bash
docker-compose logs -f
```

## Automatic Daily Restart

Configure automatic daily restart at 5:00 AM using cron:

1. Make the script executable:
   ```bash
   chmod +x restart-server.sh
   ```

2. Add cron job (replace `/path/to/hytale-server-docker` with your actual path):
   ```bash
   crontab -e
   ```
   Add this line:
   ```cron
   0 5 * * * /path/to/hytale-server-docker/restart-server.sh
   ```

3. Test manually:
   ```bash
   ./restart-server.sh
   cat logs/restart.log
   ```

## Updating Server Files

To force download and update the server files to the latest version:

**Option 1 - Environment variable:**
```bash
FORCE_UPDATE=true docker compose up
```

**Option 2 - .env file:**
```bash
echo "FORCE_UPDATE=true" > .env
docker compose up
# Remove or comment out after update
```

**Note:** The update preserves your world data (universe/), logs, and configurations. Only server binaries and assets are updated.

## Updating the Downloader

To update the hytale-downloader tool itself, rebuild the Docker image:

```bash
docker compose build --no-cache
```

This will download the latest version of hytale-downloader from the official source.

## Notes

- Server files are persistent in the `./server` directory
- OAuth credentials are saved in `./server/.hytale-downloader-credentials.json`
- The container automatically restarts unless manually stopped
