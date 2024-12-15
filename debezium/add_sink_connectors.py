import requests

DEBEZIUM_URL = "http://localhost:8083/connectors"

sink_connectors_info = {
    'postgres.system.bookings': 'book_ref',
    'postgres.system.tickets': 'ticket_no, book_ref',
    'postgres.system.ticket_flights': 'ticket_no, flight_id',
    'postgres.system.flights': 'flight_id',
    'postgres.system.airports': 'airport_code',
    'postgres.system.aircrafts': 'aircraft_code',
    'postgres.system.seats': 'aircraft_code, seat_no',
    'postgres.system.boarding_passes': 'ticket_no, flight_id'
}

def add_connector(connector_dict):
    response = requests.post(
        DEBEZIUM_URL, 
        json=connector_dict,
        headers={"Content-Type": "application/json"}
    )
    if response.status_code >= 400:
        raise Exception(f"Failed to create connector {connector_dict['name']}: {response.text}")
    print(f"Connector {connector_dict['name']} added successfully!")

def add_sink_connectors():

    for topic, record_keys in sink_connectors_info.items():
        connector_name = topic.replace('.', '-')
        connector_config = {
            "name": connector_name,
            "config": {
                "connector.class": "io.debezium.connector.jdbc.JdbcSinkConnector",
                "topics": topic,
                "connection.url": "jdbc:postgresql://postgres_dwh:5434/postgres",
                "connection.username": "postgres",
                "connection.password": "postgres",
                "tasks.max": "1",
                "insert.mode": "upsert",
                "delete.enabled": "false",
                "primary.key.mode": "record_key",
                "primary.key.fields": record_keys,
                "schema.evolution": "basic"
            }
        }
        add_connector(connector_config)

if __name__ == "__main__":
    add_sink_connectors()
