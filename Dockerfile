FROM node:alpine as builder
RUN apk add --no-cache libc6-compat git tree
COPY . /srv
WORKDIR /srv/gonnux.com-site
RUN yarn install --verbose
RUN \
  NEXT_PUBLIC_GIT_COMMIT_HASH=$(git rev-parse --verify HEAD) \
  NEXT_PUBLIC_GITHUB_REMOTE_URL=$(git remote get-url origin) \
  NEXT_PUBLIC_GIT_BRANCH=$(git branch --show-current) \
  CONFIG_YAML=/srv/config.yaml \
  BLOG_DIR=/srv/blog \
  yarn run --verbose build

FROM node:alpine AS runner
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001
COPY --from=builder --chown=nextjs:nodejs /srv/gonnux.com-site/.next /srv/.next
COPY --from=builder /srv/gonnux.com-site/node_modules /srv/node_modules
COPY --from=builder /srv/gonnux.com-site/package.json /srv/package.json
WORKDIR /srv
USER nextjs
EXPOSE 3000
CMD ["yarn", "run", "start"]
