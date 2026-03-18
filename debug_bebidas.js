const supabaseUrl = 'https://abznheaxvoffclcgqrmm.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFiem5oZWF4dm9mZmNsY2dxcm1tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzI5MzE3ODUsImV4cCI6MjA4ODUwNzc4NX0.9Zwi4QTORguSHV4feMoZbr953irktkCnDrY0AHQEaa0';

async function listDrinks() {
    const headers = {
        'apikey': supabaseKey,
        'Authorization': `Bearer ${supabaseKey}`,
        'Content-Type': 'application/json'
    };

    console.log("--- LISTA DE BEBIDAS E SUCOS ---");

    // Encontrar categorias
    const catRes = await fetch(`${supabaseUrl}/rest/v1/categories?select=id,name`, { headers });
    const categories = await catRes.json();

    const drinkCats = categories.filter(c => c.name.toLowerCase().includes('bebida') || c.name.toLowerCase().includes('suco'));

    for (let cat of drinkCats) {
        console.log(`\nCategoria: ${cat.name}`);
        const prodRes = await fetch(`${supabaseUrl}/rest/v1/products?select=id,name,image_url&category_id=eq.${cat.id}`, { headers });
        const products = await prodRes.json();
        products.forEach(p => console.log(`- ${p.name} (IMG: ${p.image_url || 'Nenhuma'})`));
    }
}

listDrinks().catch(console.error);
