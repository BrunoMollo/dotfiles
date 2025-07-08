#!/bin/bash
prop="Quiero que traduzcas los sigueientes inputs al portugues en formato json para que se agreguen al  \/lang\/pt-BR.json, agregalo al pricncipio del json para evitar conflictos: \n"

# Obtiene las líneas añadidas en el diff de Git en relación a la rama 'dev'
git diff dev | 
	# Filtra las líneas que contienen un signo '+' (lineas agregadas) y un guion bajo '_' (por la traduccion)
grep '\+' | grep _ | 
# Extrae el texto entre comillas después del guion bajo usando sed
sed -n "s/.*_(\(['\"]\)\(.*\)\1).*/\2/p" | 
	# Añade un guion al inicio de cada línea (para que quede lindo nomas)
sed 's/^/- /' | 
# Añade el encabezado 'prop' al principio para indicar el propósito
sed "1s/^/$prop/"
