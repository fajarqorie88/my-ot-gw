-- Absen dan Lembur: skema Supabase
-- Jalankan di Supabase Dashboard > SQL Editor.
-- Semua tabel dikunci per user lewat Row Level Security (RLS).

create table if not exists public.settings (
  user_id    uuid primary key default auth.uid() references auth.users(id) on delete cascade,
  pokok      numeric  not null default 0,
  tunj       numeric  not null default 0,
  pola       smallint not null default 5  check (pola in (5, 6)),
  mulai      time     not null default '08:00',
  selesai    time     not null default '17:00',
  istirahat  integer  not null default 60 check (istirahat >= 0),
  pembulatan integer  not null default 30 check (pembulatan in (1, 30, 60)),
  hari       jsonb    not null default '{}'::jsonb,
  deduksi    jsonb    not null default '{}'::jsonb,
  insentif   jsonb    not null default '{}'::jsonb,
  tunjangan  jsonb    not null default '[]'::jsonb,
  profil     jsonb    not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

create table if not exists public.attendance (
  user_id    uuid not null default auth.uid() references auth.users(id) on delete cascade,
  tanggal    date not null,
  jam_masuk  time not null,
  jam_pulang time,
  updated_at timestamptz not null default now(),
  primary key (user_id, tanggal)
);

create table if not exists public.holidays (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  tanggal date not null,
  primary key (user_id, tanggal)
);

alter table public.settings   enable row level security;
alter table public.attendance enable row level security;
alter table public.holidays   enable row level security;

create policy "settings: milik sendiri" on public.settings
  for all to authenticated
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "attendance: milik sendiri" on public.attendance
  for all to authenticated
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "holidays: milik sendiri" on public.holidays
  for all to authenticated
  using (auth.uid() = user_id) with check (auth.uid() = user_id);
