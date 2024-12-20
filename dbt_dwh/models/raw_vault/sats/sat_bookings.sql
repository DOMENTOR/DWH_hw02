{%- set source_model = "stg_bookings" -%}
{%- set src_pk = "book_ref" -%}
{%- set src_hashdiff = "booking_hashdiff" -%}
{%- set src_payload = ["book_date", "total_amount"] -%}
{%- set src_eff = "EFFECTIVE_FROM" -%}
{%- set src_ldts = "LOAD_DATETIME" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.sat(src_pk=src_pk, src_hashdiff=src_hashdiff,
                src_payload=src_payload, src_eff=src_eff,
                src_ldts=src_ldts, src_source=src_source,
                source_model=source_model) }}
