{% snapshot status_snapshot %}

    {{
        config(
            target_database = "dev_db",
            target_schema = "dbt_tarekmalsaleh",
            strategy='check',
            unique_key='order_id',
            check_cols=['status'],
        )
    }}
    SELECT * FROM {{source("postgres", "orders")}}
{% endsnapshot %}
