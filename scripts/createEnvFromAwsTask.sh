#!/bin/bash

# Inicializar variables con valores por defecto
output_directory="."

# Función para mostrar el uso del script
usage() {
    echo "Usage: $0 -f <json_file> [-d <output_directory>]"
    echo "Options:"
    echo "  -f, --file           JSON file containing environment variables"
    echo "  -d, --directory      Directory to save the .env file (default: current directory)"
    exit 1
}

# Obtener los argumentos de línea de comandos
while getopts ":f:d:" opt; do
    case $opt in
        f | -file)
            json_file="$OPTARG"
            ;;
        d | -directory)
            output_directory="$OPTARG"
            ;;
        \?)
            echo "Opción inválida: -$OPTARG" >&2
            usage
            ;;
        :)
            echo "La opción -$OPTARG requiere un argumento." >&2
            usage
            ;;
    esac
done

# Verificar si se proporcionó un archivo JSON como argumento
if [ -z "$json_file" ]; then
    echo "Debe especificar un archivo JSON."
    usage
fi

# Verificar si el archivo JSON existe
if [ ! -f "$json_file" ]; then
    echo "El archivo $json_file no existe."
    exit 1
fi

# Función para obtener y guardar los valores de las variables de entorno
get_and_save_env_values() {
    # Iterar sobre cada secreto y extraer el nombre y el valueFrom
    jq -r '.containerDefinitions[0].secrets[] | "\(.name) \(.valueFrom)"' "$json_file" | \
    while read -r name valueFrom; do
        # Obtener el valor del parámetro desde AWS SSM
        response=$(aws ssm get-parameter --name "$valueFrom" --with-decryption)
        value=$(echo "$response" | jq -r '.Parameter.Value')

        # Guardar la variable de entorno en el archivo .env si no está vacía
        if [ -n "$value" ]; then
            echo "$name=$value" >> "$output_directory/.env"
        fi
    done
}

# Llamar a la función para obtener y guardar los valores
get_and_save_env_values

# Eliminar variables de entorno repetidas y vacías
awk '!seen[$0]++' "$output_directory/.env" | grep -v '^=' > "$output_directory/.env_temp"
mv "$output_directory/.env_temp" "$output_directory/.env"

# Mostrar mensaje de éxito
echo "Variables de entorno guardadas en el archivo $output_directory/.env"
