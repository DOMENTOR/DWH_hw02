{%- set source_model = "stg_boarding_passes" -%}
{%- set src_pk = "ticket_no, flight_id" -%}
{%- set src_nk = "ticket_no, flight_id" -%}
{%- set src_ldts = "boarding_no" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{%- set columns = {
    'boarding_no': 'INTEGER',
    'seat_no': 'VARCHAR(4)'
} -%}

{{ automate_dv.satellite(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts, 
                src_source=src_source, columns=columns, source_model=source_model) }}
