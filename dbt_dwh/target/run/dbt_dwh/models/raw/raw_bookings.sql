
  create view "postgres"."dwh_detailed_dwh_detailed"."raw_bookings__dbt_tmp"
    
    
  as (
    SELECT
            book_ref,
            book_date,
            total_amount
        FROM "postgres"."system"."bookings"
  );