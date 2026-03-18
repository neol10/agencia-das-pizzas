const fs = require('fs');

async function migrate() {
    console.log("Iniciando extração...");
    const url = "https://api.anota.ai/clientauth/nm-category/menu-merchant?displaySources=DIGITAL_MENU";
    const token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZHBhZ2UiOiI2NzI5NTFhN2I1YzNlNTAwMTIxYzlkNjMiLCJpYXQiOjE3NzI5ODA0ODJ9.2NsToyNAVU5vEP3h7In14ldv4WfClt6oaM6ICm4QKdg";

    try {
        const response = await fetch(url, {
            headers: {
                "Authorization": token, // O subagente disse que não usa Bearer
                "Origin": "https://pedido.anota.ai",
                "Referer": "https://pedido.anota.ai/"
            }
        });

        if (!response.ok) {
            throw new Error(`Erro na API: ${response.status} ${response.statusText}`);
        }

        const json = await response.json();
        fs.writeFileSync('menu_completo.json', JSON.stringify(json, null, 2));
        console.log("Sucesso! Arquivo 'menu_completo.json' gerado.");

        // Mostrar um resumo
        const categories = json.data.menu.categories;
        console.log(`Categorias encontradas: ${categories.length}`);
        categories.forEach(c => {
            console.log(` - ${c.title}: ${c.items.length} itens`);
        });

    } catch (error) {
        console.error("Erro fatal:", error.message);
    }
}

migrate();
