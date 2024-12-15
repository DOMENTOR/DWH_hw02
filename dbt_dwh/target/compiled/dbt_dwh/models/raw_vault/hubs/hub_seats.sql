-- depends_on: "postgres"."dwh_detailed_dwh_detailed"."stg_seats"-- Generated by AutomateDV (formerly known as dbtvault)

    

WITH row_rank_1 AS (
    SELECT DISTINCT ON (rr.aircraft_code, rr.seat_no) rr.aircraft_code, rr.seat_no, rr.LOAD_DATETIME, rr.RECORD_SOURCE
    FROM "postgres"."dwh_detailed_dwh_detailed"."stg_seats" AS rr
    WHERE rr.aircraft_code IS NOT NULL
    AND rr.seat_no IS NOT NULL
    ORDER BY rr.aircraft_code, rr.seat_no, rr.LOAD_DATETIME
),

records_to_insert AS (
    SELECT a.aircraft_code, a.seat_no, a.LOAD_DATETIME, a.RECORD_SOURCE
    FROM row_rank_1 AS a
)

SELECT * FROM records_to_insert