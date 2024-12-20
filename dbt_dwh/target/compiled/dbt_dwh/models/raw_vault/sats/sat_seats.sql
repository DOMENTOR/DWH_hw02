-- Generated by AutomateDV (formerly known as dbtvault)

    WITH source_data AS (
    SELECT a.aircraft_code, a.seat_no, a.seat_hashdiff, a.fare_conditions, a.EFFECTIVE_FROM, a.LOAD_DATETIME, a.RECORD_SOURCE
    FROM "postgres"."dwh_detailed_dwh_detailed"."stg_seats" AS a
    WHERE a.aircraft_code IS NOT NULL
    AND a.seat_no IS NOT NULL
),

records_to_insert AS (
    SELECT DISTINCT stage.aircraft_code, stage.seat_no, stage.seat_hashdiff, stage.fare_conditions, stage.EFFECTIVE_FROM, stage.LOAD_DATETIME, stage.RECORD_SOURCE
    FROM source_data AS stage

)

SELECT * FROM records_to_insert