{% snapshot users_snapshot %}

  {{
    config(
      target_schema='dbt_marios_a',
      unique_key='user_id',
      strategy='timestamp',
      updated_at='updated_at',
    )
  }}

  select * from {{ source('raw', 'users') }}

{% endsnapshot %}