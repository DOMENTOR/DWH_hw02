  -- depends_on: {{ ref('raw_tickets') }}
{%- set yaml_metadata -%}
source_model: 'raw_tickets'
derived_columns:
  RECORD_SOURCE: '!TICKETS'
  EFFECTIVE_FROM: 'CURRENT_TIMESTAMP'
hashed_columns:
  ticket_pk: 'ticket_no'
  booking_fk: 'book_ref'
  ticket_hashdiff:
    is_hashdiff: true
    columns:
      - 'ticket_no'
      - 'book_ref'
      - 'passenger_id'
      - 'passenger_name'
      - 'contact_data'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}
{% set source_model = metadata_dict['source_model'] %}
{% set derived_columns = metadata_dict['derived_columns'] %}
{% set hashed_columns = metadata_dict['hashed_columns'] %}

WITH staging AS ({{ automate_dv.stage(include_source_columns=true,
                  source_model=source_model,
                  derived_columns=derived_columns,
                  hashed_columns=hashed_columns,
                  ranked_columns=none) }})

SELECT *,
       ('{{ var('LOAD_DATETIME') }}')::DATE AS LOAD_DATETIME
FROM staging
