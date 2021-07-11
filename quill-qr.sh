#!/usr/bin/env bash

IFS=$'\n' read -r -d '' -a messages < <( cat - | jq -M 'if . | type != "array" then [.] else . end' | jq -rcM .[] && printf '\0' )

for message in "${messages[@]}"
do
    echo "$message" | gzip -c | base64 | qrencode -t ANSIUTF8
    echo ENTER TO CONTINUE...
    read < /dev/tty
    clear
done
