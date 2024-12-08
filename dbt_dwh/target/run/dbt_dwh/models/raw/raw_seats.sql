
  create view "postgres"."dwh_detailed_dwh_detailed"."raw_seats__dbt_tmp"
    
    
  as (
    SELECT
            aircraft_code,
            seat_no,
            fare_conditions
        FROM "postgres"."system"."seats"
  );