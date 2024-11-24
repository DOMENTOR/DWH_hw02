{%- set source_model = "stg_tickets" -%}
{%- set src_pk = "ticket_no" -%}
{%- set src_nk = "ticket_no" -%}
{%- set src_ldts = "book_ref" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{%- set columns = {
    'passenger_id': 'VARCHAR(20)',
    'passenger_name': 'TEXT',
    'contact_data': 'JSONB'
} -%}

{{ automate_dv.satellite(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, columns=columns, source_model=source_model) }}
