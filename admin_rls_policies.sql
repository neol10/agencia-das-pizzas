-- =========================================================================
-- REI NEO - PERMISSÕES SUPREMAS DO PAINEL ADMIN (SUPABASE RLS)
-- =========================================================================
-- Este script garante que o seu painel Admin consiga adicionar, editar,
-- excluir fotos, produtos e categorias sem ser bloqueado pela segurança.

-- 1. Habilitar RLS (Segurança) em todas as tabelas principais
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.coupons ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;

-- 2. Limpar políticas antigas que possam estar atrapalhando
DROP POLICY IF EXISTS "Public Read Categories" ON public.categories;
DROP POLICY IF EXISTS "Admin Full Categories" ON public.categories;
DROP POLICY IF EXISTS "Public Read Products" ON public.products;
DROP POLICY IF EXISTS "Admin Full Products" ON public.products;
DROP POLICY IF EXISTS "Admin Full Coupons" ON public.coupons;
DROP POLICY IF EXISTS "Admin Full Orders" ON public.orders;
DROP POLICY IF EXISTS "Public Read Coupons" ON public.coupons;

-- 3. PERMISSÕES PARA O SITE (Leitura)
-- Todo mundo que acessa o site pode ler (ver) categorias e produtos
CREATE POLICY "Public Read Categories" ON public.categories FOR SELECT USING (true);
CREATE POLICY "Public Read Products" ON public.products FOR SELECT USING (true);
-- Clientes também podem ler cupons para validá-los
CREATE POLICY "Public Read Coupons" ON public.coupons FOR SELECT USING (true);

-- 4. PERMISSÕES PARA O ADMIN (Controle Total)
-- Somente você logado no painel pode Inserir, Atualizar e Deletar
CREATE POLICY "Admin Full Categories" ON public.categories FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Admin Full Products" ON public.products FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Admin Full Coupons" ON public.coupons FOR ALL USING (auth.role() = 'authenticated');
-- Admin pode atualizar pedidos (ex: marcar como entregue)
CREATE POLICY "Admin Full Orders" ON public.orders FOR ALL USING (auth.role() = 'authenticated');

-- 5. BUCKET DE IMAGENS (Produtos)
-- Garante que o painel pode subir fotos para a pasta de produtos no Supabase Storage
-- (Atenção: Você precisa ter um bucket chamado "product-images" criado no Supabase Storage e ele deve ser Público)
-- Se não existir, crie-o manualmente no painel do Supabase antes de fazer uploads de imagens novas.
