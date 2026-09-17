-- Birthday Bloom Supabase setup
-- Run this entire script in Supabase Dashboard > SQL Editor.
-- This is safe to run again: it recreates the policies cleanly.

create table if not exists public.birthday_sites (
  site_key text primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.birthday_sites enable row level security;

drop policy if exists "Anyone can read a birthday site by its key" on public.birthday_sites;
drop policy if exists "Anyone can save a birthday site by its key" on public.birthday_sites;
drop policy if exists "Anyone can update a birthday site by its key" on public.birthday_sites;

create policy "Anyone can read a birthday site by its key"
on public.birthday_sites
for select
to anon, authenticated
using (true);

create policy "Anyone can save a birthday site by its key"
on public.birthday_sites
for insert
to anon, authenticated
with check (char_length(site_key) between 1 and 120);

create policy "Anyone can update a birthday site by its key"
on public.birthday_sites
for update
to anon, authenticated
using (char_length(site_key) between 1 and 120)
with check (char_length(site_key) between 1 and 120);

-- Public-read storage bucket for exact media URLs.
-- The app uploads into: site-key/photos/... and site-key/audio/...
insert into storage.buckets (id, name, public)
values ('birthday-media', 'birthday-media', true)
on conflict (id) do update set public = true;

drop policy if exists "Public read access to birthday media" on storage.objects;
drop policy if exists "Anyone can upload birthday media" on storage.objects;

create policy "Public read access to birthday media"
on storage.objects
for select
to public
using (bucket_id = 'birthday-media');

create policy "Anyone can upload birthday media"
on storage.objects
for insert
to anon, authenticated
with check (
  bucket_id = 'birthday-media'
  and name is not null
  and length(name) <= 500
);

-- Optional: allow replacing the same path later. The current app uses unique
-- timestamped paths, so this policy is not required for normal uploads.
drop policy if exists "Anyone can update birthday media" on storage.objects;
create policy "Anyone can update birthday media"
on storage.objects
for update
to anon, authenticated
using (bucket_id = 'birthday-media')
with check (bucket_id = 'birthday-media');
