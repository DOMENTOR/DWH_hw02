{%- set source_model = "stg_tickets" -%}
{%- set src_pk = "book_ref, ticket_no" -%}
-- {%- set src_nk = "book_ref, ticket_no" -%}
{%- set src_ldts = "passenger_id" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.link(
    src_pk=src_pk, 
    -- src_nk=src_nk, 
    src_ldts=src_ldts,
    src_source=src_source, 
    source_model=source_model) }}
