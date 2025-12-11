# README.md

## Judul

Instruksi langkah-demi-langkah: Import staging, transform dengan KTR (Pentaho), load ke PostgreSQL, ekspor Excel, dan jalankan OLAP CUBE.

---

## Prasyarat

1. MySQL client dan server terinstall (versi apa pun yang kompatibel).
2. PostgreSQL (psql) terinstall dan dapat diakses.
3. Pentaho Data Integration (Spoon) untuk membuat/menjalankan KTR.
4. Akses ke folder project: `/` di mana file KTR, SQL, dan hasil akan disimpan.

---

## Struktur berkas contoh

```
/
├─ Data/
│  ├─ dim_address_202512102355.sql
│  ├─ dim_book_202512102355
│  ├─ dim_customer_202512102355.sql
│  ├─ dim_shipping_method_202512102355.sql
│  ├─ dim_status_order_202512102355.sql
│  └─ fact_order_202512102355.sql
├─ ETL/
│  ├─ dim_address.ktr
│  ├─ dim_book.ktr
│  ├─ dim_customer.ktr
│  ├─ dim_shipping_method.ktr
│  ├─ dim_status_order.ktr
│  └─ fact_order.ktr
├─ Load/
│  ├─ dim_address.xls
│  ├─ dim_book.xls
│  ├─ dim_customer.xls
│  ├─ dim_shipping_method.xls
│  ├─ dim_status_order.xls
│  └─ fact_order.xls
└─ Olap CUBE/
|  ├─ cube_2_dimension_fact_order.sql
│  ├─ cube_3_dimension_fact_order.sql
│  └─ cube_4_dimension_fact_order.sql
```

---

## 1) Import `staging_gravity.sql` ke MySQL / Dbeaver or everything

## 2) Buat step untuk masing-masing dimensi

> Kita akan menggunakan Pentaho Data Integration (Spoon) dan menyimpan setiap langkah transformasi sebagai KTR terpisah.

**Rekomendasi umum untuk setiap `dim_*.ktr`:**

* Nama file: `dim_<nama_dim>.ktr` (mis. `dim_address.ktr`).
* Input: `Table input` atau `Table input (database)`.
* Transformasi umum:

  1. **Table input** — ambil kolom yang diperlukan dari tabel staging.
  2. **Select values** — ubah nama kolom / tipe (cast) / hapus kolom yang tidak perlu.
  3. **User Defined Java Expression** / **Modified Java Script** (jika butuh transformasi logika/intermediate).
  4. **Replace in String / String Operations** — normalisasi teks jika perlu.
  5. **Database lookup** atau **Dimension lookup/update** — untuk lookup surrogate key (jika menggunakan slowly changing dimensions).
  6. **Table output** — tulis ke database target (bisa MySQL staging table atau langsung ke PostgreSQL jika pipeline mendukung).



**Contoh Table output**

* Jika menulis ke PostgreSQL dari Spoon, konfigurasikan connection ke PostgreSQL dan pakai `Table output` dengan `Insert / Update` sesuai kebutuhan.

Ulangi pola di atas untuk:

* `dim_address`
* `dim_customer`
* `dim_book`
* `dim_shipping_method`
* `dim_status_order`

Catatan penting:



## 3) Load data ke PostgreSQL dan bentuk Excel

**A. Opsi A — Tulisan langsung ke PostgreSQL dari Pentaho**

1. Di Spoon, tambahkan koneksi ke PostgreSQL (`host`, `port`, `db`, `user`, `password`).
2. Pada transformasi `Table output`, pilih connection PostgreSQL dan nama tabel target (mis. `dw.dim_address`).
3. Jalankan transformasi untuk menulis langsung ke Postgres.

**B. Opsi B — Ekspor CSV lalu import ke PostgreSQL**

    
