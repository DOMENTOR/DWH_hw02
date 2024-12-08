
  create view "postgres"."dwh_detailed_dwh_detailed"."raw_aircrafts__dbt_tmp"
    
    
  as (
    SELECT
            aircraft_code,
            model,
            range
        FROM "postgres"."system"."aircrafts"
  );