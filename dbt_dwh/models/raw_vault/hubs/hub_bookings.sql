{%- set source_model = "stg_bookings" -%}
{%- set src_pk = "book_ref" -%}
{%- set src_nk = "book_ref" -%}
{%- set src_ldts = "book_date" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}