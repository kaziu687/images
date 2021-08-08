FROM node:16-buster-slim AS node

RUN apt update
RUN apt install -y libstdc++6

FROM gcr.io/distroless/base
COPY --from=node /usr/local /usr/local
COPY --from=node /usr/lib /usr/lib
ENTRYPOINT ["node"]

