#!/bin/bash

# Verificar si se proporciona un archivo como argumento
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 filename"
  exit 1
fi

archivo="$1"

# Verificar si el archivo existe
if [ ! -f "$archivo" ]; then
  echo "Error: File '$archivo' not found."
  exit 1
fi

# Crear un archivo temporal para almacenar el resultado
archivo_temporal=$(mktemp)

# Leer el archivo línea por línea, convertir el formato y escribir en el archivo temporal
while IFS= read -r linea || [ -n "$linea" ]; do
  clave=$(echo "$linea" | cut -f1)
  valor=$(echo "$linea" | cut -f2-)
  echo "$clave=$valor" >> "$archivo_temporal"
done < "$archivo"

# Sobrescribir el archivo original con el contenido formateado
mv "$archivo_temporal" "$archivo"

echo "Format conversion completed successfully."
