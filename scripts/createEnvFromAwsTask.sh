#!/bin/bash

# Verificar si se proporcionó un archivo JSON como argumento
if [ $# -eq 0 ]; then
    echo "Usage: $0 <json_file>"
    exit 1
fi

# Obtener el nombre del archivo JSON como argumento
json_file="$1"

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

        # Guardar la variable de entorno en el archivo .env
        echo "$name=$value" >> .env
    done
}

# Llamar a la función para obtener y guardar los valores
get_and_save_env_values

# Mostrar mensaje de éxito
echo "Variables de entorno guardadas en el archivo .env"
