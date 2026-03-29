(() => {
    const config = {
        apiKey: "AIzaSyBn2TCMrW_yGqIyiBtIxrNMN7YKI0HYe8A",
        authDomain: "agenciadaspizzas-f4a31.firebaseapp.com",
        projectId: "agenciadaspizzas-f4a31",
        messagingSenderId: "153877142001",
        appId: "1:153877142001:web:6d617c14f19f64fe508c50"
    };

    const vapidKey = "BJHQIXhaGWw644-XNkzt6t_sP-9CWqqTzaIGI1DB3oDjrkz_-xXhJ5AGN7glab935PiP1XH7tLJv-eDkT6GyMC8";

    if (typeof window !== 'undefined') {
        window.FIREBASE_CONFIG = config;
        window.FIREBASE_VAPID_KEY = vapidKey;
    }

    if (typeof self !== 'undefined') {
        self.FIREBASE_CONFIG = config;
        self.FIREBASE_VAPID_KEY = vapidKey;
    }
})();
