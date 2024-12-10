
      insert into "postgres"."dwh_detailed_dwh_detailed"."hub_tickets" ("ticket_no", "book_ref", "record_source")
    (
        select "ticket_no", "book_ref", "record_source"
        from "hub_tickets__dbt_tmp000603027645"
    )


  