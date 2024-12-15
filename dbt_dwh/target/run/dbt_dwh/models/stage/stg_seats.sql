
  create view "postgres"."dwh_detailed_dwh_detailed"."stg_seats__dbt_tmp"
    
    
  as (
    -- depends_on: "postgres"."dwh_detailed_dwh_detailed"."raw_seats"




WITH staging AS (-- Generated by AutomateDV (formerly known as dbtvault)

    

WITH source_data AS (

    SELECT

    aircraft_code,
    seat_no,
    fare_conditions

    FROM "postgres"."dwh_detailed_dwh_detailed"."raw_seats"
),

derived_columns AS (

    SELECT

    aircraft_code,
    seat_no,
    fare_conditions,
    'SEATS'::TEXT AS RECORD_SOURCE,
    CURRENT_TIMESTAMP AS EFFECTIVE_FROM

    FROM source_data
),

hashed_columns AS (

    SELECT

    aircraft_code,
    seat_no,
    fare_conditions,
    RECORD_SOURCE,
    EFFECTIVE_FROM,

    DECODE(MD5(NULLIF(CONCAT(
        COALESCE(NULLIF(UPPER(TRIM(CAST(aircraft_code AS VARCHAR))), ''), '^^'), '||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(seat_no AS VARCHAR))), ''), '^^')
    ), '^^||^^')), 'hex') AS seat_pk,

    DECODE(MD5(CONCAT(
        COALESCE(NULLIF(UPPER(TRIM(CAST(aircraft_code AS VARCHAR))), ''), '^^'), '||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(fare_conditions AS VARCHAR))), ''), '^^'), '||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(seat_no AS VARCHAR))), ''), '^^')
    )), 'hex') AS seat_hashdiff

    FROM derived_columns
),

columns_to_select AS (

    SELECT

    aircraft_code,
    seat_no,
    fare_conditions,
    RECORD_SOURCE,
    EFFECTIVE_FROM,
    seat_pk,
    seat_hashdiff

    FROM hashed_columns
)

SELECT * FROM columns_to_select)

SELECT *,
       ('2024-12-15 15:13:34.811294+00:00')::DATE AS LOAD_DATETIME
FROM staging
  );