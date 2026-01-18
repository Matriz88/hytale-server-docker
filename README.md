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

## Notes

- Server files are persistent in the `./server` directory
- OAuth credentials are saved in `./server/.hytale-downloader-credentials.json`
- The container automatically restarts unless manually stopped
