  -- depends_on: {{ ref('stg_tickets') }}
{%- set source_model = "stg_tickets" -%}
{%- set src_pk = ['book_ref', 'ticket_no'] -%}
{%- set src_fk = ['book_ref', 'ticket_no'] -%}
{%- set src_ldts = "LOAD_DATETIME" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.link(
    src_pk=src_pk, 
    src_fk=src_fk, 
    src_ldts=src_ldts,
    src_source=src_source, 
    source_model=source_model) }}
