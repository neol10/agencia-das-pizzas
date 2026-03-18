const CACHE_NAME = 'neo-cache-v7';
const ASSETS_TO_CACHE = [
    './index.html',
    './admin.html',
    './comanda.html',
    './styles.css',
    './comanda.css',
    './script.js',
    './admin.js',
    './comanda.js',
    './manifest.json',
    './logo%20pizza.jpg'
];

self.addEventListener('install', (event) => {
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then((cache) => {
                return cache.addAll(ASSETS_TO_CACHE);
            })
    );
    self.skipWaiting();
});

self.addEventListener('activate', (event) => {
    event.waitUntil(
        caches.keys().then((cacheNames) => {
            return Promise.all(
                cacheNames.map((cache) => {
                    if (cache !== CACHE_NAME) {
                        return caches.delete(cache);
                    }
                })
            );
        })
    );
    self.clients.claim();
});

self.addEventListener('fetch', (event) => {
    // Ignora requisições pro Supabase para não ter conflito de cache com dados dinâmicos
    if (event.request.url.includes('supabase.co')) {
        return;
    }

    event.respondWith(
        caches.match(event.request)
            .then((response) => {
                return response || fetch(event.request).catch(() => {
                    // Fallback se estiver offline e não tiver no cache
                    return caches.match('./index.html');
                });
            })
    );
});
