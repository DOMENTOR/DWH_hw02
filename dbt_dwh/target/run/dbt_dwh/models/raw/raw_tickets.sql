
  create view "postgres"."dwh_detailed_dwh_detailed"."raw_tickets__dbt_tmp"
    
    
  as (
    SELECT
            ticket_no,
            book_ref,
            passenger_id,
            passenger_name,
            contact_data
        FROM "postgres"."system"."tickets"
  );