-- Generated by AutomateDV (formerly known as dbtvault)

    WITH source_data AS (
    SELECT a.book_ref, a.bookings_hashdiff, a.book_date, a.total_amount, a.EFFECTIVE_FROM, a.LOAD_DATE, a.RECORD_SOURCE
    FROM "postgres"."dwh_detailed_dwh_detailed"."stg_bookings" AS a
    WHERE a.book_ref IS NOT NULL
),

latest_records AS (
    SELECT a.book_ref, a.bookings_hashdiff, a.LOAD_DATE
    FROM (
        SELECT current_records.book_ref, current_records.bookings_hashdiff, current_records.LOAD_DATE,
            RANK() OVER (
                PARTITION BY current_records.book_ref
                ORDER BY current_records.LOAD_DATE DESC
            ) AS rank
        FROM "postgres"."dwh_detailed_dwh_detailed"."sat_bookings" AS current_records
            JOIN (
                SELECT DISTINCT source_data.book_ref
                FROM source_data
            ) AS source_records
                ON current_records.book_ref = source_records.book_ref
    ) AS a
    WHERE a.rank = 1
),

records_to_insert AS (
    SELECT DISTINCT stage.book_ref, stage.bookings_hashdiff, stage.book_date, stage.total_amount, stage.EFFECTIVE_FROM, stage.LOAD_DATE, stage.RECORD_SOURCE
    FROM source_data AS stage
    LEFT JOIN latest_records
    ON latest_records.book_ref = stage.book_ref
        AND latest_records.bookings_hashdiff = stage.bookings_hashdiff
    WHERE latest_records.bookings_hashdiff IS NULL

)

SELECT * FROM records_to_insert