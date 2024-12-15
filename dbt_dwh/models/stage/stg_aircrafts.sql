  -- depends_on: {{ ref('raw_aircrafts') }}
{%- set yaml_metadata -%}
source_model: 'raw_aircrafts'
derived_columns:
  RECORD_SOURCE: '!AIRCRAFTS'
  EFFECTIVE_FROM: 'CURRENT_TIMESTAMP'
hashed_columns:
  aircraft_pk: 'aircraft_code'
  aircraft_hashdiff:
    is_hashdiff: true
    columns:
      - 'aircraft_code'
      - 'model'
      - 'range'
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
