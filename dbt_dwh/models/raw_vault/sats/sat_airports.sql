{%- set source_model = "stg_airports" -%}
{%- set src_pk = "airport_code" -%}
{%- set src_nk = "airport_code" -%}
{%- set src_ldts = "timezone" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{%- set columns = {
    'airport_name': 'TEXT',
    'city': 'TEXT',
    'coordinates_lon': 'DOUBLE PRECISION',
    'coordinates_lat': 'DOUBLE PRECISION',
    'timezone': 'TEXT'
} -%}

{{ automate_dv.satellite(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts, 
                src_source=src_source, columns=columns, source_model=source_model) }}
