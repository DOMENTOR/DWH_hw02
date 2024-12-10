-- depends_on: "postgres"."dwh_detailed_dwh_detailed"."stg_airports"-- Generated by AutomateDV (formerly known as dbtvault)

    

WITH row_rank_1 AS (
    SELECT DISTINCT ON (rr.airport_code) rr.airport_code, rr.timezone, rr.RECORD_SOURCE
    FROM "postgres"."dwh_detailed_dwh_detailed"."stg_airports" AS rr
    WHERE rr.airport_code IS NOT NULL
    ORDER BY rr.airport_code, rr.timezone
),

records_to_insert AS (
    SELECT a.airport_code, a.timezone, a.RECORD_SOURCE
    FROM row_rank_1 AS a
    LEFT JOIN "postgres"."dwh_detailed_dwh_detailed"."hub_airports" AS d
    ON a.airport_code = d.airport_code
    WHERE d.airport_code IS NULL
)

SELECT * FROM records_to_insert