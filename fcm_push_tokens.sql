-- Tabela para armazenar tokens do Firebase Cloud Messaging (FCM)
-- Uso típico: Admin/Comanda autenticados via Supabase Auth

create table if not exists public.push_tokens (
    id uuid primary key default gen_random_uuid(),
    user_id uuid not null references auth.users(id) on delete cascade,
    app text not null,
    token text not null,
    user_agent text,
    last_seen_at timestamptz not null default now(),
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),

    constraint push_tokens_app_check check (app in ('admin', 'comanda'))
);

create unique index if not exists push_tokens_token_uniq
on public.push_tokens (token);

create index if not exists push_tokens_user_app_idx
on public.push_tokens (user_id, app);

-- updated_at automático
create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
    new.updated_at = now();
    return new;
end;
$$;

drop trigger if exists trg_push_tokens_updated_at on public.push_tokens;
create trigger trg_push_tokens_updated_at
before update on public.push_tokens
for each row
execute function public.set_updated_at();

alter table public.push_tokens enable row level security;

-- Políticas: cada usuário vê e gerencia apenas seus próprios tokens
drop policy if exists "push_tokens_select_own" on public.push_tokens;
create policy "push_tokens_select_own"
on public.push_tokens
for select
using (auth.uid() = user_id);

drop policy if exists "push_tokens_insert_own" on public.push_tokens;
create policy "push_tokens_insert_own"
on public.push_tokens
for insert
with check (auth.uid() = user_id);

drop policy if exists "push_tokens_update_own" on public.push_tokens;
create policy "push_tokens_update_own"
on public.push_tokens
for update
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists "push_tokens_delete_own" on public.push_tokens;
create policy "push_tokens_delete_own"
on public.push_tokens
for delete
using (auth.uid() = user_id);


-- ======================================================
-- TOKENS PÚBLICOS (site/cliente sem login)
-- ======================================================

create table if not exists public.push_tokens_public (
    id uuid primary key default gen_random_uuid(),
    install_id uuid,
    app text not null default 'site',
    token text not null,
    user_agent text,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create unique index if not exists push_tokens_public_token_uniq
on public.push_tokens_public (token);

drop trigger if exists trg_push_tokens_public_updated_at on public.push_tokens_public;
create trigger trg_push_tokens_public_updated_at
before update on public.push_tokens_public
for each row
execute function public.set_updated_at();

alter table public.push_tokens_public enable row level security;

-- Público só precisa inserir (sem SELECT). Edge Function com service role lê.
drop policy if exists "push_tokens_public_insert_any" on public.push_tokens_public;
create policy "push_tokens_public_insert_any"
on public.push_tokens_public
for insert
with check (
    token is not null
    and length(token) > 20
);
