const fs = require('fs');

const data = JSON.parse(fs.readFileSync('menu_completo.json', 'utf8'));
const menuItems = data.data.menu.menu;
const menuAux = data.data.menu.menu_aux;

let sql = `-- MIGRACÃO SUPREMA - AGÊNCIA DAS PIZZAS\n`;
sql += `BEGIN;\n\n`;
sql += `-- 1. LIMPEZA TOTAL\n`;
sql += `DELETE FROM products;\n`;
sql += `DELETE FROM categories;\n\n`;

const finalCategories = [];
const finalProducts = [];

// Mapear categorias normais
for (const cat of menuItems) {
    const catId = `cat_${cat.order}`;
    finalCategories.push({ id: catId, name: cat.title, order_index: cat.order });

    if (cat.title !== "Pizzas" && cat.itens) {
        cat.itens.forEach(item => {
            finalProducts.push({
                catId: catId,
                name: item.title,
                description: item.description || "",
                price: item.price || item.minimal_price || 0,
                image: item.image || "",
                active: !item.out
            });
        });
    }
}

// Mapear Pizzas (Sabores)
const saborGrande = menuAux.find(m => m.title === "Sabor Grande" || m.title.includes("Sabor"));
const pizzaCat = finalCategories.find(c => c.name === "Pizzas");
if (saborGrande && saborGrande.itens && pizzaCat) {
    saborGrande.itens.forEach(sabor => {
        finalProducts.push({
            catId: pizzaCat.id,
            name: sabor.title,
            description: sabor.description || "",
            price: sabor.price || sabor.price_base || 46,
            image: sabor.image || "",
            active: !sabor.out
        });
    });
}

// Gerar INSERTS de categorias (usando temp IDs para o script SQL)
sql += `-- 2. CATEGORIAS\n`;
finalCategories.forEach((c, idx) => {
    sql += `INSERT INTO categories (name, order_index) VALUES ('${c.name.replace(/'/g, "''")}', ${c.order_index});\n`;
});

sql += `\n-- 3. PRODUTOS (MAPEADOS PELO NOME DA CATEGORIA)\n`;
finalProducts.forEach(p => {
    const catName = finalCategories.find(c => c.id === p.catId).name;
    sql += `INSERT INTO products (category_id, name, description, price, image_url, is_active) 
    SELECT id, '${p.name.replace(/'/g, "''")}', '${p.description.replace(/'/g, "''")}', ${p.price}, '${p.image}', ${p.active} 
    FROM categories WHERE name = '${catName.replace(/'/g, "''")}' LIMIT 1;\n`;
});

sql += `\nCOMMIT;`;

fs.writeFileSync('migracao.sql', sql);
console.log("Sucesso! O arquivo 'migracao.sql' foi gerado.");
