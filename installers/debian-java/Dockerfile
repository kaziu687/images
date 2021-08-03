#
# Copyright (c) 2021 Matthew Penner
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

FROM --platform=$BUILDPLATFORM debian:stable-slim

LABEL author="PanSzelescik" maintainer="panszelescik@github.com"

LABEL org.opencontainers.image.authors="PanSzelescik, Michael Parker"
LABEL org.opencontainers.image.source="https://github.com/PanSzelescik/images"
LABEL org.opencontainers.image.licenses=MIT

ENV DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386 \
    && apt update \
    && apt upgrade -y \
    && apt -y --no-install-recommends install ca-certificates curl fontconfig lib32gcc1 libsdl2-2.0-0:i386 locales git tzdata \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.UTF-8

ENV JAVA_VERSION jdk8u292-b10

RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    case "${ARCH}" in \
       aarch64|arm64) \
         ESUM='b062ec775e6c2961532d9afeae4027fe3ac2cf4344cbc912a401be5bfb6ca221'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u292-b10/OpenJDK8U-jre_aarch64_linux_hotspot_8u292b10.tar.gz'; \
         ;; \
       armhf|armv7l) \
         ESUM='7f7707a7a3998737d2221080ea65d50ea96f5dde5226961ebcebd3ec99a82a32'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u292-b10/OpenJDK8U-jre_arm_linux_hotspot_8u292b10.tar.gz'; \
         ;; \
       ppc64el|ppc64le) \
         ESUM='245ecd0dfde7e763c0b65028aa0440489466926be2ba018977ac9047dc328a8e'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u292-b10/OpenJDK8U-jre_ppc64le_linux_hotspot_8u292b10.tar.gz'; \
         ;; \
       s390x) \
         ESUM='170c12f2017c212b23c1ba47728dcf9f5f2c9f2e29abf503136a8e55f513e048'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u292-b10/OpenJDK8U-jre_s390x_linux_hotspot_8u292b10.tar.gz'; \
         ;; \
       amd64|x86_64) \
         ESUM='cad66f48f90167ed19030c71f8f0580702c43cce5ce5a0d76833f7a5ae7c402a'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u292-b10/OpenJDK8U-jre_x64_linux_hotspot_8u292b10.tar.gz'; \
         ;; \
       *) \
         echo "Unsupported arch: ${ARCH}"; \
         exit 1; \
         ;; \
    esac; \
    curl -LfsSo /tmp/openjdk.tar.gz ${BINARY_URL}; \
    echo "${ESUM} */tmp/openjdk.tar.gz" | sha256sum -c -; \
    mkdir -p /opt/java/openjdk; \
    cd /opt/java/openjdk; \
    tar -xf /tmp/openjdk.tar.gz --strip-components=1; \
    rm -rf /tmp/openjdk.tar.gz;

ENV JAVA_HOME=/opt/java/openjdk \
    PATH="/opt/java/openjdk/bin:$PATH"

ENV JAVA_VERSION jdk-16.0.1+9

RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    case "${ARCH}" in \
       aarch64|arm64) \
         ESUM='4e47f1cbf46190727be74cd73445ec2b693f5ba4a74542c554d6b3285811cab5'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk16-binaries/releases/download/jdk-16.0.1%2B9/OpenJDK16U-jre_aarch64_linux_hotspot_16.0.1_9.tar.gz'; \
         ;; \
       armhf|armv7l) \
         ESUM='c1f88f3ce955cb2e9a4236a916cc6660ef55231d29c4390b1a4398ebbca358b7'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk16-binaries/releases/download/jdk-16.0.1%2B9/OpenJDK16U-jre_arm_linux_hotspot_16.0.1_9.tar.gz'; \
         ;; \
       ppc64el|ppc64le) \
         ESUM='495805e2e9bcabeac0d8271623b6c92604440608286f4ce411ea48f582854930'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk16-binaries/releases/download/jdk-16.0.1%2B9/OpenJDK16U-jre_ppc64le_linux_hotspot_16.0.1_9.tar.gz'; \
         ;; \
       s390x) \
         ESUM='780f10923df3230b6013c74482adcc6d8c1fef7b60aefe59a0b337183767d214'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk16-binaries/releases/download/jdk-16.0.1%2B9/OpenJDK16U-jre_s390x_linux_hotspot_16.0.1_9.tar.gz'; \
         ;; \
       amd64|x86_64) \
         ESUM='5eca19d406c6d130e9c3a4b932b9cb0a6e9cd45932450668c3e911bded4bcf40'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk16-binaries/releases/download/jdk-16.0.1%2B9/OpenJDK16U-jre_x64_linux_hotspot_16.0.1_9.tar.gz'; \
         ;; \
       *) \
         echo "Unsupported arch: ${ARCH}"; \
         exit 1; \
         ;; \
    esac; \
    curl -LfsSo /tmp/openjdk-16.tar.gz ${BINARY_URL}; \
    echo "${ESUM} */tmp/openjdk-16.tar.gz" | sha256sum -c -; \
    mkdir -p /opt/java/openjdk-16; \
    cd /opt/java/openjdk-16; \
    tar -xf /tmp/openjdk-16.tar.gz --strip-components=1; \
    rm -rf /tmp/openjdk-16.tar.gz;

ENV JAVA_HOME=/opt/java/openjdk-16 \
    PATH="/opt/java/openjdk-16/bin:$PATH"

RUN update-alternatives --install /usr/bin/java java /opt/java/openjdk/bin/java 100
RUN update-alternatives --install /usr/bin/java16 java16 /opt/java/openjdk-16/bin/java 100
