-- Corrigir schema cache e coluna install_id em push_tokens_public

alter table public.push_tokens_public
    add column if not exists install_id uuid;

notify pgrst, 'reload schema';
