CREATE SCHEMA IF NOT EXISTS dwh_detailed;

CREATE TABLE IF NOT EXISTS dwh_detailed.bookings (
    book_ref CHAR(6) PRIMARY KEY,
    book_date TIMESTAMP NOT NULL,
    total_amount NUMERIC(10, 2) NOT NULL,
    source_system_id INT,
    created_at TIMESTAMP DEFAULT NOW(),
    version INT DEFAULT 1,
    booking_hashdiff TEXT,
    LOAD_DATETIME TIMESTAMP DEFAULT NOW(),
    EFFECTIVE_FROM TIMESTAMP,
    RECORD_SOURCE TEXT
);

CREATE TABLE IF NOT EXISTS dwh_detailed.airports (
    airport_code CHAR(3) PRIMARY KEY,
    airport_name TEXT NOT NULL,
    city TEXT NOT NULL,
    coordinates_lon DOUBLE PRECISION NOT NULL,
    coordinates_lat DOUBLE PRECISION NOT NULL,
    timezone TEXT NOT NULL,
    source_system_id INT,
    created_at TIMESTAMP DEFAULT NOW(),
    version INT DEFAULT 1,
    airport_hashdiff TEXT,
    LOAD_DATETIME TIMESTAMP DEFAULT NOW(),
    EFFECTIVE_FROM TIMESTAMP,
    RECORD_SOURCE TEXT
);

CREATE TABLE IF NOT EXISTS dwh_detailed.aircrafts (
    aircraft_code CHAR(3) PRIMARY KEY,
    model JSONB NOT NULL,
    range INT NOT NULL,
    source_system_id INT,
    created_at TIMESTAMP DEFAULT NOW(),
    version INT DEFAULT 1,
    aircraft_hashdiff TEXT,
    LOAD_DATETIME TIMESTAMP DEFAULT NOW(),
    EFFECTIVE_FROM TIMESTAMP,
    RECORD_SOURCE TEXT
);

CREATE TABLE IF NOT EXISTS dwh_detailed.tickets (
    ticket_no CHAR(13) PRIMARY KEY,
    book_ref CHAR(6) REFERENCES dwh_detailed.bookings(book_ref),
    passenger_id VARCHAR(20) NOT NULL,
    passenger_name TEXT NOT NULL,
    contact_data JSONB,
    source_system_id INT,
    created_at TIMESTAMP DEFAULT NOW(),
    version INT DEFAULT 1,
    ticket_hashdiff TEXT,
    LOAD_DATETIME TIMESTAMP DEFAULT NOW(),
    EFFECTIVE_FROM TIMESTAMP,
    RECORD_SOURCE TEXT
);

CREATE TABLE IF NOT EXISTS dwh_detailed.flights (
    flight_id SERIAL PRIMARY KEY,
    flight_no CHAR(6) NOT NULL,
    scheduled_departure TIMESTAMP NOT NULL,
    scheduled_arrival TIMESTAMP NOT NULL,
    departure_airport CHAR(3) REFERENCES dwh_detailed.airports(airport_code),
    arrival_airport CHAR(3) REFERENCES dwh_detailed.airports(airport_code),
    status VARCHAR(20) NOT NULL,
    aircraft_code CHAR(3) REFERENCES dwh_detailed.aircrafts(aircraft_code),
    actual_departure TIMESTAMP,
    actual_arrival TIMESTAMP,
    source_system_id INT,
    created_at TIMESTAMP DEFAULT NOW(),
    version INT DEFAULT 1,
    flight_hashdiff TEXT,
    LOAD_DATETIME TIMESTAMP DEFAULT NOW(),
    EFFECTIVE_FROM TIMESTAMP,
    RECORD_SOURCE TEXT
);

CREATE TABLE IF NOT EXISTS dwh_detailed.ticket_flights (
    ticket_no CHAR(13) REFERENCES dwh_detailed.tickets(ticket_no),
    flight_id INT REFERENCES dwh_detailed.flights(flight_id),
    fare_conditions VARCHAR(10) NOT NULL,
    amount NUMERIC(10, 2) NOT NULL,
    source_system_id INT,
    created_at TIMESTAMP DEFAULT NOW(),
    version INT DEFAULT 1,
    PRIMARY KEY (ticket_no, flight_id),
    ticket_flight_hashdiff TEXT,
    LOAD_DATETIME TIMESTAMP DEFAULT NOW(),
    EFFECTIVE_FROM TIMESTAMP,
    RECORD_SOURCE TEXT
);

CREATE TABLE IF NOT EXISTS dwh_detailed.seats (
    aircraft_code CHAR(3) REFERENCES dwh_detailed.aircrafts(aircraft_code),
    seat_no VARCHAR(4) NOT NULL,
    fare_conditions VARCHAR(10) NOT NULL,
    source_system_id INT,
    created_at TIMESTAMP DEFAULT NOW(),
    version INT DEFAULT 1,
    PRIMARY KEY (aircraft_code, seat_no),
    seat_hashdiff TEXT,
    LOAD_DATETIME TIMESTAMP DEFAULT NOW(),
    EFFECTIVE_FROM TIMESTAMP,
    RECORD_SOURCE TEXT
);

CREATE TABLE IF NOT EXISTS dwh_detailed.boarding_passes (
    ticket_no CHAR(13) REFERENCES dwh_detailed.tickets(ticket_no),
    flight_id INT REFERENCES dwh_detailed.flights(flight_id),
    boarding_no INT NOT NULL,
    seat_no VARCHAR(4) NOT NULL,
    source_system_id INT,
    created_at TIMESTAMP DEFAULT NOW(),
    version INT DEFAULT 1,
    PRIMARY KEY (ticket_no, flight_id),
    boarding_pass_hashdiff TEXT,
    LOAD_DATETIME TIMESTAMP DEFAULT NOW(),
    EFFECTIVE_FROM TIMESTAMP,
    RECORD_SOURCE TEXT
);
