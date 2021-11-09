#!/bin/bash

config_path="/home/container/_bedrockhost/config.json"
serwer_www_path="/home/container/_bedrockhost/serwer_www"

printf "\033[1m\033[31m[Serwer WWW]: UWAGA: Funkcjonalność serwera WWW jest jeszcze w trakcie testów i może nie działać prawidłowo\033[0m\n"
mkdir -p $serwer_www_path/publiczny

cp /utils/nginx.conf.template /tmp/nginx.conf

default_serwer_www="{\"_UWAGA\":\"Nie usuwaj oraz nie wprowadzaj zmian w tym pliku. Jeśli chcesz skonfigurować serwer WWW na swojej usłudze hostingu przejdź do ustawień.\",\"port\":30080,\"enabled\":true}"

if [ ! -f "$config_path" ]; then # Jeśli nie ma pliku - utwórz go z domyślnymi ustawieniami serwera WWW
    jq -n --argjson serwer_www "$default_serwer_www" '. + serwer_www:$serwer_www' > $config_path
elif [ "$(jq '.serwer_www|type=="object"' "$config_path")" == "false" ]; then # Jeśli plik jest, ale serwer_www nie jest obiektem, dodaj do jsona domyślne ustawienia serwera WWW
    jq --argjson serwer_www "$default_serwer_www" '. + {serwer_www:$serwer_www}' $config_path > /tmp/serwer_www.json
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
nginx -c '/tmp/nginx.conf' -t
nginx -c '/tmp/nginx.conf' -g 'daemon off;'
