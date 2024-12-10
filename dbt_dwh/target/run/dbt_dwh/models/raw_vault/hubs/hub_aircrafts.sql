
      insert into "postgres"."dwh_detailed_dwh_detailed"."hub_aircrafts" ("aircraft_code", "model", "record_source")
    (
        select "aircraft_code", "model", "record_source"
        from "hub_aircrafts__dbt_tmp000601809752"
    )


  