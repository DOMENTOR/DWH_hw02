
  create view "postgres"."dwh_detailed_dwh_detailed"."stg_ticket_flights__dbt_tmp"
    
    
  as (
    -- depends_on: "postgres"."dwh_detailed_dwh_detailed"."raw_ticket_flights"




WITH staging AS (-- Generated by AutomateDV (formerly known as dbtvault)

    

WITH source_data AS (

    SELECT

    ticket_no,
    flight_id,
    fare_conditions,
    amount

    FROM "postgres"."dwh_detailed_dwh_detailed"."raw_ticket_flights"
),

derived_columns AS (

    SELECT

    ticket_no,
    flight_id,
    fare_conditions,
    amount,
    'TICKET_FLIGHTS'::TEXT AS RECORD_SOURCE,
    CURRENT_TIMESTAMP AS EFFECTIVE_FROM

    FROM source_data
),

hashed_columns AS (

    SELECT

    ticket_no,
    flight_id,
    fare_conditions,
    amount,
    RECORD_SOURCE,
    EFFECTIVE_FROM,

    DECODE(MD5(NULLIF(CONCAT(
        COALESCE(NULLIF(UPPER(TRIM(CAST(ticket_no AS VARCHAR))), ''), '^^'), '||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(flight_id AS VARCHAR))), ''), '^^')
    ), '^^||^^')), 'hex') AS link_ticket_flight_pk,

    DECODE(MD5(CONCAT(
        COALESCE(NULLIF(UPPER(TRIM(CAST(amount AS VARCHAR))), ''), '^^'), '||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(fare_conditions AS VARCHAR))), ''), '^^'), '||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(flight_id AS VARCHAR))), ''), '^^'), '||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(ticket_no AS VARCHAR))), ''), '^^')
    )), 'hex') AS ticket_flight_hashdiff

    FROM derived_columns
),

columns_to_select AS (

    SELECT

    ticket_no,
    flight_id,
    fare_conditions,
    amount,
    RECORD_SOURCE,
    EFFECTIVE_FROM,
    link_ticket_flight_pk,
    ticket_flight_hashdiff

    FROM hashed_columns
)

SELECT * FROM columns_to_select)

SELECT *,
       ('2024-12-16 11:09:06.634345+00:00')::DATE AS LOAD_DATETIME
FROM staging
  );