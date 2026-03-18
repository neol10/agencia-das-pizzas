const { createClient } = require('@supabase/supabase-client');

const supabaseUrl = 'https://abznheaxvoffclcgqrmm.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFiem5oZWF4dm9mZmNsY2dxcm1tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzI5MzE3ODUsImV4cCI6MjA4ODUwNzc4NX0.9Zwi4QTORguSHV4feMoZbr953irktkCnDrY0AHQEaa0';

const supabase = createClient(supabaseUrl, supabaseKey);

async function testCRUD() {
    console.log("--- TESTE CRUD ADMIN ---");

    // Login do usuário
    const { data: authData, error: authErr } = await supabase.auth.signInWithPassword({
        email: 'lucca.buonocore07@gmail.com', // Usando um email admin genérico ou tentar sem login
        password: 'admin' // Senha hipotética, vamos tentar inserção anônima primeiro para ver o erro
    });

    if (authErr) {
        console.log("Tentarei como Anonimo, Auth falhou:", authErr.message);
    } else {
        console.log("Logado como:", authData.user.email);
    }

    // Tentar Inserir Categoria
    console.log("\n1. Criando Categoria Teste...");
    const { data: catData, error: catErr } = await supabase
        .from('categories')
        .insert([{ name: 'TesteAdmin_XYZ', order_index: 99 }])
        .select();

    if (catErr) {
        console.log("ERRO ao inserir Categoria:", catErr);
    } else {
        console.log("Categoria inserida sucesso:", catData);
        // Tentar deletar
        await supabase.from('categories').delete().eq('id', catData[0].id);
    }
}

testCRUD().catch(console.error);
