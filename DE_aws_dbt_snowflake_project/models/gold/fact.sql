SELECT 
    obt.BOOKING_ID,
    obt.LISTING_ID,
    obt.HOST_ID,
    obt.TOTAL_PRICE,
    obt.ACCOMMODATES,
    obt.BEDROOMS,
    obt.BATHROOMS,
    obt.PRICE_PER_NIGHT,
    obt.RESPONSE_RATE
FROM {{ ref('obt') }} AS obt
LEFT JOIN {{ ref('dim_listings') }} AS dim_listings
    ON obt.listing_id = dim_listings.listing_id
LEFT JOIN {{ ref('dim_hosts') }} AS dim_hosts
    ON obt.host_id = dim_hosts.host_id