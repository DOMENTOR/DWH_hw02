  -- depends_on: {{ ref('raw_ticket_flights') }}
{%- set yaml_metadata -%}
source_model: 'raw_ticket_flights'
derived_columns:
  RECORD_SOURCE: '!TICKET_FLIGHTS'
  EFFECTIVE_FROM: 'CURRENT_TIMESTAMP'
hashed_columns:
  link_ticket_flight_pk:
    - 'ticket_no'
    - 'flight_id'
  ticket_flight_hashdiff:
    is_hashdiff: true
    columns:
      - 'ticket_no'
      - 'flight_id'
      - 'fare_conditions'
      - 'amount'
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
       ('{{ var('load_date') }}')::DATE AS LOAD_DATE
FROM staging
