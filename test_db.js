const supabaseUrl = 'https://abznheaxvoffclcgqrmm.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFiem5oZWF4dm9mZmNsY2dxcm1tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzI5MzE3ODUsImV4cCI6MjA4ODUwNzc4NX0.9Zwi4QTORguSHV4feMoZbr953irktkCnDrY0AHQEaa0';

async function check() {
    const response = await fetch(`${supabaseUrl}/rest/v1/categories?select=*`, {
        headers: {
            'apikey': supabaseKey,
            'Authorization': `Bearer ${supabaseKey}`
        }
    });
    const data = await response.json();
    console.log("Categorias no banco:");
    console.log(JSON.stringify(data, null, 2));
}

check().catch(console.error);
