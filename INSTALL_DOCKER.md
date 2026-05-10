# Car-Diagnostics – spustenie cez Docker

## Požiadavka

Musí byť nainštalovaný a spustený Docker Desktop.

Overenie v PowerShelli:

```powershell
docker --version
docker compose version
```

## Spustenie

Rozbaľ projekt, otvor PowerShell v priečinku, kde je `docker-compose.yml`, a spusti:

```powershell
powershell -ExecutionPolicy Bypass -File .\start_docker.ps1
```

Skript spustí backend, frontend, PostgreSQL databázu, vytvorí tabuľky a importuje CSV seed dáta.

## Adresy

Frontend:

```text
http://localhost:3000
```

Backend:

```text
http://localhost:5000
```

Swagger/API dokumentácia:

```text
http://localhost:5000/apidocs/
```

## Zastavenie

```powershell
powershell -ExecutionPolicy Bypass -File .\stop_docker.ps1
```

alebo:

```powershell
docker compose down
```

## Úplný reset databázy

```powershell
powershell -ExecutionPolicy Bypass -File .\reset_docker.ps1
```

Tento príkaz vymaže lokálnu PostgreSQL databázu a znovu spustí celý systém so seed dátami.
