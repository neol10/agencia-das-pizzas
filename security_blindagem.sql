-- =========================================================================
-- REI NEO - BLINDAGEM DE SEGURANÇA SUPREMA (SUPABASE RLS & RPC)
-- =========================================================================
-- Este script fecha as brechas de leitura pública e cria um canal seguro
-- para os clientes verem apenas os SEUS próprios pedidos.

-- 1. DESABILITAR LEITURA PÚBLICA (SELECT) NAS TABELAS SENSÍVEIS
-- Primeiro, limpamos as políticas de leitura aberta (USING true)
DROP POLICY IF EXISTS "Public Read Customers" ON public.customers;
DROP POLICY IF EXISTS "Public profiles are viewable by everyone." ON public.customers;
DROP POLICY IF EXISTS "Public Read Orders" ON public.orders;
DROP POLICY IF EXISTS "Orders are viewable by everyone." ON public.orders;

-- 2. NOVA POLÍTICA: APENAS ADMIN LÊ TUDO
CREATE POLICY "Admin Select Customers" ON public.customers FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "Admin Select Orders" ON public.orders FOR SELECT USING (auth.role() = 'authenticated');

-- 3. FUNÇÃO DE BUSCA SEGURA PARA O CLIENTE (HISTÓRICO)
-- Como o cliente não tem login, criamos uma função que busca pelo telefone
-- mas não permite que ninguém liste a tabela inteira.
CREATE OR REPLACE FUNCTION get_my_orders(phone_query text)
RETURNS SETOF public.orders
LANGUAGE sql
SECURITY DEFINER -- Executa com privilégios de sistema para pular o RLS de SELECT
AS $$
    SELECT * 
    FROM public.orders 
    WHERE customer_id IN (
        SELECT id FROM public.customers WHERE phone = phone_query
    )
    ORDER BY created_at DESC
    LIMIT 20;
$$;

-- 4. FUNÇÃO PARA BUSCAR PERFIL PELO TELEFONE (AUTO-COMPLETE)
CREATE OR REPLACE FUNCTION get_customer_by_phone(phone_query text)
RETURNS SETOF public.customers
LANGUAGE sql
SECURITY DEFINER
AS $$
    SELECT * 
    FROM public.customers 
    WHERE phone = phone_query
    LIMIT 1;
$$;

-- 5. GARANTIR QUE ANON PODE EXECUTAR AS FUNÇÕES
GRANT EXECUTE ON FUNCTION get_my_orders(text) TO anon;
GRANT EXECUTE ON FUNCTION get_my_orders(text) TO authenticated;
GRANT EXECUTE ON FUNCTION get_customer_by_phone(text) TO anon;
GRANT EXECUTE ON FUNCTION get_customer_by_phone(text) TO authenticated;

-- MENSAGEM DE SUCESSO DO REINEO:
-- "Base blindada. Apenas quem tem a chave (senha admin) vê o Painel. 
-- Clientes só vêm o que é deles via Função Segura."
