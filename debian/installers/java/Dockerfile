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

FROM --platform=$BUILDPLATFORM adoptopenjdk/openjdk8:debianslim-jre AS java8
FROM --platform=$BUILDPLATFORM adoptopenjdk/openjdk16:debianslim-jre AS java16
FROM --platform=$BUILDPLATFORM debian:stable-slim

LABEL author="PanSzelescik" maintainer="panszelescik@github.com"

LABEL org.opencontainers.image.authors="PanSzelescik, Michael Parker"
LABEL org.opencontainers.image.source="https://github.com/PanSzelescik/images"
LABEL org.opencontainers.image.licenses=MIT

ENV DEBIAN_FRONTEND=noninteractive

COPY --from=java8 /opt/java/openjdk /opt/java/openjdk8
COPY --from=java16 /opt/java/openjdk /opt/java/openjdk16

RUN dpkg --add-architecture i386 \
    && apt update \
    && apt upgrade -y \
    && apt -y --no-install-recommends install ca-certificates curl fontconfig lib32gcc1 libsdl2-2.0-0:i386 locales git tzdata \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.UTF-8

RUN update-alternatives --install /usr/bin/java java /opt/java/openjdk/bin/java 100 \
    && update-alternatives --install /usr/bin/java16 java16 /opt/java/openjdk16/bin/java 100
