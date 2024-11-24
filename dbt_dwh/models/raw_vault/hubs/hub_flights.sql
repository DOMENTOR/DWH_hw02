{%- set source_model = "stg_flights" -%}
{%- set src_pk = "flight_id" -%}
{%- set src_nk = "flight_no" -%}
{%- set src_ldts = "scheduled_departure" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
