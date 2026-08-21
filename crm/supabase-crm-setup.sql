-- Adds shared CRM workflow records to the existing Franchise Job Status Hub.
-- Prototype policy remains open-link to match the existing hub. Before production,
-- replace these policies with authenticated Microsoft 365 / CRM role policies.

create table if not exists public.crm_tasks (
  job_number text primary key,
  action text not null default '',
  owner text not null default '',
  due_date date,
  priority text not null default 'Normal' check (priority in ('Low','Normal','High')),
  state text not null default 'Open' check (state in ('Open','In progress','Complete')),
  support_requested boolean not null default false,
  unread boolean not null default true,
  updated_by text not null default 'Prototype user',
  updated_at timestamptz not null default now()
);

create table if not exists public.crm_notification_preferences (
  user_key text primary key,
  preferences jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.crm_tasks enable row level security;
alter table public.crm_notification_preferences enable row level security;

drop policy if exists "open crm tasks" on public.crm_tasks;
create policy "open crm tasks" on public.crm_tasks for all to anon, authenticated using (true) with check (true);

drop policy if exists "open crm notification preferences" on public.crm_notification_preferences;
create policy "open crm notification preferences" on public.crm_notification_preferences for all to anon, authenticated using (true) with check (true);

grant select, insert, update, delete on public.crm_tasks to anon, authenticated;
grant select, insert, update, delete on public.crm_notification_preferences to anon, authenticated;

do $$
begin
  if not exists (select 1 from pg_publication_tables where pubname='supabase_realtime' and schemaname='public' and tablename='crm_tasks') then
    alter publication supabase_realtime add table public.crm_tasks;
  end if;
end
$$;
