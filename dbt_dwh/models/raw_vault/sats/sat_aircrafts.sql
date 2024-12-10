{%- set source_model = "stg_aircrafts" -%}
{%- set src_pk = "aircraft_code" -%}
{%- set src_hashdiff = "aircrafts_hashdiff" -%}
{%- set src_payload = ["model", "range"] -%}
{%- set src_eff = "EFFECTIVE_FROM" -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.sat(src_pk=src_pk, src_hashdiff=src_hashdiff,
                src_payload=src_payload, src_eff=src_eff,
                src_ldts=src_ldts, src_source=src_source,
                source_model=source_model) }}
