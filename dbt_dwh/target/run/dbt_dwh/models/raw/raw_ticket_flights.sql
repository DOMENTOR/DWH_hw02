
  create view "postgres"."dwh_detailed_dwh_detailed"."raw_ticket_flights__dbt_tmp"
    
    
  as (
    SELECT
            ticket_no,
            flight_id,
            fare_conditions,
            amount
        FROM "postgres"."system"."ticket_flights"
  );