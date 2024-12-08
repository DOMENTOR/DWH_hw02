CREATE TABLE dwh_detailed.bookings (
  book_ref CHAR(6),
  book_date TIMESTAMP,
  total_amount NUMERIC(10, 2),
  source_system_id INT,
  created_at TIMESTAMP DEFAULT now(),
  version INT DEFAULT 1
);

CREATE TABLE dwh_detailed.airports (
  airport_code CHAR(3),
  airport_name TEXT,
  city TEXT,
  coordinates_lon DOUBLE PRECISION,
  coordinates_lat DOUBLE PRECISION,
  timezone TEXT,
  source_system_id INT,
  created_at TIMESTAMP DEFAULT now(),
  version INT DEFAULT 1
);

CREATE TABLE dwh_detailed.aircrafts (
  aircraft_code CHAR(3),
  model JSONB,
  range INT,
  source_system_id INT,
  created_at TIMESTAMP DEFAULT now(),
  version INT DEFAULT 1
);

CREATE TABLE dwh_detailed.tickets (
  ticket_no CHAR(13),
  book_ref CHAR(6) REFERENCES dwh_detailed.bookings(book_ref),
  passenger_id VARCHAR(20),
  passenger_name TEXT,
  contact_data JSONB,
  source_system_id INT,
  created_at TIMESTAMP DEFAULT now(),
  version INT DEFAULT 1
);

CREATE TABLE dwh_detailed.flights (
  flight_id SERIAL PRIMARY KEY,
  flight_no CHAR(6),
  scheduled_departure TIMESTAMP,
  scheduled_arrival TIMESTAMP,
  departure_airport CHAR(3),
  arrival_airport CHAR(3),
  status VARCHAR(20),
  aircraft_code CHAR(3) REFERENCES dwh_detailed.aircrafts(aircraft_code),
  actual_departure TIMESTAMP,
  actual_arrival TIMESTAMP,
  source_system_id INT,
  created_at TIMESTAMP DEFAULT now(),
  version INT DEFAULT 1
);

CREATE TABLE dwh_detailed.ticket_flights (
  ticket_no CHAR(13) REFERENCES dwh_detailed.tickets(ticket_no),
  flight_id INT REFERENCES dwh_detailed.flights(flight_id),
  fare_conditions VARCHAR(10),
  amount NUMERIC(10,2),
  source_system_id INT,
  created_at TIMESTAMP DEFAULT now(),
  version INT DEFAULT 1,
  PRIMARY KEY (ticket_no, flight_id)
);

CREATE TABLE dwh_detailed.seats (
  aircraft_code CHAR(3) REFERENCES dwh_detailed.aircrafts(aircraft_code),
  seat_no VARCHAR(4),
  fare_conditions VARCHAR(10),
  source_system_id INT,
  created_at TIMESTAMP DEFAULT now(),
  version INT DEFAULT 1,
  PRIMARY KEY (aircraft_code, seat_no)
);

CREATE TABLE dwh_detailed.boarding_passes (
  ticket_no CHAR(13) REFERENCES dwh_detailed.tickets(ticket_no),
  flight_id INT REFERENCES dwh_detailed.flights(flight_id),
  boarding_no INT,
  seat_no VARCHAR(4),
  source_system_id INT,
  created_at TIMESTAMP DEFAULT now(),
  version INT DEFAULT 1,
  PRIMARY KEY (ticket_no, flight_id)
);
