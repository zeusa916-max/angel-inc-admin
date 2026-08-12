-- ANGEL INC products table. Run in Supabase SQL Editor.
create extension if not exists "pgcrypto";
create table if not exists public.products(
 id uuid primary key default gen_random_uuid(),
 name text not null,
 category text not null check(category in ('Parfume','Body Mist','Body Wash','Body Scrub','Baju','Jaket','Sepatu')),
 price numeric(12,2) not null default 0,
 stock integer not null default 0,
 image_url text,
 description text,
 is_active boolean not null default true,
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now()
);
create or replace function public.set_updated_at() returns trigger language plpgsql as $$begin new.updated_at=now(); return new;end;$$;
drop trigger if exists products_updated on public.products;
create trigger products_updated before update on public.products for each row execute function public.set_updated_at();
alter table public.products enable row level security;
drop policy if exists "Public active products" on public.products;
create policy "Public active products" on public.products for select to anon,authenticated using(is_active=true);
drop policy if exists "Authenticated insert" on public.products;
create policy "Authenticated insert" on public.products for insert to authenticated with check(true);
drop policy if exists "Authenticated update" on public.products;
create policy "Authenticated update" on public.products for update to authenticated using(true) with check(true);
drop policy if exists "Authenticated delete" on public.products;
create policy "Authenticated delete" on public.products for delete to authenticated using(true);
-- Untuk production, batasi CRUD authenticated menjadi akun dengan role admin.
