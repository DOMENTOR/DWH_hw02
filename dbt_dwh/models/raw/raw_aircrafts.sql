
        SELECT
            aircraft_code,
            model,
            range
        FROM {{ source('system', 'aircrafts') }}
    