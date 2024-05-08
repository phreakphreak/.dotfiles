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

# Lista de directorios y archivos a ignorar
archivos_a_ignorar=("_app.tsx" "404.tsx" "_error.tsx", "_document.tsx")

# Función para verificar si se debe ignorar un directorio o archivo
deberia_ignorar() {
    local item="$1"
    local lista=("$@")

    for i in "${lista[@]}"; do
        if [[ "$i" == "$item" ]]; then
            return 0
        fi
    done
    return 1
}

# Listar todos los archivos en el directorio y subdirectorios, evitando los especificados
archivos=$(find "$directorio" -type f -print | grep -v '/api/' | grep -v -e "$(printf "%s\n" "${archivos_a_ignorar[@]}")")
archivos_con_texto=$(grep -rl "getServerSideProps" "$directorio" | grep -v -e "$(printf "%s\n" "${archivos_a_ignorar[@]}")" || true)

# Imprimir todos los archivos encontrados
# echo "Listado de todos los archivos en el directorio $directorio (excepto los ignorados):"
# echo "$archivos"
#
# # Imprimir archivos que contienen la cadena
# echo "Archivos que contienen 'getServerSideProps' (excepto los ignorados):"
# echo "$archivos_con_texto"

# Comparar listas de archivos para encontrar los que no tienen la cadena
archivos_sin_texto=$(comm -23 <(echo "$archivos" | sort) <(echo "$archivos_con_texto" | sort))

# Imprimir archivos que no tienen la cadena
echo "Archivos que no contienen 'getServerSideProps' (excepto los ignorados):"
echo "$archivos_sin_texto"
