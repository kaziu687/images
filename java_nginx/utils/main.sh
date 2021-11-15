#!/bin/bash

settings_path="/home/container/_bedrockhost"
config_path="$settings_path/config.json"
uwaga="Nie usuwaj tego pliku oraz nie wprowadzaj w nim zmian. Ten plik jest generowany automatycznie. Jeśli chcesz skonfigurować swoją usługę użyj menu 'ustawienia'. Zmiany wprowadzane ręcznie mogą spowodować nieprawidłowe działanie Twojego serwera."

if [ ! -f "$settings_path" ]; then
    echo "Nie ma $settings_path"
    jq -nS --arg uwaga "$uwaga" '. + {_UWAGA:$uwaga}' > $config_path
elif [ "$(jq '._UWAGA' "$config_path")" != "$uwaga" ]; then
    echo "Uwaga sie nie zgadza"
    jq -S --arg uwaga "$uwaga" '. + {_UWAGA:$uwaga}' $config_path > /tmp/bh_config.json
    mv /tmp/bh_config.json "$config_path"
else
    echo "Sortowanie jsona"
    jq -S '.' $config_path > /tmp/bh_config.json
    mv /tmp/bh_config.json "$config_path"
fi

### MODULES

# SERWER WWW
if [ -d "$settings_path/serwer_www" ]; then
    /utils/./serwer_www.sh &
fi
# SERWER WWW
