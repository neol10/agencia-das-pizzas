-- Permitir que clientes (anon) criem pedidos
-- Necessario para que a Comanda receba novos pedidos via Realtime

alter table public.orders enable row level security;

-- Remove politicas antigas caso existam
 drop policy if exists "Public Insert Orders" on public.orders;

-- Permite INSERT para anon/autenticado (cliente)
create policy "Public Insert Orders"
    on public.orders
    for insert
    with check (true);

-- Garante privilegios de INSERT para anon e authenticated
grant insert on table public.orders to anon;
grant insert on table public.orders to authenticated;

-- Atualiza cache do PostgREST
notify pgrst, 'reload schema';
