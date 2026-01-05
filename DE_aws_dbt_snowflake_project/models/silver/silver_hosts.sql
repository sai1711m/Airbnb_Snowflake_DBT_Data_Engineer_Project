{{config(materialized = 'incremental', unique_key = 'host_id')}}

select 
    HOST_ID,
    replace(HOST_NAME, ' ', '_') as HOST_NAME,
    HOST_SINCE,
    RESPONSE_RATE,
    IS_SUPERHOST,
    case when RESPONSE_RATE > 95 then 'VERY GOOD'
         when RESPONSE_RATE > 80 then 'GOOD'
         when RESPONSE_RATE > 60 then 'AVERAGE'
         else 'POOR'
    end as RESPONSE_RATE_QUALITY,
    CREATED_AT
from {{ ref('bronze_hosts') }}