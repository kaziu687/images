#!/bin/bash

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

# Default the TZ environment variable to UTC.
TZ=${TZ:-UTC}
export TZ

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $NF;exit}')
export INTERNAL_IP

# Switch to the container's working directory
cd /home/container || exit 1

# Print Java version
printf "\033[1m\033[33m[BedrockHost.pl]: \033[0mjava -version\n"
java -version

# Convert all of the "{{VARIABLE}}" parts of the command into the expected shell
# variable format of "${VARIABLE}" before evaluating the string and automatically
# replacing the values.
PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

# Display the command we're running in the output, and then execute it with the env
# from the container itself.
printf "\033[1m\033[33m[BedrockHost.pl]: \033[0m%s\n" "$PARSED"

if [ ! -f "${SERVER_JARFILE}" ]; then
    printf "\033[1m\033[31m[BedrockHost.pl]: Plik %s nie istnieje - nie można uruchomić serwera\n" "$SERVER_JARFILE"
    exit 1
fi

# ANTI-BOT
if [[ ${IBC_CHECKBOX_INTERNAL_LOBBY} == "true" ]]; then
    mkdir -p /home/container/dodatkowe-lobby/plugins
    cd /home/container/dodatkowe-lobby/plugins || exit 1
    curl -LSo AntiBot.jar https://github.com/PanSzelescik/images/raw/main/java_test/AntiBot.jar
    cd /home/container/dodatkowe-lobby || exit 1
    curl -LSo flamecord.jar https://github.com/PanSzelescik/images/raw/main/java_test/flamecord.jar

    INTERNAL_LOBBY_PORT=$SERVER_PORT
    SERVER_PORT=25565

    if [ ! -f /home/container/dodatkowe-lobby/config.yml ]; then
        echo -e "listeners:\r- host: 0.0.0.0:${INTERNAL_LOBBY_PORT}\r  query_enabled: true\r  query_port: ${INTERNAL_LOBBY_PORT}\r  motd: 'Serwer hostowany przez §aBedrock§fHost.pl'" > /home/container/dodatkowe-lobby/config.yml
    else
        sed -e "s/query_port: \([0-9]\+\)/query_port: $INTERNAL_LOBBY_PORT/g" -e "s/host: 0.0.0.0:\([0-9]\+\)/host: 0.0.0.0:$INTERNAL_LOBBY_PORT/g" config.yml > bh_config.yml
        mv bh_config.yml config.yml
    fi

    printf "\033[1m\033[33m[BedrockHost.pl - AntiBot]: \033[0mUruchamianie AntiBota...\n"
    java -Xms128M -Xmx512M -jar flamecord.jar &>/dev/null &
    cd /home/container || exit 1
fi
# ANTI-BOT

# shellcheck disable=SC2086
exec env ${PARSED}
