
      insert into "postgres"."dwh_detailed_dwh_detailed"."hub_airports" ("airport_code", "timezone", "record_source")
    (
        select "airport_code", "timezone", "record_source"
        from "hub_airports__dbt_tmp000602221154"
    )


  