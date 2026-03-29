(() => {
    function getOrCreateInstallId() {
        const key = 'agenciaPizzas_InstallId';
        let installId = localStorage.getItem(key);
        if (!installId) {
            if (window.crypto?.randomUUID) {
                installId = window.crypto.randomUUID();
            } else {
                installId = `${Date.now()}-${Math.random().toString(16).slice(2)}`;
            }
            localStorage.setItem(key, installId);
        }
        return installId;
    }

    function isMissingOrPlaceholder(value) {
        return !value || (typeof value === 'string' && value.trim().toUpperCase().startsWith('YOUR_'));
    }

    function isValidFirebaseConfig(config) {
        if (!config || typeof config !== 'object') return false;
        const required = ['apiKey', 'authDomain', 'projectId', 'messagingSenderId', 'appId'];
        return required.every((k) => !isMissingOrPlaceholder(config[k]));
    }

    async function getSupabaseUserId(dbClient) {
        try {
            const { data: { session } } = await dbClient.auth.getSession();
            return session?.user?.id || null;
        } catch {
            return null;
        }
    }

    async function ensureServiceWorkerRegistration(swPath = './sw.js') {
        if (!('serviceWorker' in navigator)) return null;
        const existing = await navigator.serviceWorker.getRegistration();
        if (existing) return existing;
        return navigator.serviceWorker.register(swPath);
    }

    async function initFirebaseMessaging() {
        if (!window.firebase || typeof window.firebase.initializeApp !== 'function') {
            throw new Error('Firebase SDK não carregado');
        }

        const config = window.FIREBASE_CONFIG;
        if (!isValidFirebaseConfig(config)) {
            throw new Error('FIREBASE_CONFIG ausente/inválido');
        }

        const vapidKey = window.FIREBASE_VAPID_KEY;
        if (isMissingOrPlaceholder(vapidKey)) {
            throw new Error('FIREBASE_VAPID_KEY ausente/inválido');
        }

        if (!firebase.apps || firebase.apps.length === 0) {
            firebase.initializeApp(config);
        }

        if (!firebase.messaging || typeof firebase.messaging !== 'function') {
            throw new Error('Firebase Messaging indisponível');
        }

        return { messaging: firebase.messaging(), vapidKey };
    }

    async function upsertToken(dbClient, { userId, app, token }) {
        const payload = {
            user_id: userId,
            app,
            token,
            user_agent: navigator.userAgent,
            last_seen_at: new Date().toISOString()
        };

        const { error } = await dbClient
            .from('push_tokens')
            .upsert(payload, { onConflict: 'token' });

        if (error) throw error;
    }

    async function insertPublicToken(dbClient, { app, token }) {
        const payload = {
            install_id: getOrCreateInstallId(),
            app: app || 'site',
            token,
            user_agent: navigator.userAgent
        };

        const { error } = await dbClient
            .from('push_tokens_public')
            .upsert(payload, { onConflict: 'token', ignoreDuplicates: true });

        if (error) throw error;
    }

    async function ensureFcmPush(dbClient, app) {
        if (!dbClient) return { ok: false, reason: 'supabase_client_missing' };
        if (!app) return { ok: false, reason: 'app_missing' };

        const userId = await getSupabaseUserId(dbClient);
        if (!userId) return { ok: false, reason: 'not_logged_in' };

        if (!('Notification' in window)) return { ok: false, reason: 'notifications_unsupported' };

        if (Notification.permission === 'default') {
            const result = await Notification.requestPermission();
            if (result !== 'granted') return { ok: false, reason: 'permission_not_granted' };
        }

        if (Notification.permission !== 'granted') {
            return { ok: false, reason: 'permission_denied' };
        }

        const registration = await ensureServiceWorkerRegistration('./sw.js');
        if (!registration) return { ok: false, reason: 'sw_registration_failed' };

        const { messaging, vapidKey } = await initFirebaseMessaging();

        const token = await messaging.getToken({
            vapidKey,
            serviceWorkerRegistration: registration
        });

        if (!token) return { ok: false, reason: 'token_empty' };

        await upsertToken(dbClient, { userId, app, token });

        return { ok: true, token };
    }

    // Público: para site/cliente sem login
    async function ensureFcmPushPublic(dbClient, app = 'site') {
        if (!dbClient) return { ok: false, reason: 'supabase_client_missing' };

        if (!('Notification' in window)) return { ok: false, reason: 'notifications_unsupported' };

        if (Notification.permission === 'default') {
            const result = await Notification.requestPermission();
            if (result !== 'granted') return { ok: false, reason: 'permission_not_granted' };
        }

        if (Notification.permission !== 'granted') {
            return { ok: false, reason: 'permission_denied' };
        }

        const registration = await ensureServiceWorkerRegistration('./sw.js');
        if (!registration) return { ok: false, reason: 'sw_registration_failed' };

        const { messaging, vapidKey } = await initFirebaseMessaging();

        const token = await messaging.getToken({
            vapidKey,
            serviceWorkerRegistration: registration
        });

        if (!token) return { ok: false, reason: 'token_empty' };

        await insertPublicToken(dbClient, { app, token });
        return { ok: true, token };
    }

    window.ensureFcmPush = ensureFcmPush;
    window.ensureFcmPushPublic = ensureFcmPushPublic;
})();
