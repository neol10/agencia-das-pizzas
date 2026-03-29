-- Disparo automatico de push FCM quando entra pedido novo
-- Requer extensao pg_net habilitada no Supabase.
-- Ajuste a URL do projeto se necessario.

create extension if not exists pg_net;

create or replace function public.notify_new_order_fcm()
returns trigger
language plpgsql
security definer
as $$
declare
    payload json;
    short_id text;
    target_app text := 'comanda';
begin
    short_id := right(replace(new.id::text, '-', ''), 4);

    payload := json_build_object(
        'title', 'Novo pedido',
        'body', 'Pedido #' || short_id || ' recebido. Abra a comanda.',
        'app', target_app,
        'url', '/comanda'
    );

    if to_regprocedure('net.http_post(text,jsonb,jsonb)') is not null then
        perform net.http_post(
            url := 'https://abznheaxvoffclcgqrmm.supabase.co/functions/v1/send-push'::text,
            headers := jsonb_build_object('content-type', 'application/json'),
            body := payload::jsonb
        );
    end if;

    return new;
end;
$$;

drop trigger if exists trg_notify_new_order_fcm on public.orders;

create trigger trg_notify_new_order_fcm
after insert on public.orders
for each row
execute function public.notify_new_order_fcm();
