-- Test: Booking amount should be reasonable
{{ config(severity = 'warn') }}

select booking_id, booking_amount
from {{ source('staging', 'bookings') }}
where booking_amount < 0 or booking_amount > 100000