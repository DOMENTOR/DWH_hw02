# Linux-like system
curl -X POST --location "http://localhost:8083/connectors" -H "Content-Type: application/json" -H "Accept: application/json" -d @debezium.json
curl -X POST -H "Content-Type: application/vnd.kafka.v2+json" -H "Accept: application/vnd.kafka.v2+json" -d '{"name": "dwh_group", "format": "binary", "auto.offset.reset": "latest"}' http://localhost:8082/consumers/dwh_group

python3 add_sink_connectors.py

# Windows system (powershell, нужно каждую команду отдельно запустить)
# Invoke-WebRequest -Uri "http://localhost:8083/connectors" -Method POST -Headers @{ "Content-Type" = "application/json"; "Accept" = "application/json" } -Body (Get-Content -Raw "debezium.json")
# Invoke-WebRequest -Uri "http://localhost:8082/consumers/dwh_group" -Method POST -Headers @{ "Content-Type" = "application/vnd.kafka.v2+json"; "Accept" = "application/vnd.kafka.v2+json" } -Body '{"name": "dwh_group", "format": "binary", "auto.offset.reset": "latest"}'

# python add_sink_connectors.py

# Old versions
#curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" 127.0.0.1:8083/connector-plugins/PostgresConnector/config/validate --data "@debezium.json"
#curl http://localhost:8082/v3/clusters -o clusters.json
#curl http://localhost:8082/v3/clusters/hKYwT5GoSlapEIkACEV1Zw/topics -o topics.json
