-- Shared storage for the Franchise Job Status Hub.
-- This project intentionally allows anonymous access: anyone with the site URL
-- can read and change the shared dataset.

create table if not exists public.app_state (
  key text primary key,
  value jsonb not null,
  updated_at timestamptz not null default now()
);

create table if not exists public.job_edits (
  job_number text primary key,
  edit jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.app_state enable row level security;
alter table public.job_edits enable row level security;

drop policy if exists "open shared app state" on public.app_state;
create policy "open shared app state"
on public.app_state for all
to anon, authenticated
using (true)
with check (true);

drop policy if exists "open shared job edits" on public.job_edits;
create policy "open shared job edits"
on public.job_edits for all
to anon, authenticated
using (true)
with check (true);

grant select, insert, update, delete on public.app_state to anon, authenticated;
grant select, insert, update, delete on public.job_edits to anon, authenticated;

do $$
begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'app_state'
  ) then
    alter publication supabase_realtime add table public.app_state;
  end if;

  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'job_edits'
  ) then
    alter publication supabase_realtime add table public.job_edits;
  end if;
end
$$;
