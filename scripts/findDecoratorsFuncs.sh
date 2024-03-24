#!/bin/bash

# Función para imprimir el uso del script
print_usage() {
    echo "Uso: $0 -d <directorio> -t <texto_a_buscar>"
}

# Manejo de opciones de línea de comandos
while getopts ":d:t:" opt; do
    case ${opt} in
        d )
            directorio=$OPTARG
            ;;
        t )
            texto_a_buscar=$OPTARG
            ;;
        \? )
            echo "Opción inválida: -$OPTARG" 1>&2
            print_usage
            exit 1
            ;;
        : )
            echo "La opción -$OPTARG requiere un argumento." 1>&2
            print_usage
            exit 1
            ;;
    esac
done
shift $((OPTIND -1))

# Verificar que se proporcionaron el directorio y el texto a buscar
if [ -z "$directorio" ] || [ -z "$texto_a_buscar" ]; then
    echo "Se requieren tanto el directorio como el texto a buscar." 1>&2
    print_usage
    exit 1
fi

# Buscar archivos que contengan el patrón
archivos_encontrados=$(grep -rlE "$texto_a_buscar [a-zA-Z0-9_]*" "$directorio")

# Imprimir los nombres de los archivos encontrados
if [ -n "$archivos_encontrados" ]; then
    echo "Archivos encontrados:"
    echo "$archivos_encontrados"
    total=$(echo "$archivos_encontrados" | wc -l)
    echo "Total de archivos encontrados: $total"
    

    while IFS= read -r archivo; do
        echo "Líneas que empiezan con '@' en $archivo:"
        grep -h -A999999 "$primera_linea" "$archivo" | grep -E '^@'
    done <<< "$archivos_encontrados"
    
else
    echo "No se encontraron archivos que coincidan con el patrón especificado en el directorio $directorio."
fi
