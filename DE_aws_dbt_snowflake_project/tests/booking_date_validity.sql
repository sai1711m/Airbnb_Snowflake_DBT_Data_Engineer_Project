-- Test: Booking date should not be in the future
{{ config(severity = 'warn') }}

select booking_id, booking_date
from {{ ref('silver_bookings') }}
where booking_date > current_date()
