{%- set yaml_metadata -%}
source_model: 'raw_seats'
derived_columns:
  RECORD_SOURCE: '!SEATS'
  EFFECTIVE_FROM: 'CURRENT_TIMESTAMP'
hashed_columns:
  seat_pk:
    - 'aircraft_code'
    - 'seat_no'
  seat_hashdiff:
    is_hashdiff: true
    columns:
      - 'aircraft_code'
      - 'seat_no'
      - 'fare_conditions'
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
