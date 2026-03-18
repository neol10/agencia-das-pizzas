-- Criação da Tabela de Configurações
CREATE TABLE IF NOT EXISTS public.settings (
    id INT PRIMARY KEY DEFAULT 1,
    is_open BOOLEAN DEFAULT true,
    schedule JSONB DEFAULT '{"monday": {"isOpen": true, "name": "Segunda-feira", "start": "19:00", "end": "23:00"}, "tuesday": {"isOpen": true, "name": "Terça-feira", "start": "19:00", "end": "23:00"}, "wednesday": {"isOpen": true, "name": "Quarta-feira", "start": "19:00", "end": "23:00"}, "thursday": {"isOpen": true, "name": "Quinta-feira", "start": "19:00", "end": "23:00"}, "friday": {"isOpen": false, "name": "Sexta-feira", "start": "19:00", "end": "23:00"}, "saturday": {"isOpen": true, "name": "Sábado", "start": "19:00", "end": "23:00"}, "sunday": {"isOpen": true, "name": "Domingo", "start": "19:00", "end": "23:00"}}'::jsonb
);

-- Inserindo a linha única (Configuração Global)
INSERT INTO public.settings (id) VALUES (1) ON CONFLICT (id) DO NOTHING;

-- Blindagem de Segurança (RLS)
ALTER TABLE public.settings ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Public Read Settings" ON public.settings;
DROP POLICY IF EXISTS "Admin Full Access Settings" ON public.settings;

CREATE POLICY "Public Read Settings" ON public.settings FOR SELECT USING (true);
CREATE POLICY "Admin Full Access Settings" ON public.settings FOR ALL USING (auth.role() = 'authenticated');
