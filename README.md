# ANGEL INC ADMIN PORTAL

Repository terpisah dari website pelanggan (`website-angel-inc`) dan dapat memakai project Supabase yang sama.

## Setup
1. Jalankan `supabase-schema.sql` di Supabase SQL Editor.
2. Buat user admin di Supabase Authentication > Users.
3. Buka `admin.js` dan isi `SUPABASE_URL` serta `SUPABASE_ANON_KEY`.
4. Jangan pernah memasukkan `service_role` key ke browser.
5. Deploy folder ini sebagai project Vercel terpisah, misalnya `angel-inc-admin`.

Portal menyediakan login Supabase Auth dan CRUD produk: tambah, edit, hapus, aktif/nonaktif, harga, stok, kategori, deskripsi, dan URL foto.

Website pelanggan tidak disentuh. Agar produk yang dibuat admin tampil di website pelanggan, bagian katalog website pelanggan nantinya membaca tabel `products` dari Supabase dan hanya menampilkan `is_active = true`.

Catatan keamanan: SQL contoh memberi CRUD kepada semua user `authenticated`. Untuk produksi, sebaiknya dibuat role admin/RLS yang lebih ketat.
