
      insert into "postgres"."dwh_detailed_dwh_detailed"."hub_flights" ("flight_id", "flight_no", "scheduled_departure", "record_source")
    (
        select "flight_id", "flight_no", "scheduled_departure", "record_source"
        from "hub_flights__dbt_tmp000602661855"
    )


  