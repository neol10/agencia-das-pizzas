const supabaseUrl = 'https://abznheaxvoffclcgqrmm.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFiem5oZWF4dm9mZmNsY2dxcm1tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzI5MzE3ODUsImV4cCI6MjA4ODUwNzc4NX0.9Zwi4QTORguSHV4feMoZbr953irktkCnDrY0AHQEaa0';

async function check() {
    const headers = {
        'apikey': supabaseKey,
        'Authorization': `Bearer ${supabaseKey}`
    };

    const catRes = await fetch(`${supabaseUrl}/rest/v1/categories?select=*`, { headers });
    const categories = await catRes.json();
    console.log(`Categorias encontradas: ${categories.length}`);
    if (categories.length > 0) {
        console.log("Exemplo de categoria:", JSON.stringify(categories[0], null, 2));
    }

    const prodRes = await fetch(`${supabaseUrl}/rest/v1/products?select=*&limit=5`, { headers });
    const products = await prodRes.json();
    console.log(`Produtos encontrados (limit 5): ${products.length}`);
    if (products.length > 0) {
        console.log("Exemplo de produto:", JSON.stringify(products[0], null, 2));
    }
}

check().catch(console.error);
