#!/bin/bash

# Verificar que se hayan pasado dos argumentos
if [ "$#" -ne 2 ]; then
  echo "Uso: $0 archivo_original archivo_modificado"
  exit 1
fi

# Comprobar si el archivo original existe
if [ ! -f "$1" ]; then
  echo "El archivo $1 no existe"
  exit 1
fi

# Crear un archivo temporal para almacenar el contenido modificado
temp_file=$(mktemp)
while read line; do
  # Extraer la primera palabra de la línea
  first_word=$(echo "$line" | awk '{print $1}')
  # Reemplazar el espacio o tabulador después de la primera palabra por un signo igual
  modified_line=$(echo "$line" | sed "s/${first_word}[[:space:]]\{1,\}/$first_word=/")
  # Escribir la línea modificada en el archivo temporal
  echo "$modified_line" >> "$temp_file"
done < "$1"

# Sobrescribir el archivo modificado con el contenido modificado
mv "$temp_file" "$2"

echo "Archivo $2 creado correctamente"
exit 0
