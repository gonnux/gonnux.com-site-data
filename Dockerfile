FROM node:alpine as builder
RUN apk add --no-cache libc6-compat git tree
WORKDIR /srv
COPY ./gonnux.com-site/ /srv
COPY ./config.yaml /srv
COPY ./blog /srv/blog
RUN yarn install --verbose
RUN NEXT_PUBLIC_GIT_COMMIT_HASH=$(git rev-parse --verify HEAD) NEXT_PUBLIC_GITHUB_REMOTE_URL=$(git remote get-url origin) NEXT_PUBLIC_GIT_BRANCH=$(git branch --show-current) yarn run --verbose build

FROM node:alpine AS runner
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001
COPY --from=builder --chown=nextjs:nodejs /srv/.next ./.next
COPY --from=builder /srv/node_modules ./node_modules
COPY --from=builder /srv/package.json ./package.json
USER nextjs
EXPOSE 3000
CMD ["yarn", "run", "start"]
