-- SQL DEFINITIVO - IMAGENS (IGNORA CATEGORIA PARA EVITAR ERROS)
-- CALZONES
UPDATE products SET image_url = 'img/calzone_frango.png' WHERE name ILIKE '%120. Frango com Champignon%';
UPDATE products SET image_url = 'img/calzone_moda.png' WHERE name ILIKE '%121. À Moda da Casa%';
UPDATE products SET image_url = 'img/calzone_napolitano.png' WHERE name ILIKE '%122. Napolitano%';
UPDATE products SET image_url = 'img/calzone_queijos.png' WHERE name ILIKE '%123. Quatro Queijos%';
UPDATE products SET image_url = 'img/calzone_queijos.png' WHERE name ILIKE '%124. Cinco Queijos%';

-- BEBIDAS E SUCOS
UPDATE products SET image_url = 'img/suco_caixa.png' WHERE name ILIKE '%Suco Del Valle%' OR name ILIKE '%Suco Maratá%';
UPDATE products SET image_url = 'img/suco_laranja.png' WHERE name ILIKE '%Suco de laranja%';
UPDATE products SET image_url = 'img/referi_lata.png' WHERE name ILIKE '%Coca-Cola%' OR name ILIKE '%Guaraná%';
