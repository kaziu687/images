FROM node:16-buster-slim AS node

FROM gcr.io/distroless/base
COPY --from=node /usr/local /usr/local
ENTRYPOINT ["node"]

