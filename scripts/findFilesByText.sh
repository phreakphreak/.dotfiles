#!/bin/bash

# Verificar que se proporcionó un directorio como argumento
if [ $# -ne 1 ]; then
    echo "Uso: $0 <directorio>"
    exit 1
fi

directorio="$1"

# Buscar archivos que contengan el patrón
archivos_encontrados=$(grep -rlE 'export default class [a-zA-Z0-9_]*' "$directorio")

# Imprimir los nombres de los archivos encontrados
if [ -n "$archivos_encontrados" ]; then
    echo "Archivos encontrados:"
    echo "$archivos_encontrados"
    total=$(echo "$archivos_encontrados" | wc -l)
    echo "Total de archivos encontrados: $total"
else
    echo "No se encontraron archivos que coincidan con el patrón especificado en el directorio $directorio."
fi
