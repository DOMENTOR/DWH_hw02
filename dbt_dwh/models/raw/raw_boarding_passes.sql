
        SELECT
            ticket_no,
            flight_id,
            boarding_no,
            seat_no
        FROM {{ source('system', 'boarding_passes') }}
    