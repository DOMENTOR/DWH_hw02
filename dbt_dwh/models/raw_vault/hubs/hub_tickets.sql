 -- depends_on: {{ ref('stg_seats') }}
{%- set source_model = "stg_tickets" -%}
{%- set src_pk = "ticket_no" -%}
{%- set src_nk = "ticket_no" -%}
{%- set src_ldts = "LOAD_DATETIME" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
