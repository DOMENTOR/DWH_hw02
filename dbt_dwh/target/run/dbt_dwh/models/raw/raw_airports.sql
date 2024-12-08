
  create view "postgres"."dwh_detailed_dwh_detailed"."raw_airports__dbt_tmp"
    
    
  as (
    SELECT
            airport_code,
            airport_name,
            city,
            coordinates_lon,
            coordinates_lat,
            timezone
        FROM "postgres"."system"."airports"
  );