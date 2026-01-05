{{ config(materialized='ephemeral') }}

with listings as 
(
    select
        listing_id,
        PROPERTY_TYPE,
        ROOM_TYPE,
        CITY,
        COUNTRY,
        PRICE_PER_NIGHT_TAG,
        listing_created_at
    from {{ ref('obt') }}
)

select * from listings

