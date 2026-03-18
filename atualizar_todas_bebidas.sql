-- SQL ABBRANGENTE PARA SUCOS E BEBIDAS (MAPEAMENTO COMPLETO)
-- SUCOS
UPDATE products SET image_url = 'img/suco_uva.png' WHERE name ILIKE '%De Uva%';
UPDATE products SET image_url = 'img/suco_maracuja.png' WHERE name ILIKE '%Maracujá%';
UPDATE products SET image_url = 'img/suco_abacaxi.png' WHERE name ILIKE '%Abacaxi%';
UPDATE products SET image_url = 'img/suco_goiaba.png' WHERE name ILIKE '%Goiaba%';
UPDATE products SET image_url = 'img/suco_laranja.png' WHERE name ILIKE '%Laranja%';
UPDATE products SET image_url = 'img/suco_caixa.png' WHERE name ILIKE '%Del Valle%' OR name ILIKE '%Maratá%' OR name ILIKE '%Suco 500ml%';

-- BEBIDAS
UPDATE products SET image_url = 'img/refri_pet.png' WHERE name ILIKE '%Pet%' OR name ILIKE '%Retornável%' OR name ILIKE '%1,5%' OR name ILIKE '%2,5%' OR name ILIKE '%2L%' OR name ILIKE '%600ml%' OR name ILIKE '%Sprite%' OR name ILIKE '%H2O%' OR name ILIKE '%Tônica%';
UPDATE products SET image_url = 'img/referi_lata.png' WHERE name ILIKE '%Lata%' AND name ILIKE '%Refrigerante%';
UPDATE products SET image_url = 'img/energetico.png' WHERE name ILIKE '%Energético%';

-- (Chá Gelado e Cerveja ficarão sem imagem por enquanto até o limite de IA zerar ou o adm subir foto manualmente)
