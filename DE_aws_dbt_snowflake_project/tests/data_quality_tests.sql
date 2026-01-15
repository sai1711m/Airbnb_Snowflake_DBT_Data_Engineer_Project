-- Test: Total price should be positive
{{ config(severity = 'error') }}

select booking_id, total_price
from {{ ref('silver_bookings') }}
where total_price <= 0
