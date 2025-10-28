#!/bin/bash

# Uso: ./buscar_cambios.sh ruta/al/archivo "texto_a_buscar"

if [ $# -ne 2 ]; then
    echo "Uso: $0 <archivo> <string>"
    exit 1
fi

archivo="$1"
buscar="$2"

# Iterar sobre los commits que tocaron ese archivo
git log --follow --pretty=format:"%H" -- "$archivo" | while read commit; do
    # Revisar si en el diff del commit aparece el string
    if git show "$commit" -- "$archivo" | grep -q "$buscar"; then
        # Imprimir commit y mensaje
        git log -1 --pretty=format:"%C(yellow)%h %Creset%s %Cgreen(%an, %ad)%Creset" "$commit"
        echo "----------------------------------------"
    fi
done
