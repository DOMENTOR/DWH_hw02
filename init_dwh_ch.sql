CREATE DATABASE IF NOT EXISTS dwh_detailed;

CREATE TABLE IF NOT EXISTS dwh_detailed.bookings (
    book_ref String,
    book_date DateTime,
    total_amount Float64,
    source_system_id Int32,
    created_at DateTime DEFAULT now(),
    version Int32 DEFAULT 1,
    PRIMARY KEY (book_ref)
) ENGINE = MergeTree()
ORDER BY book_ref;

CREATE TABLE IF NOT EXISTS dwh_detailed.airports (
    airport_code String,
    airport_name String,
    city String,
    coordinates_lon Float64,
    coordinates_lat Float64,
    timezone String,
    source_system_id Int32,
    created_at DateTime DEFAULT now(),
    version Int32 DEFAULT 1,
    PRIMARY KEY (airport_code)
) ENGINE = MergeTree()
ORDER BY airport_code;

CREATE TABLE IF NOT EXISTS dwh_detailed.aircrafts (
    aircraft_code String,
    model String,
    range Int32,
    source_system_id Int32,
    created_at DateTime DEFAULT now(),
    version Int32 DEFAULT 1,
    PRIMARY KEY (aircraft_code)
) ENGINE = MergeTree()
ORDER BY aircraft_code;

CREATE TABLE IF NOT EXISTS dwh_detailed.tickets (
    ticket_no String,
    book_ref String,
    passenger_id String,
    passenger_name String,
    contact_data String,
    source_system_id Int32,
    created_at DateTime DEFAULT now(),
    version Int32 DEFAULT 1,
    PRIMARY KEY (ticket_no)
) ENGINE = MergeTree()
ORDER BY ticket_no;

CREATE TABLE IF NOT EXISTS dwh_detailed.passengers (
    passenger_id String,
    first_name String,
    last_name String,
    email String,
    phone_number String,
    source_system_id Int32,
    created_at DateTime DEFAULT now(),
    version Int32 DEFAULT 1,
    PRIMARY KEY (passenger_id)
) ENGINE = MergeTree()
ORDER BY passenger_id;

CREATE TABLE IF NOT EXISTS dwh_detailed.flights (
    flight_no String,
    departure_airport_code String,
    arrival_airport_code String,
    departure_time DateTime,
    arrival_time DateTime,
    aircraft_code String,
    source_system_id Int32,
    created_at DateTime DEFAULT now(),
    version Int32 DEFAULT 1,
    PRIMARY KEY (flight_no)
) ENGINE = MergeTree()
ORDER BY flight_no;

CREATE TABLE IF NOT EXISTS dwh_detailed.flight_segments (
    segment_id String,
    flight_no String,
    departure_airport_code String,
    arrival_airport_code String,
    departure_time DateTime,
    arrival_time DateTime,
    source_system_id Int32,
    created_at DateTime DEFAULT now(),
    version Int32 DEFAULT 1,
    PRIMARY KEY (segment_id)
) ENGINE = MergeTree()
ORDER BY segment_id;

CREATE TABLE IF NOT EXISTS dwh_detailed.transactions (
    transaction_id String,
    ticket_no String,
    transaction_date DateTime,
    amount Float64,
    payment_method String,
    source_system_id Int32,
    created_at DateTime DEFAULT now(),
    version Int32 DEFAULT 1,
    PRIMARY KEY (transaction_id)
) ENGINE = MergeTree()
ORDER BY transaction_id;
