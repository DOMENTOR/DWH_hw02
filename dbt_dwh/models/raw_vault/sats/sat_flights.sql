{%- set source_model = "stg_flights" -%}
{%- set src_pk = "flight_id" -%}
{%- set src_hashdiff = "flights_hashdiff" -%}
{%- set src_payload = ["flight_no", "scheduled_departure", "scheduled_arrival", "departure_airport", "arrival_airport", "status", "aircraft_code", "actual_departure", "actual_arrival"] -%}
{%- set src_eff = "EFFECTIVE_FROM" -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.sat(src_pk=src_pk, src_hashdiff=src_hashdiff,
                src_payload=src_payload, src_eff=src_eff,
                src_ldts=src_ldts, src_source=src_source,
                source_model=source_model) }}
