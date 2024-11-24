{%- set source_model = "stg_seats" -%}
{%- set src_pk = "aircraft_code, seat_no" -%}
{%- set src_ldts = "fare_conditions" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.link(
    src_pk=src_pk, 
    src_ldts=src_ldts,
    src_source=src_source, 
    source_model=source_model) }}
