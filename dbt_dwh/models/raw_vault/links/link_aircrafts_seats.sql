  -- depends_on: {{ ref('stg_seats') }}
{%- set source_model = "stg_seats" -%}
{%- set src_pk = ['aircraft_code', 'seat_no'] -%}
{%- set src_fk = 'aircraft_code' -%}
{%- set src_ldts = "LOAD_DATETIME" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.link(
    src_pk=src_pk, 
    src_fk=src_fk,
    src_ldts=src_ldts,
    src_source=src_source, 
    source_model=source_model) }}
