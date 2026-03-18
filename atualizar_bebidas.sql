-- Atualização de Imagens para Sucos e Bebidas (Exemplos)
UPDATE products SET image_url = 'img/suco_caixa.png' WHERE name ILIKE '%Suco Del Valle%' OR name ILIKE '%Suco Maratá%';
UPDATE products SET image_url = 'img/suco_laranja.png' WHERE name ILIKE '%Suco de laranja%';
UPDATE products SET image_url = 'img/referi_lata.png' WHERE name ILIKE '%Coca-Cola%' OR name ILIKE '%Guaraná%';
