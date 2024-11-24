
        SELECT
            ticket_no,
            flight_id,
            fare_conditions,
            amount
        FROM {{ source('system', 'ticket_flights') }}
    