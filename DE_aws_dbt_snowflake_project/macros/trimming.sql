{% macro trim_whitespace(column_name,node) %}
    {{ column_name | trim | upper }}
{% endmacro %}