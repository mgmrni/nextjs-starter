# ----------------------------
# Build stage
# ----------------------------
FROM node:24-bullseye AS builder
WORKDIR /app

# pnpm 有効化
RUN corepack enable
RUN corepack prepare pnpm@11 --activate

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
RUN pnpm install --frozen-lockfile

COPY . .

# Prisma生成とNext.jsビルド
# RUN pnpm prisma generate
RUN pnpm build

# ----------------------------
# Runtime stage
# ----------------------------
FROM node:24-slim AS runner
WORKDIR /app

# 必要なファイルだけコピー
COPY --from=builder /package.json ./
COPY --from=builder /pnpm-lock.yaml ./
COPY --from=builder /node_modules ./node_modules
COPY --from=builder /.next ./.next
# COPY --from=builder /prisma ./prisma

ENV NODE_ENV=production
EXPOSE 3000

CMD ["node_modules/.bin/next", "start"]
