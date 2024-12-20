
  create view "postgres"."dwh_detailed_dwh_detailed"."stg_aircrafts__dbt_tmp"
    
    
  as (
    -- depends_on: "postgres"."dwh_detailed_dwh_detailed"."raw_aircrafts"




WITH staging AS (-- Generated by AutomateDV (formerly known as dbtvault)

    

WITH source_data AS (

    SELECT

    aircraft_code,
    model,
    range

    FROM "postgres"."dwh_detailed_dwh_detailed"."raw_aircrafts"
),

derived_columns AS (

    SELECT

    aircraft_code,
    model,
    range,
    'AIRCRAFTS'::TEXT AS RECORD_SOURCE,
    CURRENT_TIMESTAMP AS EFFECTIVE_FROM

    FROM source_data
),

hashed_columns AS (

    SELECT

    aircraft_code,
    model,
    range,
    RECORD_SOURCE,
    EFFECTIVE_FROM,

    DECODE(MD5(NULLIF(UPPER(TRIM(CAST(aircraft_code AS VARCHAR))), '')), 'hex') AS aircraft_pk,

    DECODE(MD5(CONCAT(
        COALESCE(NULLIF(UPPER(TRIM(CAST(aircraft_code AS VARCHAR))), ''), '^^'), '||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(model AS VARCHAR))), ''), '^^'), '||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(range AS VARCHAR))), ''), '^^')
    )), 'hex') AS aircraft_hashdiff

    FROM derived_columns
),

columns_to_select AS (

    SELECT

    aircraft_code,
    model,
    range,
    RECORD_SOURCE,
    EFFECTIVE_FROM,
    aircraft_pk,
    aircraft_hashdiff

    FROM hashed_columns
)

SELECT * FROM columns_to_select)

SELECT *,
       ('2024-12-16 11:09:06.634345+00:00')::DATE AS LOAD_DATETIME
FROM staging
  );