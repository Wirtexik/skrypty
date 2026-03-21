#!/bin/bash

if [ -z "$1" ]; then
    echo "BLAD: Nie podales schematu nazwy!"
    exit 1
fi

SCHEMAT="$1"
FOLDER="$HOME/Sprawozdania_Do_Zmiany"

if [ ! -d "$FOLDER" ]; then
    mkdir -p "$FOLDER"
fi

echo "=== PODGLAD ZMIAN ==="
Licznik=1
for PLIK in "$FOLDER"/*; do
    if [ ! -e "$PLIK" ]; then
        echo "Folder jest pusty! Nic nie robie."
        exit 0
    fi
    STARA_NAZWA=$(basename "$PLIK")
    ROZSZERZENIE="${STARA_NAZWA##*.}"
    NOWA_NAZWA="${SCHEMAT}_${Licznik}.${ROZSZERZENIE}"
    
    echo "Zmieniam: $STARA_NAZWA  --->  $NOWA_NAZWA"
    Licznik=$((Licznik+1))
done

echo "----------------------------------------------"
read -r -p "Zatwierdzasz te zmiany? (T/N): " DECYZJA

if [ "$DECYZJA" = "T" ] || [ "$DECYZJA" = "t" ]; then
    Licznik=1
    for PLIK in "$FOLDER"/*; do
        STARA_NAZWA=$(basename "$PLIK")
        ROZSZERZENIE="${STARA_NAZWA##*.}"
        NOWA_NAZWA="${SCHEMAT}_${Licznik}.${ROZSZERZENIE}"
        
        mv "$PLIK" "$FOLDER/$NOWA_NAZWA"
        Licznik=$((Licznik+1))
    done
    echo "Zrobione! Pliki zmienione."
else
    echo "Anulowano. Nic nie ruszylem."
fi
