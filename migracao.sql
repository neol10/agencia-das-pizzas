-- MIGRACÃO SUPREMA - AGÊNCIA DAS PIZZAS
BEGIN;

-- 1. LIMPEZA TOTAL
DELETE FROM products;
DELETE FROM categories;

-- 2. CATEGORIAS
INSERT INTO categories (name, order_index) VALUES ('Pizzas', 0);
INSERT INTO categories (name, order_index) VALUES ('Calzones', 1);
INSERT INTO categories (name, order_index) VALUES ('Sucos', 2);
INSERT INTO categories (name, order_index) VALUES ('Bebidas', 3);
INSERT INTO categories (name, order_index) VALUES ('Ficha', 4);
INSERT INTO categories (name, order_index) VALUES ('Embalagens', 5);
INSERT INTO categories (name, order_index) VALUES ('MASSA SEM GLUTEM (PEQUENA)', 17);
INSERT INTO categories (name, order_index) VALUES ('MASSA SEM GLUTEM', 18);

-- 3. PRODUTOS (MAPEADOS PELO NOME DA CATEGORIA)
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '120. Frango com Champignon', 'Molho, muçarela, frango desfiado, champignon e catupiry', 46, '', true 
    FROM categories WHERE name = 'Calzones' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '121. À Moda da Casa', 'Molho, muçarela, chester defumado, palmito e manjericão fresco', 46, '', true 
    FROM categories WHERE name = 'Calzones' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '122. Napolitano', 'Molho, muçarela, tomate picado, champignon e manjericão fresco', 44, '', true 
    FROM categories WHERE name = 'Calzones' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '123. Quatro Queijos', 'Molho, muçarela, provolone, gorgonzola e catupiry', 46, '', true 
    FROM categories WHERE name = 'Calzones' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '124. Cinco Queijos', 'Molho, muçarela, provolone, gorgonzola, parmesão e catupiry', 48, '', true 
    FROM categories WHERE name = 'Calzones' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Suco Del Valle 1L', '', 14, '', true 
    FROM categories WHERE name = 'Sucos' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Suco Maratá 1L', '', 10, '', true 
    FROM categories WHERE name = 'Sucos' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Suco de laranja Copo', '', 8, '', true 
    FROM categories WHERE name = 'Sucos' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Suco de Uva Integral 1L', '', 20, '', true 
    FROM categories WHERE name = 'Sucos' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Suco de Uva Integral 1,5L', '', 28, '', false 
    FROM categories WHERE name = 'Sucos' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Suco de Maracujá Natural 1L', '', 22, '', true 
    FROM categories WHERE name = 'Sucos' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Suco de Laranja Natural 1L', '', 20, '', true 
    FROM categories WHERE name = 'Sucos' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Suco de Laranja com Morango 1L', '', 30, '', true 
    FROM categories WHERE name = 'Sucos' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Suco de Abacaxi Natural 1L', '', 20, '', true 
    FROM categories WHERE name = 'Sucos' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Suco 500ml', 'Suco Jarra 500ml', 10, '', true 
    FROM categories WHERE name = 'Sucos' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Suco de Goiaba Natural 1L', '', 20, '', true 
    FROM categories WHERE name = 'Sucos' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'SUCO  MARACUJÁ 500ML', '', 11, '', true 
    FROM categories WHERE name = 'Sucos' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'SUCO 500 ML LARANJA', '', 10, '', true 
    FROM categories WHERE name = 'Sucos' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '1L abacaxi com hortelan', '', 20, '', true 
    FROM categories WHERE name = 'Sucos' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'ABACAXI COM HORTELAN 500ML', '', 10, '', true 
    FROM categories WHERE name = 'Sucos' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Refrigerante 1L Retornável', '', 10, '', true 
    FROM categories WHERE name = 'Bebidas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Refrigerante 1L Pet', '', 10, '', true 
    FROM categories WHERE name = 'Bebidas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Refrigerante 1,5L', '', 12, '', true 
    FROM categories WHERE name = 'Bebidas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Água Garrafinha 510ml', '', 4, '', true 
    FROM categories WHERE name = 'Bebidas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Refrigerante Lata', '', 6, '', true 
    FROM categories WHERE name = 'Bebidas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Refrigerante 2,5L', '', 17, '', true 
    FROM categories WHERE name = 'Bebidas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Refrigerante 2L', '', 15, '', true 
    FROM categories WHERE name = 'Bebidas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Refrigerante 600ml', '', 9, '', true 
    FROM categories WHERE name = 'Bebidas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'H2O', '', 9, '', true 
    FROM categories WHERE name = 'Bebidas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Cerveja Sem Álcool Heineken', '', 10, '', true 
    FROM categories WHERE name = 'Bebidas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Sprite Lemon', '', 9, '', true 
    FROM categories WHERE name = 'Bebidas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Chá Gelado', '', 8, '', true 
    FROM categories WHERE name = 'Bebidas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Tônica', '', 6, '', true 
    FROM categories WHERE name = 'Bebidas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Energético Lata', '', 11, '', true 
    FROM categories WHERE name = 'Bebidas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'Ficha', '', 2, '', true 
    FROM categories WHERE name = 'Ficha' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'CAIXA PEQUENA', '', 2, '', true 
    FROM categories WHERE name = 'Embalagens' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'EMBALAGEM DE SUCO', 'GARRAFA PARA ENTREGA DE SUCO.', 1.5, '', true 
    FROM categories WHERE name = 'Embalagens' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'CAIXA GRANDE', '', 3, '', true 
    FROM categories WHERE name = 'Embalagens' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'MARMITEX', '', 1, '', true 
    FROM categories WHERE name = 'Embalagens' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, 'MASSA SEM GLUTEM ', 'Pizza com até 2 sabores e 4 fatias', 10, 'https://anotaai.s3.us-west-2.amazonaws.com/pizzas/2pizza', true 
    FROM categories WHERE name = 'MASSA SEM GLUTEM' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '01. Alho E Óleo', 'Molho, Muçarela, Azeitonas, Alho E Óleo', 36, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731275530379blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '02. Alho-Poró', 'Molho, muçarela, tomate, cebola, alho-poró, manjericão fresco e azeitonas', 36, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731275597163blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '03. Bavária', 'Molho, Muçarela, Champignon, Cebola, Pimentão E Azeitonas Picadas', 36, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731275648006blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '04. Brócolis', 'Molho, Muçarela, Brócolis, Catupiry, Alho Pré Frito E Azeitonas', 36, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731275682843blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '05. Alho-Porólone', 'Molho, Muçarela, alho-poró, provolone e azeitonas', 38, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731275724802blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '07. Champignon Com Manjericão', 'Molho, Muçarela, Champignon Fatiado, Tomate, Manjericão Fresco E Azeitonas', 36, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731275753466blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '08. Jardineira', 'Molho, Muçarela, Milho, Ervilha, Palmito, Pimentão, Tomate Picado E Azeitonas', 36, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731275782299blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '09. Mafiosa', 'Molho, Muçarela, Gorgonzola, Catupiry, Cebola E Azeitonas', 36, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731275808198blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '10. Margherita', 'Molho, Muçarela, Tomate Picado, Manjericão Fresco E Azeitonas

