FROM        --platform=$BUILDPLATFORM openjdk:16-jdk-slim-buster AS java
FROM        nginx:latest

RUN         apt-get update -y \
            && apt-get install -y curl ca-certificates openssl git tar sqlite3 fontconfig tzdata iproute2 libstdc++6 procps bzip2 unzip xz-utils fontconfig libfreetype6 ca-certificates p11-kit jq \
            && rm -rf /var/lib/apt/lists/* \
            && useradd -d /home/container -m container

COPY        --from=java /usr/local/openjdk-16 /usr/local/openjdk-16
ENV         JAVA_HOME /usr/local/openjdk-16
ENV         PATH $JAVA_HOME/bin:$PATH

COPY        ../thread_printer.sh /utils/thread_printer.sh
RUN         chmod 0777 /utils/thread_printer.sh

COPY        ../../nginx.sh /utils/nginx.sh
RUN         chmod 0777 /utils/nginx.sh
COPY        ../../nginx.conf /utils/nginx.conf.template

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ../entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
