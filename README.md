# Absen dan Lembur

Aplikasi satu halaman (satu file `index.html`) untuk mencatat absen masuk/pulang
dan menghitung estimasi lembur sesuai PP 35/2021. Dirancang untuk dipakai di HP.

## Fitur

- Beranda: jam berjalan, tombol absen masuk/pulang, lembur hari ini, total bulan ini, batas 18 jam per minggu
- Rekap: daftar absen per bulan, tambah, koreksi, hapus
- Pengaturan: gaji pokok, tunjangan tetap, pola kerja 5/6 hari, jam normal, istirahat, pembulatan, hari libur nasional
- Upah sejam = (gaji pokok + tunjangan tetap) ÷ 173

## Struktur repo

```
.
├── index.html            # seluruh aplikasi (HTML + CSS + JS)
├── supabase/
│   └── schema.sql        # tabel + RLS untuk Supabase
├── .nojekyll             # supaya GitHub Pages menyajikan file apa adanya
├── .gitignore
└── README.md
```

## Status

- [x] Versi lokal (data di localStorage browser)
- [x] Skema Supabase siap (`supabase/schema.sql`)
- [ ] Integrasi Supabase di `index.html` (login + sinkron data)

## Setup Supabase

1. Buat project di [supabase.com](https://supabase.com).
2. Buka **SQL Editor**, tempel isi `supabase/schema.sql`, lalu **Run**.
3. Di **Authentication > Providers**, aktifkan metode login yang dipilih.
4. Di **Project Settings > API**, salin **Project URL** dan **anon (public) key**.
5. Tempel keduanya di bagian konfigurasi `index.html` (setelah integrasi dikerjakan).

> Hanya `anon key` yang boleh ada di repo, dan itu aman selama RLS aktif.
> `service_role key` **jangan pernah** masuk ke repo atau ke file HTML.

## Deploy ke GitHub Pages

1. Push semua file ke branch `main`.
2. Di repo: **Settings > Pages > Build and deployment**, pilih **Deploy from a branch**, branch `main`, folder `/ (root)`.
3. Setelah beberapa menit, app bisa dibuka di `https://<username>.github.io/<nama-repo>/`.
4. Tambahkan URL itu ke **Authentication > URL Configuration** di Supabase (Site URL dan Redirect URLs).

## Catatan

Hitungan lembur adalah estimasi. Slip gaji resmi perusahaan yang berlaku.
