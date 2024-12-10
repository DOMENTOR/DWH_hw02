
  create view "postgres"."dwh_detailed_dwh_detailed"."raw_boarding_passes__dbt_tmp"
    
    
  as (
    SELECT
            ticket_no,
            flight_id,
            boarding_no,
            seat_no
        FROM "postgres"."system"."boarding_passes"
  );