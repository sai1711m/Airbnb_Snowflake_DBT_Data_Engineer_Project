{% macro tag(col) %}
    case 
        when {{ col }} < 100 then 'budget'
        when {{ col }} >= 100 and {{ col }} < 200 then 'standard'
        when {{ col }} >= 200 then 'premium'
    end
{% endmacro %}