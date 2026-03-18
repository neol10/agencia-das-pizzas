const apiKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFiem5oZWF4dm9mZmNsY2dxcm1tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzI5MzE3ODUsImV4cCI6MjA4ODUwNzc4NX0.9Zwi4QTORguSHV4feMoZbr953irktkCnDrY0AHQEaa0';

async function createUser() {
    try {
        const req = await fetch('https://abznheaxvoffclcgqrmm.supabase.co/auth/v1/signup', {
            method: 'POST',
            headers: {
                'apikey': apiKey,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                email: 'adminagenciadaspizzas@gmail.com',
                password: 'Admin166480'
            })
        });
        const res = await req.json();
        console.log("Signup:", res);

        // Confirmar acesso:
        const req2 = await fetch('https://abznheaxvoffclcgqrmm.supabase.co/auth/v1/token?grant_type=password', {
            method: 'POST',
            headers: {
                'apikey': apiKey,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                email: 'adminagenciadaspizzas@gmail.com',
                password: 'Admin166480'
            })
        });
        const res2 = await req2.json();
        console.log("Login Test:", res2.access_token ? "SUCCESS" : res2);

    } catch (e) {
        console.error(e)
    }
}
createUser();
