#!/bin/bash

bh_path="/home/container/_bedrockhost"
config_path="$bh_path/config.json"
serwer_www_path="$bh_path/serwer_www"
default_serwer_www="{\"port\":30080,\"enabled\":true}"
nginx_config="/tmp/nginx.conf"

mkdir -p $serwer_www_path/publiczny
cp /utils/nginx.conf.template /tmp/nginx.conf

if [ "$(jq '.serwer_www|type=="object"' "$config_path")" == "false" ]; then # Jeśli serwer_www nie jest obiektem, dodaj do jsona domyślne ustawienia serwera WWW
    jq -S --argjson serwer_www "$default_serwer_www" '. + {serwer_www:$serwer_www}' $config_path > /tmp/serwer_www.json
    mv /tmp/serwer_www.json "$config_path"
fi

port=$(jq '.serwer_www.port | tonumber' "$config_path")
if [[ -z "$port" || $port == 30080 ]]; then
    printf "\033[1m\033[31m[Serwer WWW]: Port serwera nie został prawidłowo ustawiony, więc nie został on uruchomiony\033[0m\n"
    printf "\033[1m\033[31m[Serwer WWW]: Konfigurację serwera WWW znajdziesz w ustawieniach usługi\033[0m\n"
    printf "\033[1m\033[31m[Serwer WWW]: Jak uruchomić serwer WWW dowiesz się z naszego poradnika:\033[0m\n"
    printf "\033[1m\033[31m[Serwer WWW]: \033[36mhttps://bedrockhost.pl/w/docs/panel/zarzadzanie-plikami/jak-uruchomic-serwer-www-na-hostingu/\033[0m\n"
    exit 1
fi
sed -i "s/{PORT}/$port/g" /tmp/nginx.conf

enabled=$(jq '.serwer_www.enabled' "$config_path")
if [[ -z "$enabled" || "$enabled" == "false" || "$enabled" == "null" ]]; then
    exit 0
fi

printf "\033[1m\033[33m[Serwer WWW]: \033[0mUruchamianie serwera na porcie %s...\033[0m\n" "$port"
nginx -c $nginx_config -t
nginx -c $nginx_config -g 'daemon off;'
