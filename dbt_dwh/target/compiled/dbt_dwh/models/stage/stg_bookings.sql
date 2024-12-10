-- depends_on: "postgres"."dwh_detailed_dwh_detailed"."raw_bookings"




WITH staging AS (-- Generated by AutomateDV (formerly known as dbtvault)

    

WITH source_data AS (

    SELECT

    book_ref,
    book_date,
    total_amount

    FROM "postgres"."dwh_detailed_dwh_detailed"."raw_bookings"
),

derived_columns AS (

    SELECT

    book_ref,
    book_date,
    total_amount,
    'BOOKINGS'::TEXT AS RECORD_SOURCE,
    CURRENT_TIMESTAMP AS EFFECTIVE_FROM

    FROM source_data
),

hashed_columns AS (

    SELECT

    book_ref,
    book_date,
    total_amount,
    RECORD_SOURCE,
    EFFECTIVE_FROM,

    DECODE(MD5(NULLIF(UPPER(TRIM(CAST(book_ref AS VARCHAR))), '')), 'hex') AS booking_pk,

    DECODE(MD5(CONCAT(
        COALESCE(NULLIF(UPPER(TRIM(CAST(book_date AS VARCHAR))), ''), '^^'), '||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(book_ref AS VARCHAR))), ''), '^^'), '||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(total_amount AS VARCHAR))), ''), '^^')
    )), 'hex') AS booking_hashdiff

    FROM derived_columns
),

columns_to_select AS (

    SELECT

    book_ref,
    book_date,
    total_amount,
    RECORD_SOURCE,
    EFFECTIVE_FROM,
    booking_pk,
    booking_hashdiff

    FROM hashed_columns
)

SELECT * FROM columns_to_select)

SELECT *,
       ('2024-11-11')::DATE AS LOAD_DATE
FROM staging