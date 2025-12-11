with a as (
select 
    cast(null as int) as customer_id,
    cast(null as int) as book_id,
    sum(total) as jumlah_penjualan,
    avg(total) as rata_rata_penjualan,
    min(total) as min_penjualan,
    max(total) as max_penjualan
from dwh_gravity.fact_order
where status_id = 4

union

select 
    customer_id::int,
    null::int,
    sum(total),
    avg(total),
    min(total),
    max(total)
from dwh_gravity.fact_order
where status_id = 4
group by customer_id

union

select
    null::int,
    book_id::int,
    sum(total),
    avg(total),
    min(total),
    max(total)
from dwh_gravity.fact_order
where status_id = 4
group by book_id

union

select 
    customer_id::int,
    book_id::int,
    sum(total),
    avg(total),
    min(total),
    max(total)
from dwh_gravity.fact_order
where status_id = 4
group by customer_id, book_id
)
select count(1) from a;