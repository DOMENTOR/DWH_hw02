{%- set source_model = "stg_seats" -%}
{%- set src_pk = "aircraft_code, seat_no" -%}
{%- set src_hashdiff = "seats_hashdiff" -%}
{%- set src_payload = ["fare_conditions"] -%}
{%- set src_eff = "EFFECTIVE_FROM" -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.sat(src_pk=src_pk, src_hashdiff=src_hashdiff,
                src_payload=src_payload, src_eff=src_eff,
                src_ldts=src_ldts, src_source=src_source,
                source_model=source_model) }}
