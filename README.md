# Hytale Server Docker

Container Docker per eseguire un server Hytale.

## Requisiti

- Docker e Docker Compose
- Account Hytale con accesso al server

## Installazione

Clonare il repository e avviare il container:

```bash
docker-compose up -d
```

## Configurazione

I file del server vengono salvati nella directory `./server`. Al primo avvio, il container scarica automaticamente i file necessari tramite hytale-downloader.

### Autenticazione

Per completare il login OAuth al primo avvio:

1. Collegarsi al container:
```bash
docker attach hytale-server
```

2. Eseguire il comando di autenticazione:
```
/auth login device
```

3. Cliccare sul link visualizzato nel browser per autorizzare l'accesso

4. Uscire dal container premendo `Ctrl+P` seguito da `Ctrl+Q` (detach senza fermare il container)

## Porte

Il server espone la porta UDP 5520. Modificare la mappatura delle porte in `docker-compose.yml` se necessario.

## Gestione

Avviare il server:
```bash
docker-compose up -d
```

Fermare il server:
```bash
docker-compose stop
```

Visualizzare i log:
```bash
docker-compose logs -f
```

## Note

- I file del server sono persistenti nella directory `./server`
- Le credenziali OAuth vengono salvate in `./server/.hytale-downloader-credentials.json`
- Il container si riavvia automaticamente a meno che non venga fermato manualmente
