// Tipos mínimos para evitar erros do TS server no VS Code.
// Em runtime, o Supabase Edge Functions roda em Deno e suporta imports por URL.

declare module "https://esm.sh/@supabase/supabase-js@2" {
  export const createClient: (...args: any[]) => any;
}

declare const Deno: {
  env: {
    get: (key: string) => string | undefined;
  };
  serve: (handler: (req: Request) => Response | Promise<Response>) => void;
};
