/* Supabase Edge Function: send-push

Envia Web Push via Firebase Cloud Messaging (FCM) HTTP v1.

Secrets necessários (Project Settings → Edge Functions → Secrets):
- FIREBASE_PROJECT_ID
- FIREBASE_CLIENT_EMAIL
- FIREBASE_PRIVATE_KEY
- SERVICE_ROLE_KEY (NÃO pode começar com SUPABASE_)

Observação: FIREBASE_PRIVATE_KEY normalmente vem com \n no JSON; aqui deve manter as quebras de linha (ou string com \n).
*/

/// <reference path="./types.d.ts" />

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const Deno = (globalThis as any).Deno as any;

type SendPushRequest = {
  title: string;
  body: string;
  url?: string;
  icon?: string;
  app?: "site" | "admin" | "comanda" | "all";
};

function jsonResponse(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: {
      "content-type": "application/json; charset=utf-8",
      "access-control-allow-origin": "*",
      "access-control-allow-headers": "authorization, x-client-info, apikey, content-type",
      "access-control-allow-methods": "POST, OPTIONS",
    },
  });
}

function base64UrlEncode(input: Uint8Array): string {
  const b64 = btoa(String.fromCharCode(...input));
  return b64.replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/g, "");
}

function utf8Bytes(value: string): Uint8Array {
  return new TextEncoder().encode(value);
}

function toArrayBuffer(bytes: Uint8Array): ArrayBuffer {
  // Evita o erro de tipagem do TS com ArrayBufferLike/SharedArrayBuffer.
  // Criar uma cópia garante um ArrayBuffer “puro”.
  return new Uint8Array(bytes).buffer;
}

function pemToPkcs8Bytes(pem: string): Uint8Array {
  const cleaned = pem
    .replace(/-----BEGIN PRIVATE KEY-----/g, "")
    .replace(/-----END PRIVATE KEY-----/g, "")
    .replace(/\s+/g, "");

  const raw = atob(cleaned);
  const bytes = new Uint8Array(raw.length);
  for (let i = 0; i < raw.length; i++) bytes[i] = raw.charCodeAt(i);
  return bytes;
}

async function importPrivateKey(privateKeyPem: string): Promise<CryptoKey> {
  const pkcs8 = pemToPkcs8Bytes(privateKeyPem);
  return await crypto.subtle.importKey(
    "pkcs8",
    toArrayBuffer(pkcs8),
    {
      name: "RSASSA-PKCS1-v1_5",
      hash: "SHA-256",
    },
    false,
    ["sign"],
  );
}

async function createServiceAccountAccessToken(params: {
  clientEmail: string;
  privateKeyPem: string;
}): Promise<string> {
  const now = Math.floor(Date.now() / 1000);
  const header = { alg: "RS256", typ: "JWT" };
  const claimSet = {
    iss: params.clientEmail,
    scope: "https://www.googleapis.com/auth/firebase.messaging",
    aud: "https://oauth2.googleapis.com/token",
    iat: now,
    exp: now + 3600,
  };

  const encodedHeader = base64UrlEncode(utf8Bytes(JSON.stringify(header)));
  const encodedClaims = base64UrlEncode(utf8Bytes(JSON.stringify(claimSet)));
  const signingInput = `${encodedHeader}.${encodedClaims}`;

  const key = await importPrivateKey(params.privateKeyPem);
  const signature = new Uint8Array(
    await crypto.subtle.sign(
      { name: "RSASSA-PKCS1-v1_5" },
      key,
      toArrayBuffer(utf8Bytes(signingInput)),
    ),
  );
  const jwt = `${signingInput}.${base64UrlEncode(signature)}`;

  const form = new URLSearchParams();
  form.set("grant_type", "urn:ietf:params:oauth:grant-type:jwt-bearer");
  form.set("assertion", jwt);

  const res = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    headers: { "content-type": "application/x-www-form-urlencoded" },
    body: form.toString(),
  });

  const json = await res.json();
  if (!res.ok) {
    throw new Error(`OAuth token error: ${res.status} ${JSON.stringify(json)}`);
  }

  const accessToken = json.access_token;
  if (!accessToken) throw new Error("OAuth token error: access_token ausente");
  return accessToken as string;
}

function uniqTokens(tokens: string[]): string[] {
  const set = new Set<string>();
  for (const t of tokens) {
    if (typeof t === "string" && t.trim().length > 0) set.add(t.trim());
  }
  return Array.from(set);
}

function chunk<T>(arr: T[], size: number): T[][] {
  const out: T[][] = [];
  for (let i = 0; i < arr.length; i += size) out.push(arr.slice(i, i + size));
  return out;
}

