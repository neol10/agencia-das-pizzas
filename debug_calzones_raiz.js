const supabaseUrl = 'https://abznheaxvoffclcgqrmm.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFiem5oZWF4dm9mZmNsY2dxcm1tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzI5MzE3ODUsImV4cCI6MjA4ODUwNzc4NX0.9Zwi4QTORguSHV4feMoZbr953irktkCnDrY0AHQEaa0';

async function check() {
    const headers = {
        'apikey': supabaseKey,
        'Authorization': `Bearer ${supabaseKey}`,
        'Content-Type': 'application/json'
    };

    console.log("--- DIAGNÓSTICO DE CALZONES ---");

    // 1. Listar Categorias
    const catRes = await fetch(`${supabaseUrl}/rest/v1/categories?select=*`, { headers });
    const categories = await catRes.json();
    console.log(`\nCategorias found: ${categories.length}`);
    categories.forEach(c => console.log(`ID: ${c.id} | Name: "${c.name}"`));

    // 2. Buscar produtos da categoria Calzones
    const calzoneCat = categories.find(c => c.name.toLowerCase().includes('calzone'));
    if (calzoneCat) {
        console.log(`\nBuscando produtos para a categoria ID: ${calzoneCat.id}`);
        const prodRes = await fetch(`${supabaseUrl}/rest/v1/products?select=id,name,image_url,category_id&category_id=eq.${calzoneCat.id}`, { headers });
        const products = await prodRes.json();
        console.log(`Produtos na categoria Calzones: ${products.length}`);
        products.forEach(p => console.log(`ID: ${p.id} | Name: "${p.name}" | Image: "${p.image_url}"`));
    } else {
        console.log("\nERRO: Categoria 'Calzones' não encontrada!");
    }

    // 3. Busca geral por '120'
    const searchRes = await fetch(`${supabaseUrl}/rest/v1/products?select=id,name,category_id&name=ilike.*120*`, { headers });
    const searchItems = await searchRes.json();
    console.log(`\nBusca por '120':`, searchItems);
}

check().catch(console.error);
