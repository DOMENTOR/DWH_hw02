
      insert into "postgres"."dwh_detailed_dwh_detailed"."hub_bookings" ("book_ref", "book_date", "record_source")
    (
        select "book_ref", "book_date", "record_source"
        from "hub_bookings__dbt_tmp000602446535"
    )


  