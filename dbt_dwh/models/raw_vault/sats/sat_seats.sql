{%- set source_model = "stg_seats" -%}
{%- set src_pk = "aircraft_code, seat_no" -%}
{%- set src_nk = "aircraft_code, seat_no" -%}
{%- set src_ldts = "fare_conditions" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{%- set columns = {
    'fare_conditions': 'VARCHAR(10)'
} -%}

{{ automate_dv.satellite(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts, 
                src_source=src_source, columns=columns, source_model=source_model) }}
