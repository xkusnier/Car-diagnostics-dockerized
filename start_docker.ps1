cd $PSScriptRoot

Write-Host "Starting Car-Diagnostics with Docker..."
docker compose up -d --build

Write-Host "Waiting for backend..."
$ready = $false
for ($i = 1; $i -le 60; $i++) {
    try {
        $response = Invoke-RestMethod -Uri "http://localhost:5000/api/health" -Method GET -TimeoutSec 2
        if ($response.status -eq "ok") {
            $ready = $true
            break
        }
    } catch {
        Start-Sleep -Seconds 2
    }
}

if (-not $ready) {
    Write-Host "Backend did not become ready. Check logs with: docker compose logs backend --tail=100" -ForegroundColor Red
    exit 1
}

Write-Host "Initializing database tables..."
Invoke-RestMethod -Uri "http://localhost:5000/api/init-db" -Method GET | Out-Host

Write-Host "Importing seed data..."
powershell -ExecutionPolicy Bypass -File .\import_seed.ps1

Write-Host "Car-Diagnostics is running:" -ForegroundColor Green
Write-Host "Frontend: http://localhost:3000"
Write-Host "Backend:  http://localhost:5000"
Write-Host "Swagger:  http://localhost:5000/apidocs/"

--tento subor bol vygenerovany systémom umelej inteligencie ChatGPT od spoločnosti OpenAI