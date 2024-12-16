
  create view "postgres"."dwh_detailed_dwh_detailed"."stg_airports__dbt_tmp"
    
    
  as (
    -- depends_on: "postgres"."dwh_detailed_dwh_detailed"."raw_airports"




WITH staging AS (-- Generated by AutomateDV (formerly known as dbtvault)

    

WITH source_data AS (

    SELECT

    airport_code,
    airport_name,
    city,
    coordinates_lon,
    coordinates_lat,
    timezone

    FROM "postgres"."dwh_detailed_dwh_detailed"."raw_airports"
),

derived_columns AS (

    SELECT

    airport_code,
    airport_name,
    city,
    coordinates_lon,
    coordinates_lat,
    timezone,
    'AIRPORTS'::TEXT AS RECORD_SOURCE,
    CURRENT_TIMESTAMP AS EFFECTIVE_FROM

    FROM source_data
),

hashed_columns AS (

    SELECT

    airport_code,
    airport_name,
    city,
    coordinates_lon,
    coordinates_lat,
    timezone,
    RECORD_SOURCE,
    EFFECTIVE_FROM,

    DECODE(MD5(NULLIF(UPPER(TRIM(CAST(airport_code AS VARCHAR))), '')), 'hex') AS airport_pk,

    DECODE(MD5(CONCAT(
        COALESCE(NULLIF(UPPER(TRIM(CAST(airport_code AS VARCHAR))), ''), '^^'), '||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(airport_name AS VARCHAR))), ''), '^^'), '||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(city AS VARCHAR))), ''), '^^'), '||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(coordinates_lat AS VARCHAR))), ''), '^^'), '||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(coordinates_lon AS VARCHAR))), ''), '^^'), '||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(timezone AS VARCHAR))), ''), '^^')
    )), 'hex') AS airport_hashdiff

    FROM derived_columns
),

columns_to_select AS (

    SELECT

    airport_code,
    airport_name,
    city,
    coordinates_lon,
    coordinates_lat,
    timezone,
    RECORD_SOURCE,
    EFFECTIVE_FROM,
    airport_pk,
    airport_hashdiff

    FROM hashed_columns
)

SELECT * FROM columns_to_select)

SELECT *,
       ('2024-12-16 11:09:06.634345+00:00')::DATE AS LOAD_DATETIME
FROM staging
  );