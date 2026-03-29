# Notificações via Supabase + Firebase (FCM)

Este projeto foi preparado para usar **Firebase Cloud Messaging (FCM)** no Web Push, armazenando os tokens no **Supabase**.

## 1) Supabase: criar tabelas de tokens

1. Abra o SQL Editor do seu projeto no Supabase.
2. Execute o script: `fcm_push_tokens.sql`.

Isso cria:
- `public.push_tokens` (tokens de usuários logados via Supabase Auth: admin/comanda)
- `public.push_tokens_public` (tokens do site/cliente sem login; sem SELECT público)

## 1b) Permissoes para pedidos e clientes (obrigatorio para a Comanda)

Se os pedidos nao chegam na Comanda, execute:
- `orders_public_insert.sql`
- `customers_public_upsert.sql`

## 2) Firebase: criar projeto e pegar credenciais

No Firebase Console:

1. Crie/abra o projeto.
2. Vá em **Project Settings** > **General** > **Your apps** e adicione um app **Web**.
3. Copie o objeto de configuração (apiKey, authDomain, projectId, messagingSenderId, appId).
4. Vá em **Project Settings** > **Cloud Messaging** e gere uma **Web Push certificate (VAPID key)** (Public key).

## 3) Preencher o arquivo de configuração

Edite `firebase-config.js` e substitua:
- `YOUR_API_KEY`, `YOUR_AUTH_DOMAIN`, `YOUR_PROJECT_ID`, `YOUR_MESSAGING_SENDER_ID`, `YOUR_APP_ID`
- `YOUR_PUBLIC_VAPID_KEY`

Observação: esses valores são necessários tanto para o browser quanto para o `sw.js`.

## 4) Como funciona no front

- `admin.html` e `comanda.html` carregam Firebase + `push_fcm.js`.
- Após login, o código chama `window.ensureFcmPush(dbClient, 'admin'|'comanda')`.
- O token FCM é salvo na tabela `public.push_tokens`.
- O `sw.js` foi estendido para exibir notificações quando chegar uma mensagem em background (`onBackgroundMessage`).

## 5) Envio de notificações (lado servidor)

Para enviar push você precisa chamar a API do FCM (HTTP v1) com credenciais do Firebase (service account).

Sugestão (recomendada): **Supabase Edge Function**
- Crie uma Edge Function que:
  1) lê os tokens em `public.push_tokens` e `public.push_tokens_public` (service role),
  2) gera um access token OAuth2 com a service account,
  3) chama o endpoint do FCM HTTP v1 para cada token.

### Secrets (Edge Functions)
Você vai precisar setar secrets no Supabase (Project Settings → Edge Functions → Secrets). Exemplo:
- `FIREBASE_PROJECT_ID`
- `FIREBASE_CLIENT_EMAIL`
- `FIREBASE_PRIVATE_KEY`
- `SERVICE_ROLE_KEY` (use esse nome; o Supabase bloqueia secrets começando com `SUPABASE_`)

### Edge Function pronta
Foi adicionada a função: `send-push` em `supabase/functions/send-push/index.ts`.

**Deploy (via Supabase CLI):**
- `supabase functions deploy send-push`

**Exemplo de chamada (HTTP):**
POST `https://<SEU-PROJETO>.supabase.co/functions/v1/send-push`
Body:
```json
{
  "title": "🍕 Promoção!",
  "body": "Hoje tem desconto no delivery.",
  "app": "all",
  "url": "https://newneo.com.br/agenciadaspizzas/"
}
```

Obs.: para chamar protegido, você pode exigir `Authorization: Bearer <JWT>` e validar dentro da função (se quiser eu adiciono essa validação).

Depois você pode:
- disparar manualmente (painel/admin), ou
- integrar com um trigger no banco (ex.: novo pedido em `orders`).

## 6) Trigger automatico no banco (novo pedido)

Foi adicionado o arquivo `fcm_orders_trigger.sql` com um trigger que chama a Edge Function quando entra um pedido novo.

Passos:
1. Abra o SQL Editor no Supabase.
2. Execute o arquivo `fcm_orders_trigger.sql`.

Obs: ele usa a extensao `pg_net`. Se sua instancia nao permitir, avise que ajusto para outra abordagem.

## 7) Envio manual no Admin

No painel Admin (aba Loja) existe um card de "Notificacoes Push (FCM)" para disparos manuais.
Preencha titulo e mensagem, escolha o publico e clique em "Enviar Push".

Se você quiser, eu implemento o esqueleto da Edge Function e (opcional) um trigger usando `pg_net` para chamar a função quando entrar pedido novo.
