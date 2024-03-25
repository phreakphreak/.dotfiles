#!/bin/bash

# Función para imprimir el uso del script
print_usage() {
    echo "Uso: $0 -d <directorio>"
    echo "  -d <directorio>: Especifica el directorio donde se realizará la búsqueda"
}

# Parsear los argumentos de línea de comandos
while getopts ":d:" opt; do
    case ${opt} in
        d )
            directorio=$OPTARG
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

# Verificar si se proporcionó el directorio
if [ -z "$directorio" ]; then
    echo "Se debe especificar el directorio de búsqueda."
    print_usage
    exit 1
fi

# Verificar si el directorio existe
if [ ! -d "$directorio" ]; then
    echo "El directorio $directorio no existe."
    exit 1
fi

# Listar todos los archivos en el directorio y subdirectorios
archivos=$(find "$directorio" -type f)

# Imprimir todos los archivos encontrados
# echo "Listado de todos los archivos en el directorio $directorio:"
# echo "$archivos"

# Realizar la búsqueda en los archivos
archivos_con_texto=$(grep -rl "getServerSideProps" "$directorio" || true)

# Imprimir archivos que contienen la cadena
# echo "Archivos que contienen 'getServerSideProps':"
# echo "$archivos_con_texto"

# Comparar listas de archivos para encontrar los que no tienen la cadena
archivos_sin_texto=$(comm -23 <(echo "$archivos" | sort) <(echo "$archivos_con_texto" | sort))

# Imprimir archivos que no tienen la cadena
echo "Archivos que no contienen 'getServerSideProps':"
echo "$archivos_sin_texto"
