SELECT 
    customer_id,
    book_id,
    SUM(total) AS jumlah_penjualan,
    AVG(total) AS rata_rata_penjualan,
    MAX(total) AS maksimum_penjualan,
    MIN(total) AS minimum_penjualan
FROM fact_order
WHERE status_id = '4'
GROUP BY CUBE (customer_id, book_id);
