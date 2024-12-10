  -- depends_on: {{ ref('stg_boarding_passes') }}
{%- set source_model = "stg_boarding_passes" -%}
{%- set src_pk = "ticket_no, flight_id" -%}
{%- set src_fk = "ticket_no, flight_id" -%}
{%- set src_ldts = "boarding_no" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.link(src_pk=src_pk, 
    src_fk=src_fk, 
    src_ldts=src_ldts,
    src_source=src_source, source_model=source_model) }}
