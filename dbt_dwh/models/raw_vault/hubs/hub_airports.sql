-- depends_on: {{ ref('stg_airports') }}
{%- set source_model = "stg_airports" -%}
{%- set src_pk = "airport_code" -%}
{%- set src_nk = "airport_code" -%}
{%- set src_ldts = "LOAD_DATETIME" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