OBS- O VALOR DA PROMOÇÃO SÓ PERMANCE SE FOR ESCOLHIDO A PIZZA INTEIRA, OU OUTRA METADE DA PROMOÇÃO TAMBÉM.', 36, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731275832610blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '11. Milho Com Provolone', 'Molho, Muçarela, Milho Verde, Provolone Ou Catupiry E Azeitonas', 36, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731275857781blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '12. Milho', 'Molho, Muçarela, Milho Verde E Azeitonas', 34, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731275923141blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '13. Muçarela', 'Molho, Muçarela, Tomate Fatiado, Parmesão E Azeitonas', 34, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731275990571blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '14. Napolitana', 'Molho, Muçarela, Tomate Fatiado, Parmesão, Manjericão Fresco E Azeitonas', 34, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276028980blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '15. Palmito I', 'Molho, muçarela, palmito picado e azeitonas', 36, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276090222blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '16. Palmito II', 'Molho, muçarela, palmito picado, cebola, catupiry e azeitonas', 38, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276139821blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '18. Rúcula com Tomat Seco', 'Molho, muçarela, rúcula, tomate seco e azeitonas', 40, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276175840blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '19. Soberana II', 'Molho, muçarela, bife vegetal, molho branco, champignon fatiado, palmito picado e azeitonas', 46, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276216962blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '20. Vegetariana I', 'Molho, muçarela, brócolis, tomate picado, milho verde, ervilha, cebola e azeitonas', 36, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276301829blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '21. Vegetariana II', 'Molho, muçarela, palmito picado, ervilha, tomate picado, pimentão, manjericão fresco e azeitonas', 38, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276353693blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '23. Speciale', 'Molho, muçarela, palmito picado, champignon fatiado, catupiry, tomate cereja, manjericão fresco e azeitonas', 38, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276388613blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '40. Aliche', 'Molho, muçarela, tomate fatiado, aliche, manjericão fresco e azeitonas', 40, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276430484blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '41. Aliche Quatro Queijos', 'Molho, muçarela, aliche, provolone, gorgonzola, catupiry e azeitonas', 44, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276563003blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '42. Atum Plus', 'Molho, muçarela, tomate picado, atum ralado, pimentão, cebola, ovo e azeitonas', 38, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276597003blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '43. Atum com Cebola', 'Molho, muçarela, atum ralado, cebola e azeitonas', 36, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276621159blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '44. Carne Seca', 'Molho, muçarela, carne seca, cebola e azeitonas', 42, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276644761blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '45. Frango a Americana', 'Molho, muçarela, frango desfiado, abacaxi e molho alfredo e azeitonas', 38, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276680024blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '46. Frango a Brasileira', 'Molho, muçarela, frango desfiado, brócolis, milho e azeitonas', 38, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276734524blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '47. Carne Seca Arretada', 'Molho, muçarela, carne seca, ovo, molho de pimenta, batata palha e azeitonas', 46, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276706991blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '48. Frangolino', 'Molho, muçarela, frango desfiado, catupiry e azeitonas', 38, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276759082blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '49. Frango Caipira', 'Molho, muçarela, frango desfiado, catupiry ou cheddar, batata palha e azeitonas', 42, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276787766blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '50. Frangolino Cheddar', 'Molho, muçarela, frango desfiado, cheddar e azeitonas', 40, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276816558blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '51. Frangomito', 'Molho, muçarela, frango desfiado, palmito picado, milho verde e azeitonas', 40, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276860481blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '52. Lagoa Bonita', 'Molho, muçarela, frango desfiado, brócolis, cebola, champignon e azeitona.', 40, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276887304blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '53. Mexicana', 'Molho, muçarela, alcatra, ovo, molho de pimenta, batata palha.', 46, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276933231blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '54. À Moda do Chef', 'Molho, muçarela, alcatra, champignon fatiado, alcaparras, cebola e azeitonas', 46, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276958187blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '55. À Moda do Papito', 'Molho, muçarela, frango desfiado, calabresa bovina moída, catupiry e azeitonas', 40, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731276980181blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '56. Soberana I', 'Molho, muçarela, alcatra, molho branco, champignon fatiado, palmito picado e azeitonas', 44, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277003374blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '57. Strogonoff de Carne', 'Molho, muçarela, strogonoff de carne, batata palha e azeitonas', 42, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277023482blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '58. Strogonoff de Frango', 'Molho, muçarela, strogonoff de frango, batata palha e azeitonas', 40, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277047582blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '59. Suprema', 'Molho, muçarela, alcatra, pimentão, champignon fatiado e azeitonas', 42, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277072919blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '62. Calabresa Bovina com Cebola', 'Molho, muçarela, calabresa bovina fatiada, cebola e azeitonas', 38, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277099951blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '63. Catarina', 'Molho, muçarela, peito de peru defumado, palmito, milho verde, ervilha e azeitonas', 38, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277127860blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '64. Chester', 'Molho, muçarela, peito de peru defumado, catupiry e azeitonas', 34, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277156049blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '65. Espanhola', 'Molho, muçarela, calabresa bovina moída, palmito, ovo e azeitonas', 46, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277185789blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '66. À Moda da Casa', 'Molho, muçarela, peito de peru defumado, palmito, tomate picado, champignon picado, catupiry e azeitonas', 40, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277215718blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '67. À Moda da Mamma', 'Molho, muçarela, peito de peru defumado, muçarela de búfala, parmesão e azeitonas', 40, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277253567blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '68. Portuguesa', 'Molho, muçarela, peito de peru defumado, ovo, cebola, pimentão picado e azeitonas', 40, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277278617blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '69. Jacarandá', 'Molho, muçarela, peito de peru defumado, brócolis, cebola, tomate, catupiry e azeitonas', 40, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277305641blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '70. Paloma', 'Molho, muçarela, peito de peru defumado, champignon, palmito, catupiry, manjericão e azeitonas', 40, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277333504blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '71. Universitária', 'Molho, muçarela, peito de peru defumado, ovo e azeitonas', 38, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277362246blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '72. Quatro Queijos', 'Molho, muçarela, provolone, gorgonzola, catupiry e azeitonas', 40, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277395383blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '73. Três Queijos', 'Molho, muçarela, provolone, catupiry e azeitonas', 40, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277421242blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '74. Cinco Queijos', 'Molho, muçarela, provolone, gorgonzola, catupiry, parmesão e azeitonas', 42, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277451413blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '80. Abobrinha Marinada', 'Molho, muçarela, abobrinha marinada e azeitonas', 48, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277486749blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '81. D''Itália', 'Molho, muçarela, abobrinha marinada, berinjela fatiada, pimentão, cebola e azeitonas', 48, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277518458blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '82. Brazuca', 'Molho, muçarela de búfala, berinjela fatiada, tomate seco, parmesão, rúcula, azeite e azeitonas', 50, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277548301blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '83. Margherita Especial', 'Molho, muçarela de búfala, parmesão, tomate cereja, manjericão e azeitonas', 48, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277583268blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '84. Doritos Especial', 'Molho, muçarela, alcatra, Doritos®, cheddar e azeitonas', 50, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277621763blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '85. La Pizza Mia', 'Molho, muçarela, azeitonas + 3 ingredientes a sua escolha (Exceto ingredientes das pizzas premium)', 48, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277654291blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '149. Banana com Doce de Leite', 'Muçarela, banana picada e doce de leite', 36, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277723008blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '150. Banana', 'Muçarela, banana picada, canela em pó e açúcar', 34, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277781446blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '151. Banana Nevada', 'Muçarela, banana picada, canela em pó, açúcar e chocolate branco', 38, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277804021blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '152. Banana Trovoada', 'Muçarela, banana picada, canela em pó, açúcar e chocolate preto', 38, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277875449blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '153. Chocolate Branco', 'Muçarela, creme de leite e chocolate branco', 38, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731278027871blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '154. Chocolate Preto', 'Muçarela, creme de leite e chocolate preto', 36, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731278083879blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '156. Chocolate com M&M', 'Muçarela, chocolate preto e M&M', 40, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731278049944blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '157. Morango Moreno', 'Muçarela, chocolate preto, creme de leite e morango', 38, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731278003513blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '158. Morango Loiro', 'Muçarela, chocolate branco, creme de leite e morango', 38, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277978831blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '159. Prestígio', 'Muçarela, chocolate preto, creme de leite, coco ralado e leite condensado', 38, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277956286blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '160. Chocolate com Ovomaltine', 'Muçarela, chocolate preto, creme de leite e Ovomaltine', 40, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277928167blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '161. Romeu e Julieta', 'Muçarela e goiabada', 36, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277897475blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;
INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '162. Sorvete', 'Muçarela, chocolate preto, sorvete creme de leite e morango', 42, 'https://client-assets.anota.ai/produtos/672951a7b5c3e500121c9d63/-1731277841399blob', true 
    FROM categories WHERE name = 'Pizzas' LIMIT 1;

COMMIT;