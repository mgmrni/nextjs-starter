import { z } from "zod";

export const envSchema = z.object({
  // DATABASE_URL: z.url(),
  // NEXT_PUBLIC_SUPABASE_URL: z.url(),
  // NEXT_PUBLIC_SUPABASE_ANON_KEY: z.string().min(1),
});

export const env = envSchema.parse({
  // DATABASE_URL: process.env.DATABASE_URL,
  // NEXT_PUBLIC_SUPABASE_URL: process.env.NEXT_PUBLIC_SUPABASE_URL,
  // NEXT_PUBLIC_SUPABASE_ANON_KEY: process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
});
