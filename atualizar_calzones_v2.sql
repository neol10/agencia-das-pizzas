-- Atualização de Imagens para Calzones (Nomes revisados)
UPDATE products SET image_url = 'img/calzone_frango.png' WHERE name ILIKE '%Frango com Champignon%' AND category_id IN (SELECT id FROM categories WHERE name ILIKE '%Calzones%');
UPDATE products SET image_url = 'img/calzone_moda.png' WHERE name ILIKE '%À Moda da Casa%' AND category_id IN (SELECT id FROM categories WHERE name ILIKE '%Calzones%');
UPDATE products SET image_url = 'img/calzone_napolitano.png' WHERE name ILIKE '%Napolitano%' AND category_id IN (SELECT id FROM categories WHERE name ILIKE '%Calzones%');
UPDATE products SET image_url = 'img/calzone_queijos.png' WHERE name ILIKE '%Quatro Queijos%' AND category_id IN (SELECT id FROM categories WHERE name ILIKE '%Calzones%');
UPDATE products SET image_url = 'img/calzone_queijos.png' WHERE name ILIKE '%Cinco Queijos%' AND category_id IN (SELECT id FROM categories WHERE name ILIKE '%Calzones%');
