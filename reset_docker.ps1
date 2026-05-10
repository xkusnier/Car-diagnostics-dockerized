cd $PSScriptRoot

docker compose down -v
powershell -ExecutionPolicy Bypass -File .\start_docker.ps1
