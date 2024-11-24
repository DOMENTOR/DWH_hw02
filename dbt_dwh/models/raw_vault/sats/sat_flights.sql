{%- set source_model = "stg_flights" -%}
{%- set src_pk = "flight_id" -%}
{%- set src_nk = "flight_no" -%}
{%- set src_ldts = "scheduled_departure" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{%- set columns = {
    'flight_no': 'CHAR(6)',
    'scheduled_departure': 'TIMESTAMPTZ',
    'scheduled_arrival': 'TIMESTAMPTZ',
    'departure_airport': 'CHAR(3)',
    'arrival_airport': 'CHAR(3)',
    'status': 'VARCHAR(20)',
    'aircraft_code': 'CHAR(3)',
    'actual_departure': 'TIMESTAMPTZ',
    'actual_arrival': 'TIMESTAMPTZ'
} -%}

{{ automate_dv.satellite(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, columns=columns, source_model=source_model) }}
