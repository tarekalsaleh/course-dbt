Q1) 130 users
```sql
select 
    count(user_id) as total_users 
from 
    dev_db.dbt_tarekmalsaleh.stg_users
```

Q2) 7.52 orders per hour
```sql
with orders_per_hour as
(select 
    date_trunc('HOUR', CREATED_AT) as created_at_hour,
    count(order_id) as order_count
from dev_db.dbt_tarekmalsaleh.stg_orders
group by 1
)
select avg(order_count) from orders_per_hour
```

Q3) 93.4 hours
```sql
with order_transit_time as
(
    select 
        datediff('HOUR', CREATED_AT, DELIVERED_AT) AS transit_duration
    from 
        dev_db.dbt_tarekmalsaleh.stg_orders
    where 
        status = 'delivered'
)
select avg(transit_duration) from order_transit_time
```

Q4) 1 purchase: 25, 2 purchases: 28, 3+ purchases: 71
```sql
with purchases_per_user as
(
    select
        user_id,
        count(order_id) as purchases
    from
        dev_db.dbt_tarekmalsaleh.stg_orders
    group by
        user_id
)

select
    case
        when purchases = 1 then '1 purchase'
        when purchases = 2 then '2 purchases'
        when purchases >= 3 then '3+ purchases'
    end as no_of_purchases,
    count(user_id) as no_of_users
from purchases_per_user
group by no_of_purchases
```

Q5) 16.32 sessions per hour
```sql
with sessions_per_hour as
(select 
    date_trunc('HOUR', CREATED_AT) as created_at_hour,
    count(distinct(session_id)) as sessions
from 
    dev_db.dbt_tarekmalsaleh.stg_events
group by
    1)
select avg(sessions) from sessions_per_hour
```
