{% snapshot orders_snapshot %}

    {{
        config(
          target_schema='dbt_marios_a',
          strategy='check',
          unique_key='order_id',
          check_cols=['status']
        )
    }}

    select * from {{ source('raw', 'orders') }}

{% endsnapshot %}