async function fcmSend(params: {
  accessToken: string;
  projectId: string;
  token: string;
  title: string;
  body: string;
  url?: string;
  icon?: string;
}): Promise<{ ok: true } | { ok: false; status: number; error: unknown }> {
  const endpoint = `https://fcm.googleapis.com/v1/projects/${params.projectId}/messages:send`;

  const payload: Record<string, unknown> = {
    message: {
      token: params.token,
      notification: {
        title: params.title,
        body: params.body,
      },
      webpush: {
        notification: {
          title: params.title,
          body: params.body,
          icon: params.icon || "logo%20pizza.jpg",
        },
        fcm_options: params.url ? { link: params.url } : undefined,
      },
    },
  };

  // Remove campos undefined
  const message = payload.message as Record<string, unknown>;
  const webpush = message.webpush as Record<string, unknown>;
  if (!webpush.fcm_options) delete webpush.fcm_options;

  const res = await fetch(endpoint, {
    method: "POST",
    headers: {
      authorization: `Bearer ${params.accessToken}`,
      "content-type": "application/json",
    },
    body: JSON.stringify(payload),
  });

  if (res.ok) return { ok: true };

  let errJson: unknown;
  try {
    errJson = await res.json();
  } catch {
    errJson = await res.text();
  }
  return { ok: false, status: res.status, error: errJson };
}

Deno.serve(async (req: Request): Promise<Response> => {
  if (req.method === "OPTIONS") return jsonResponse({ ok: true }, 200);
  if (req.method !== "POST") return jsonResponse({ error: "Use POST" }, 405);

  const supabaseUrl = Deno.env.get("SUPABASE_URL") ?? "";
  const serviceRoleKey = Deno.env.get("SERVICE_ROLE_KEY") ?? "";

  const projectId = Deno.env.get("FIREBASE_PROJECT_ID") ?? "";
  const clientEmail = Deno.env.get("FIREBASE_CLIENT_EMAIL") ?? "";
  let privateKey = Deno.env.get("FIREBASE_PRIVATE_KEY") ?? "";

  // Normaliza private key se vier com \n literal
  if (privateKey.includes("\\n")) {
    privateKey = privateKey.replace(/\\n/g, "\n");
  }

  if (!supabaseUrl || !serviceRoleKey) {
    return jsonResponse({ error: "Secrets do Supabase ausentes (SUPABASE_URL/SERVICE_ROLE_KEY)" }, 500);
  }

  if (!projectId || !clientEmail || !privateKey) {
    return jsonResponse({ error: "Secrets do Firebase ausentes (FIREBASE_PROJECT_ID/CLIENT_EMAIL/PRIVATE_KEY)" }, 500);
  }

  let body: SendPushRequest;
  try {
    body = await req.json();
  } catch {
    return jsonResponse({ error: "JSON inválido" }, 400);
  }

  if (!body?.title || !body?.body) {
    return jsonResponse({ error: "Campos obrigatórios: title, body" }, 400);
  }

  const app = body.app ?? "all";

  const supabase = createClient(supabaseUrl, serviceRoleKey, {
    auth: { persistSession: false },
  });

  // 1) Buscar tokens
  const tokens: string[] = [];

  // tokens de usuários logados
  {
    let query = supabase.from("push_tokens").select("token, app");
    if (app !== "all") query = query.eq("app", app);

    const { data, error } = await query;
    if (error) return jsonResponse({ error: `Erro lendo push_tokens: ${error.message}` }, 500);
    for (const row of data ?? []) tokens.push((row as any).token);
  }

  // tokens públicos do site
  {
    let query = supabase.from("push_tokens_public").select("token, app");
    if (app !== "all") query = query.eq("app", app);

    const { data, error } = await query;
    if (error) return jsonResponse({ error: `Erro lendo push_tokens_public: ${error.message}` }, 500);
    for (const row of data ?? []) tokens.push((row as any).token);
  }

  const unique = uniqTokens(tokens);
  if (unique.length === 0) {
    return jsonResponse({ ok: true, sent: 0, message: "Sem tokens cadastrados" }, 200);
  }

  // 2) Token OAuth2
  let accessToken: string;
  try {
    accessToken = await createServiceAccountAccessToken({ clientEmail, privateKeyPem: privateKey });
  } catch (e) {
    return jsonResponse({ error: `Falha gerando access token: ${String(e)}` }, 500);
  }

  // 3) Enviar com concorrência moderada
  const batches = chunk(unique, 25);
  let sent = 0;
  const failures: Array<{ token: string; status: number; error: unknown }> = [];

  for (const batch of batches) {
    const results = await Promise.all(
      batch.map(async (token) => {
        const r = await fcmSend({
          accessToken,
          projectId,
          token,
          title: body.title,
          body: body.body,
          url: body.url,
          icon: body.icon,
        });
        return { token, r };
      }),
    );

    for (const { token, r } of results) {
      if (r.ok) sent++;
      else failures.push({ token, status: r.status, error: r.error });
    }
  }

  return jsonResponse({
    ok: failures.length === 0,
    sent,
    totalTokens: unique.length,
    failuresCount: failures.length,
    failures: failures.slice(0, 20),
  });
});
