
        SELECT
            aircraft_code,
            seat_no,
            fare_conditions
        FROM {{ source('system', 'seats') }}
    