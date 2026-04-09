#!/bin/bash
if [ -z "$1" ]; then
    echo "Błąd: Nie podałeś adresu strony do sprawdzenia!"
    echo "Użycie: ~/moje_skrypty/monitor.sh https://google.com"
    exit 1
fi

CEL="$1"
echo "Sprawdzam status strony: $CEL ..."

STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$CEL")

if [ "$STATUS" -eq 200 ]; then
    echo "Strona żyje. Status: $STATUS"
else
    echo "Strona ma problemy albo nie istnieje . Status: $STATUS"
fi