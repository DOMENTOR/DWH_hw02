
        SELECT
            book_ref,
            book_date,
            total_amount
        FROM {{ source('system', 'bookings') }}
    