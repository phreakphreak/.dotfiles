#!/bin/bash

if [ -z "$1" ]; then
  echo "Debe proporcionar una ruta de archivo como argumento"
  exit 1
fi

if [ ! -f "$1" ]; then
  echo "El archivo $1 no existe"
  exit 1
fi

touch env.example

while read line; do
  if [[ "$line" =~ ^[a-zA-Z_][a-zA-Z0-9_]*=.*$ ]]; then
    var_name=$(echo "$line" | cut -d= -f1)
    echo "$var_name=" >> env.example
  fi
done < "$1"

echo "Archivo env.example creado correctamente"
exit 0
