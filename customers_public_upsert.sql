-- Permitir que clientes (anon) criem/atualizem cadastro basico

alter table public.customers enable row level security;

drop policy if exists "Public Insert Customers" on public.customers;
drop policy if exists "Public Update Customers" on public.customers;

create policy "Public Insert Customers"
    on public.customers
    for insert
    with check (true);

create policy "Public Update Customers"
    on public.customers
    for update
    using (true)
    with check (true);

-- Garante privilegios de INSERT/UPDATE para anon e authenticated
grant insert, update on table public.customers to anon;
grant insert, update on table public.customers to authenticated;

-- Atualiza cache do PostgREST
notify pgrst, 'reload schema';
