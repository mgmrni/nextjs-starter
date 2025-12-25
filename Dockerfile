# ----------------------------
# Build stage
# ----------------------------
FROM node:24-bullseye AS builder
WORKDIR /app

# Yarn有効化
RUN corepack enable
RUN corepack prepare yarn@stable --activate

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

COPY . .

# Prisma生成とNext.jsビルド
# RUN yarn prisma generate
RUN yarn build

# ----------------------------
# Runtime stage
# ----------------------------
FROM node:24-slim AS runner
WORKDIR /app

# 必要なファイルだけコピー
COPY --from=builder /package.json ./
COPY --from=builder /yarn.lock ./
COPY --from=builder /node_modules ./node_modules
COPY --from=builder /.next ./.next
# COPY --from=builder /prisma ./prisma

ENV NODE_ENV=production
EXPOSE 3000

CMD ["yarn", "start"]
