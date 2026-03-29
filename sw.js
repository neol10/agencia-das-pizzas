// --- FCM (Firebase Cloud Messaging) - opcional ---
try {
    importScripts('./firebase-config.js');
    importScripts('https://www.gstatic.com/firebasejs/10.12.5/firebase-app-compat.js');
    importScripts('https://www.gstatic.com/firebasejs/10.12.5/firebase-messaging-compat.js');

    const isMissingOrPlaceholder = (v) => !v || (typeof v === 'string' && v.trim().toUpperCase().startsWith('YOUR_'));
    const cfg = self.FIREBASE_CONFIG;

    const hasValidConfig = cfg
        && !isMissingOrPlaceholder(cfg.apiKey)
        && !isMissingOrPlaceholder(cfg.authDomain)
        && !isMissingOrPlaceholder(cfg.projectId)
        && !isMissingOrPlaceholder(cfg.messagingSenderId)
        && !isMissingOrPlaceholder(cfg.appId);

    if (self.firebase && hasValidConfig && (!self.firebase.apps || self.firebase.apps.length === 0)) {
        self.firebase.initializeApp(cfg);
    }

    if (self.firebase && hasValidConfig && self.firebase.messaging) {
        const messaging = self.firebase.messaging();

        messaging.onBackgroundMessage((payload) => {
            const title = payload?.notification?.title || 'Agência das Pizzas';
            const body = payload?.notification?.body || payload?.data?.body || 'Você tem uma nova notificação.';
            const icon = payload?.notification?.icon || 'logo%20pizza.jpg';

            self.registration.showNotification(title, {
                body,
                icon,
                badge: 'logo%20pizza.jpg'
            });
        });
    }
} catch (e) {
    // Se não tiver config ou não estiver usando FCM, ignora.
}

const CACHE_NAME = 'neo-cache-v8';
const ASSETS_TO_CACHE = [
    './',
    '/admin',
    '/comanda',
    './styles.css',
    './comanda.css',
    './script.js',
    './firebase-config.js',
    './push_fcm.js',
    './admin.js',
    './comanda.js',
    './manifest.json',
    './logo%20pizza.jpg',
    './404.html'
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
                if (response) {
                    return response;
                }
                return fetch(event.request).catch(() => {
                    // Fallback se estiver offline
                    // Se for navegação de HTML, retorna o index
                    if (event.request.mode === 'navigate') {
                        return caches.match('./');
                    }
                });
            })
    );
});
