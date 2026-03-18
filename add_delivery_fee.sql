-- Adiciona a coluna delivery_fee na tabela settings
-- (Taxa de entrega em R$, padrão R$ 5,00)
ALTER TABLE public.settings 
ADD COLUMN IF NOT EXISTS delivery_fee NUMERIC(10, 2) DEFAULT 5.00;

-- Garante que o registro padrão existe com o valor inicial
UPDATE public.settings SET delivery_fee = 5.00 WHERE id = 1;
