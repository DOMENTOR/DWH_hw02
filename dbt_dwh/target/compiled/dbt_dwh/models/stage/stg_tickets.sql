-- depends_on: "postgres"."dwh_detailed_dwh_detailed"."raw_tickets"




WITH staging AS (-- Generated by AutomateDV (formerly known as dbtvault)

    

WITH source_data AS (

    SELECT

    ticket_no,
    book_ref,
    passenger_id,
    passenger_name,
    contact_data

    FROM "postgres"."dwh_detailed_dwh_detailed"."raw_tickets"
),

derived_columns AS (

    SELECT

    ticket_no,
    book_ref,
    passenger_id,
    passenger_name,
    contact_data,
    'TICKETS'::TEXT AS RECORD_SOURCE,
    CURRENT_TIMESTAMP AS EFFECTIVE_FROM

    FROM source_data
),

hashed_columns AS (

    SELECT

    ticket_no,
    book_ref,
    passenger_id,
    passenger_name,
    contact_data,
    RECORD_SOURCE,
    EFFECTIVE_FROM,

    DECODE(MD5(NULLIF(UPPER(TRIM(CAST(ticket_no AS VARCHAR))), '')), 'hex') AS ticket_pk,

    DECODE(MD5(NULLIF(UPPER(TRIM(CAST(book_ref AS VARCHAR))), '')), 'hex') AS booking_fk,

    DECODE(MD5(CONCAT(
        COALESCE(NULLIF(UPPER(TRIM(CAST(book_ref AS VARCHAR))), ''), '^^'), '||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(contact_data AS VARCHAR))), ''), '^^'), '||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(passenger_id AS VARCHAR))), ''), '^^'), '||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(passenger_name AS VARCHAR))), ''), '^^'), '||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(ticket_no AS VARCHAR))), ''), '^^')
    )), 'hex') AS ticket_hashdiff

    FROM derived_columns
),

columns_to_select AS (

    SELECT

    ticket_no,
    book_ref,
    passenger_id,
    passenger_name,
    contact_data,
    RECORD_SOURCE,
    EFFECTIVE_FROM,
    ticket_pk,
    booking_fk,
    ticket_hashdiff

    FROM hashed_columns
)

SELECT * FROM columns_to_select)

SELECT *,
       ('2024-12-16 11:09:06.634345+00:00')::DATE AS LOAD_DATETIME
FROM staging