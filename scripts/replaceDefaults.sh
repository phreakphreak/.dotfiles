#!/bin/bash

# Verificar que se proporcionó un directorio como argumento
if [ $# -ne 1 ]; then
    echo "Uso: $0 <directorio>"
    exit 1
fi

directorio="$1"

# Buscar archivos que contengan el patrón y guardarlos en una variable
archivos_encontrados=$(grep -rlE 'export default class [a-zA-Z0-9_]*' "$directorio")

# Imprimir los nombres de los archivos encontrados
if [ -n "$archivos_encontrados" ]; then
    echo "Archivos encontrados:"
    echo "$archivos_encontrados"
    total=$(echo "$archivos_encontrados" | wc -l)
    echo "Total de archivos encontrados: $total"
    # Pedir confirmación antes de aplicar el reemplazo
    read -p "¿Deseas aplicar el reemplazo en los archivos encontrados? (s/n): " respuesta
    if [ "$respuesta" = "s" ]; then
        for archivo in $archivos_encontrados; do
            echo "Aplicando reemplazo en $archivo ..."
            sed -i 's/export default class \([a-zA-Z0-9_]*\)/class \1/' "$archivo"
            nombre_clase=$(grep -oP 'class \K[a-zA-Z0-9_]*' "$archivo")
            if ! grep -q "export default $nombre_clase" "$archivo"; then
                echo "export default $nombre_clase" >> "$archivo"
            fi
            echo "Reemplazo aplicado en $archivo"
        done
    else
        echo "No se aplicó el reemplazo en ningún archivo."
    fi
else
    echo "No se encontraron archivos que coincidan con el patrón especificado en el directorio $directorio."
fi
