{%- set source_model = "stg_ticket_flights" -%}
{%- set src_pk = "ticket_no, flight_id" -%}
{%- set src_nk = "ticket_no, flight_id" -%}
{%- set src_ldts = "fare_conditions" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{%- set columns = {
    'fare_conditions': 'VARCHAR(10)',
    'amount': 'NUMERIC(10, 2)'
} -%}

{{ automate_dv.satellite(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts, 
                src_source=src_source, columns=columns, source_model=source_model) }}
