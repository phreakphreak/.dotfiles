#!/bin/bash

# Verificar si el archivo .env existe
if [ ! -f "$1" ]; then
  echo "El archivo $1 no existe"
  exit 1
fi

# Codificar el archivo en Base64
base64_content=$(base64 < "$1")

# Copiar el contenido codificado al portapapeles
echo -n "$base64_content" | xclip -selection clipboard

echo "Contenido del archivo $1 codificado en Base64 y copiado al portapapeles"
exit 0
