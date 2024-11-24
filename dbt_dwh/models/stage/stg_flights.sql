{%- set yaml_metadata -%}
source_model: 'raw_flights'
derived_columns:
  RECORD_SOURCE: '!FLIGHTS'
  EFFECTIVE_FROM: 'CURRENT_TIMESTAMP'
hashed_columns:
  flight_pk: 'flight_id'
  flight_hashdiff:
    is_hashdiff: true
    columns:
      - 'flight_no'
      - 'scheduled_departure'
      - 'scheduled_arrival'
      - 'departure_airport'
      - 'arrival_airport'
      - 'status'
      - 'aircraft_code'
      - 'actual_departure'
      - 'actual_arrival'
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
