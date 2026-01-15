-- Test: Host since date should be reasonable
{{ config(severity = 'error') }}

select host_id, host_since
from {{ ref('silver_hosts') }}
where host_since > current_date() or host_since < '2008-01-01'
