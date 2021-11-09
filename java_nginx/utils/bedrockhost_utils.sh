#!/bin/bash

settings_path="/home/container/_bedrockhost"

# SERWER WWW
if [ -d "$settings_path/serwer_www" ]; then
    /utils/./serwer_www.sh &
fi
# SERWER WWW
