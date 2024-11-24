
        SELECT
            ticket_no,
            book_ref,
            passenger_id,
            passenger_name,
            contact_data
        FROM {{ source('system', 'tickets') }}
    