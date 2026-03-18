-- Adiciona colunas para identificar o tipo de entrega e a taxa cobrada no momento do pedido.
ALTER TABLE public.orders 
ADD COLUMN IF NOT EXISTS delivery_type TEXT DEFAULT 'retirada',
ADD COLUMN IF NOT EXISTS delivery_fee NUMERIC(10, 2) DEFAULT 0.00;
