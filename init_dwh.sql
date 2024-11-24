CREATE SCHEMA dwh_detailed;

CREATE TABLE dwh_detailed.bookings (
    book_ref CHAR(6) PRIMARY KEY,
    book_date TIMESTAMPTZ NOT NULL,
    total_amount NUMERIC(10, 2) NOT NULL,
    source_system_id INT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    version INT DEFAULT 1
);

CREATE TABLE dwh_detailed.airports (
    airport_code CHAR(3) PRIMARY KEY,
    airport_name TEXT NOT NULL,
    city TEXT NOT NULL,
    coordinates_lon DOUBLE PRECISION NOT NULL,
    coordinates_lat DOUBLE PRECISION NOT NULL,
    timezone TEXT NOT NULL,
    source_system_id INT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    version INT DEFAULT 1
);

CREATE TABLE dwh_detailed.aircrafts (
    aircraft_code CHAR(3) PRIMARY KEY,
    model JSONB NOT NULL,
    range INTEGER NOT NULL,
    source_system_id INT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    version INT DEFAULT 1
);

CREATE TABLE dwh_detailed.tickets (
    ticket_no CHAR(13) PRIMARY KEY,
    book_ref CHAR(6) REFERENCES dwh_detailed.bookings(book_ref),
    passenger_id VARCHAR(20) NOT NULL,
    passenger_name TEXT NOT NULL,
    contact_data JSONB,
    source_system_id INT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    version INT DEFAULT 1
);

CREATE TABLE dwh_detailed.flights (
    flight_id SERIAL PRIMARY KEY,
    flight_no CHAR(6) NOT NULL,
    scheduled_departure TIMESTAMPTZ NOT NULL,
    scheduled_arrival TIMESTAMPTZ NOT NULL,
    departure_airport CHAR(3) NOT NULL,
    arrival_airport CHAR(3) NOT NULL,
    status VARCHAR(20) NOT NULL,
    aircraft_code CHAR(3) NOT NULL,
    actual_departure TIMESTAMPTZ,
    actual_arrival TIMESTAMPTZ,
    source_system_id INT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    version INT DEFAULT 1,
    CONSTRAINT departure_airport_fk FOREIGN KEY (departure_airport) REFERENCES dwh_detailed.airports(airport_code),
    CONSTRAINT arrival_airport_fk FOREIGN KEY (arrival_airport) REFERENCES dwh_detailed.airports(airport_code),
    CONSTRAINT aircraft_code_fk FOREIGN KEY (aircraft_code) REFERENCES dwh_detailed.aircrafts(aircraft_code)
);

CREATE TABLE dwh_detailed.ticket_flights (
    ticket_no CHAR(13) REFERENCES dwh_detailed.tickets(ticket_no),
    flight_id INTEGER NOT NULL,
    fare_conditions VARCHAR(10) NOT NULL,
    amount NUMERIC(10, 2) NOT NULL,
    source_system_id INT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    version INT DEFAULT 1,
    PRIMARY KEY (ticket_no, flight_id),
    CONSTRAINT flight_fk FOREIGN KEY (flight_id) REFERENCES dwh_detailed.flights(flight_id)
);

CREATE TABLE dwh_detailed.seats (
    aircraft_code CHAR(3) REFERENCES dwh_detailed.aircrafts(aircraft_code),
    seat_no VARCHAR(4) NOT NULL,
    fare_conditions VARCHAR(10) NOT NULL,
    source_system_id INT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    version INT DEFAULT 1,
    PRIMARY KEY (aircraft_code, seat_no)
);

CREATE TABLE dwh_detailed.boarding_passes (
    ticket_no CHAR(13) REFERENCES dwh_detailed.tickets(ticket_no),
    flight_id INTEGER REFERENCES dwh_detailed.flights(flight_id),
    boarding_no INTEGER NOT NULL,
    seat_no VARCHAR(4) NOT NULL,
    source_system_id INT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    version INT DEFAULT 1,
    PRIMARY KEY (ticket_no, flight_id),
    CONSTRAINT seat_fk FOREIGN KEY (seat_no, aircraft_code) REFERENCES dwh_detailed.seats(seat_no, aircraft_code)
);


alter table dwh_detailed.bookings replica identity full;
alter table dwh_detailed.tickets replica identity full;
alter table dwh_detailed.ticket_flights  replica identity full;
alter table dwh_detailed.flights  replica identity full;
alter table dwh_detailed.airports  replica identity full;
alter table dwh_detailed.aircrafts  replica identity full;
alter table dwh_detailed.seats replica identity full;
alter table dwh_detailed.boarding_passes replica identity full;

