cd $PSScriptRoot

Write-Host "Copying CSV seed files into Docker PostgreSQL container..."

docker cp ".\db_seed\dtc_codes_meaning.csv" car_diagnostics_db:/tmp/dtc_codes_meaning.csv
docker cp ".\db_seed\dtc_patterns.csv" car_diagnostics_db:/tmp/dtc_patterns.csv
docker cp ".\db_seed\dtc_pattern_links.csv" car_diagnostics_db:/tmp/dtc_pattern_links.csv
docker cp ".\db_seed\import_seed.sql" car_diagnostics_db:/tmp/import_seed.sql

Write-Host "Importing CSV seed data into database..."

docker exec -i car_diagnostics_db psql -U car_user -d car_diagnostics -f /tmp/import_seed.sql

Write-Host "Seed import finished."
#tento subor bol vygenerovany systémom umelej inteligencie ChatGPT od spoločnosti OpenAI