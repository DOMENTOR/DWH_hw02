
      
  
    

  create  table "postgres"."dwh_detailed_dwh_detailed"."sat_aircrafts"
  
  
    as
  
  (
    -- Generated by AutomateDV (formerly known as dbtvault)

    WITH source_data AS (
    SELECT a.aircraft_code, a.aircraft_hashdiff, a.model, a.range, a.EFFECTIVE_FROM, a.LOAD_DATETIME, a.RECORD_SOURCE
    FROM "postgres"."dwh_detailed_dwh_detailed"."stg_aircrafts" AS a
    WHERE a.aircraft_code IS NOT NULL
),

records_to_insert AS (
    SELECT DISTINCT stage.aircraft_code, stage.aircraft_hashdiff, stage.model, stage.range, stage.EFFECTIVE_FROM, stage.LOAD_DATETIME, stage.RECORD_SOURCE
    FROM source_data AS stage

)

SELECT * FROM records_to_insert
  );
  
  