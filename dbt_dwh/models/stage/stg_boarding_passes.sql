  -- depends_on: {{ ref('raw_boarding_passes') }}
{%- set yaml_metadata -%}
source_model: 'raw_boarding_passes'
derived_columns:
  RECORD_SOURCE: '!BOARDING_PASSES'
  EFFECTIVE_FROM: 'CURRENT_TIMESTAMP'
hashed_columns:
  link_ticket_flight_pk:
    - 'ticket_no'
    - 'flight_id'
  boarding_pass_hashdiff:
    is_hashdiff: true
    columns:
      - 'boarding_no'
      - 'seat_no'
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
