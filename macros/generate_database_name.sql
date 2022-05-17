{% macro generate_database_name(
        custom_database_name = none,
        node = none
    ) -%}

    {%- set default_database = target.database -%}

    {%- if custom_database_name is not none and target.name == 'prod' -%}

        {{ custom_database_name | trim }}

    {%- else -%}

        {{ default_database }}

    {%- endif -%}

{%- endmacro %}