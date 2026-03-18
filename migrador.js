const fs = require('fs');

const supabaseUrl = 'https://abznheaxvoffclcgqrmm.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFiem5oZWF4dm9mZmNsY2dxcm1tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzI5MzE3ODUsImV4cCI6MjA4ODUwNzc4NX0.9Zwi4QTORguSHV4feMoZbr953irktkCnDrY0AHQEaa0';

async function supabaseRequest(path, method = 'GET', body = null) {
    const options = {
        method,
        headers: {
            'apikey': supabaseKey,
            'Authorization': `Bearer ${supabaseKey}`,
            'Content-Type': 'application/json',
            'Prefer': 'return=representation'
        }
    };
    if (body) options.body = JSON.stringify(body);

    const response = await fetch(`${supabaseUrl}/rest/v1/${path}`, options);
    if (!response.ok) {
        const text = await response.text();
        throw new Error(`Supabase Error (${path}): ${response.status} ${text}`);
    }
    return response.json();
}

async function migrate() {
    console.log("🚀 Iniciando migração suprema...");

    // 1. Carregar JSON
    const data = JSON.parse(fs.readFileSync('menu_completo.json', 'utf8'));
    const menuItems = data.data.menu.menu;
    const menuAux = data.data.menu.menu_aux;

    // 2. Limpar dados antigos (como solicitado)
    console.log("🧹 Limpando dados antigos...");
    try {
        await supabaseRequest('products', 'DELETE');
        await supabaseRequest('categories', 'DELETE');
    } catch (e) {
        console.log("Nota: Erro ao deletar (pode estar vazio ou RLS bloqueando DELETE sem filter). Tentando prosseguir.");
    }

    // 3. Mapear Categorias e Produtos
    const finalCategories = [];
    const finalProducts = [];

    // Mapear categorias normais do menu principal
    for (const cat of menuItems) {
        if (cat.title === "Pizzas") {
            // Categoria de Pizzas será preenchida com os sabores do menu_aux
            finalCategories.push({ name: "Pizzas", order_index: cat.order });
            continue;
        }

        finalCategories.push({ name: cat.title, order_index: cat.order });

        // Adicionar produtos desta categoria
        if (cat.itens) {
            cat.itens.forEach(item => {
                finalProducts.push({
                    category_name: cat.title, // Temporário para mapear depois do insert da categoria
                    name: item.title,
                    description: item.description || "",
                    price: item.price || item.minimal_price || 0,
                    image_url: item.image || "",
                    is_active: !item.out
                });
            });
        }
    }

    // Mapear Sabores de Pizza do menu_aux (usando Sabor Grande como referência de preço/lista)
    const saborGrande = menuAux.find(m => m.title === "Sabor Grande" || m.title.includes("Sabor"));
    if (saborGrande && saborGrande.itens) {
        saborGrande.itens.forEach(sabor => {
            finalProducts.push({
                category_name: "Pizzas",
                name: sabor.title,
                description: sabor.description || "",
                price: sabor.price || sabor.price_base || 46, // 46 é o padrão da Grande
                image_url: sabor.image || "",
                is_active: !sabor.out
            });
        });
    }

    console.log(`📦 Preparados: ${finalCategories.length} categorias e ${finalProducts.length} produtos.`);

    // 4. Inserir Categorias e recuperar IDs
    console.log("📤 Inserindo categorias...");
    const insertedCats = await supabaseRequest('categories', 'POST', finalCategories.map(c => ({
        name: c.name,
        order_index: c.order_index
    })));

    // Criar mapa de nome -> id
    const catMap = {};
    insertedCats.forEach(c => catMap[c.name] = c.id);

    // 5. Inserir Produtos com category_id correto
    console.log("📤 Inserindo produtos...");
    const productsToInsert = finalProducts.map(p => ({
        category_id: catMap[p.category_name],
        name: p.name,
        description: p.description,
        price: p.price,
        image_url: p.image_url,
        is_active: p.is_active
    }));

    // Inserir em lotes se necessário, mas 50 itens é suave
    await supabaseRequest('products', 'POST', productsToInsert);

    console.log("✅ MIGRACÃO CONCLUÍDA COM SUCESSO!");
    console.log(`Total: ${insertedCats.length} categorias e ${productsToInsert.length} produtos sincronizados.`);
}

migrate().catch(e => console.error("❌ Erro na migração:", e.message));
