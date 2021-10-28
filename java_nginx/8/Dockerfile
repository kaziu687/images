FROM        --platform=$BUILDPLATFORM ghcr.io/pterodactyl/yolks:java_8 AS java
FROM        nginx:latest

RUN         apt-get update -y \
            && apt-get install -y curl ca-certificates openssl git tar sqlite3 fontconfig tzdata iproute2 libstdc++6 bzip2 unzip xz-utils fontconfig libfreetype6 ca-certificates p11-kit \
            && rm -rf /var/lib/apt/lists/*
            && useradd -d /home/container -m container
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY --from=java /usr/local/openjdk-8 /usr/local/openjdk-8

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
