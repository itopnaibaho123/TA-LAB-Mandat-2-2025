with a as (
select 
    cast(null as int) as customer_id,
    cast(null as int) as book_id,
    cast(null as int) as alamat_tujuan_id,
    sum(total) as jumlah_penjualan,
    avg(total) as rata_rata_penjualan,
	min(total) as min_penjualan,
	max(total) as max_penjualan
from dwh_gravity.fact_order
where status_id IN (4)
union
select 
    cast(customer_id as int),
    cast(null as int),
    cast(null as int),
    sum(total) as jumlah_penjualan,
    avg(total) as rata_rata_penjualan,
	min(total) as min_penjualan,
	max(total) as max_penjualan
from dwh_gravity.fact_order
where status_id IN (4)
group by customer_id
union
select
    cast(null as int),
    cast(book_id as int),
    cast(null as int),
    sum(total) as jumlah_penjualan,
    avg(total) as rata_rata_penjualan,
	min(total) as min_penjualan,
	max(total) as max_penjualan
from dwh_gravity.fact_order
where status_id IN (4)
group by book_id
union
select
    cast(null as int),
    cast(null as int),
    cast(alamat_tujuan_id as int),
    sum(total) as jumlah_penjualan,
    avg(total) as rata_rata_penjualan,
	min(total) as min_penjualan,
	max(total) as max_penjualan
from dwh_gravity.fact_order
where status_id IN (4)
group by alamat_tujuan_id
union
select customer_id, book_id, alamat_tujuan_id, round(sum(total)) as jumlah_penjualan, round(avg(total)) as rata_rata_penjualan, min(total) as min_penjualan, max(total) as max_penjualan
from dwh_gravity.fact_order
where status_id IN (4)
group by customer_id, book_id, alamat_tujuan_id
)
select count(1) from a;