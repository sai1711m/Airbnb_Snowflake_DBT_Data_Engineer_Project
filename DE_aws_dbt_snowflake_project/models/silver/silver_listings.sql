{{config(materialized = 'incremental', unique_key = 'listing_id')}}

select 
    LISTING_ID,
    HOST_ID,
    PROPERTY_TYPE,
    ROOM_TYPE,
    CITY,
    COUNTRY,
    ACCOMMODATES,
    BEDROOMS,
    BATHROOMS,
    PRICE_PER_NIGHT,
    {{tag('cast(price_per_night as int)')}} as PRICE_PER_NIGHT_TAG,
    CREATED_AT
from {{ ref('bronze_listings') }}