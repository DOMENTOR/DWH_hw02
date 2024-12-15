  -- depends_on: {{ ref('stg_flights') }}
{%- set source_model = "stg_flights" -%}
{%- set src_pk = ['flight_id', 'departure_airport', 'arrival_airport'] -%}
{%- set src_fk = ['departure_airport', 'arrival_airport'] -%}
{%- set src_ldts = "LOAD_DATETIME" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.link(
    src_pk=src_pk, 
    src_fk=src_fk, 
    src_ldts=src_ldts,
    src_source=src_source, 
    source_model=source_model) }}
