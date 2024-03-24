#!/bin/bash

# Función para imprimir el uso del script
print_usage() {
    echo "Uso: $0 -d <directorio> -t <texto_a_buscar>"
}

# Colores
verde='\033[0;32m'
naranja='\033[0;33m'
fin_color='\033[0m'

# Manejo de opciones de línea de comandos
while getopts ":d:t:" opt; do
    case ${opt} in
    d)
        directorio=$OPTARG
        ;;
    t)
        texto_a_buscar=$OPTARG
        ;;
    \?)
        echo "Opción inválida: -$OPTARG" 1>&2
        print_usage
        exit 1
        ;;
    :)
        echo "La opción -$OPTARG requiere un argumento." 1>&2
        print_usage
        exit 1
        ;;
    esac
done
shift $((OPTIND - 1))

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
    # echo "Archivos encontrados:"
    # echo "$archivos_encontrados"
    total=$(echo "$archivos_encontrados" | wc -l)
    echo -e "${verde}Total de archivos encontrados con '$texto_a_buscar': $total${fin_color}"
    total_apariciones=0
    while IFS= read -r archivo; do
        echo -e "${verde}Archivos que contienen $texto_a_buscar en $archivo:${fin_color}"
        contador=$(grep -h -A999999 "$primera_linea" "$archivo" | grep -c -E '^[[:space:]]*@[a-zA-Z0-9_]*')
        total_apariciones=$((total_apariciones + contador))
        # grep -h -A999999 "$primera_linea" "$archivo" | grep -E '^[[:space:]]*@[a-zA-Z0-9_]*'

        grep -h -A999999 "$primera_linea" "$archivo" | while IFS= read -r linea; do
            if [[ $linea =~ ^[[:space:]]*@[a-zA-Z0-9_]*with ]]; then
                echo -e "\e[35m$linea\e[0m" # Pintar de morado
            elif [[ $linea =~ ^[[:space:]]*@[a-zA-Z0-9_]* ]]; then
                echo -e "\e[33m$linea\e[0m" # Pintar de naranja
            fi
        done

    done <<<"$archivos_encontrados"
    echo "Total de apariciones: $total_apariciones"

else
    echo "No se encontraron archivos que coincidan con el patrón especificado en el directorio $directorio."
fi
