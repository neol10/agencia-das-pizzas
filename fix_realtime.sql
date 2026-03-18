-- GARANTIR REALTIME NA TABELA DE PEDIDOS
-- Este script garante que a tabela 'orders' envie atualizações em tempo real para o KDS.

-- 1. Verifica e adiciona a tabela à publicação do Supabase Realtime
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_publication_tables 
        WHERE pubname = 'supabase_realtime' AND tablename = 'orders'
    ) THEN
        ALTER PUBLICATION supabase_realtime ADD TABLE orders;
    END IF;
END $$;

-- 2. Garante que os dados completos sejam enviados nas atualizações
ALTER TABLE orders REPLICA IDENTITY FULL;

-- 3. Mensagem de sucesso
-- O KDS agora deve receber notificações instantâneas sem precisar atualizar a página.
