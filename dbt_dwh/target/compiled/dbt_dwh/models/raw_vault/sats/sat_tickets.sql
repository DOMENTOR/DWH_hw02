-- Generated by AutomateDV (formerly known as dbtvault)

    WITH source_data AS (
    SELECT a.ticket_no, a.tickets_hashdiff, a.book_ref, a.passenger_id, a.passenger_name, a.contact_data, a.EFFECTIVE_FROM, a.LOAD_DATE, a.RECORD_SOURCE
    FROM "postgres"."dwh_detailed_dwh_detailed"."stg_tickets" AS a
    WHERE a.ticket_no IS NOT NULL
),

latest_records AS (
    SELECT a.ticket_no, a.tickets_hashdiff, a.LOAD_DATE
    FROM (
        SELECT current_records.ticket_no, current_records.tickets_hashdiff, current_records.LOAD_DATE,
            RANK() OVER (
                PARTITION BY current_records.ticket_no
                ORDER BY current_records.LOAD_DATE DESC
            ) AS rank
        FROM "postgres"."dwh_detailed_dwh_detailed"."sat_tickets" AS current_records
            JOIN (
                SELECT DISTINCT source_data.ticket_no
                FROM source_data
            ) AS source_records
                ON current_records.ticket_no = source_records.ticket_no
    ) AS a
    WHERE a.rank = 1
),

records_to_insert AS (
    SELECT DISTINCT stage.ticket_no, stage.tickets_hashdiff, stage.book_ref, stage.passenger_id, stage.passenger_name, stage.contact_data, stage.EFFECTIVE_FROM, stage.LOAD_DATE, stage.RECORD_SOURCE
    FROM source_data AS stage
    LEFT JOIN latest_records
    ON latest_records.ticket_no = stage.ticket_no
        AND latest_records.tickets_hashdiff = stage.tickets_hashdiff
    WHERE latest_records.tickets_hashdiff IS NULL

)

SELECT * FROM records_to_insert