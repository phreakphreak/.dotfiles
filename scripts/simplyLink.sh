#!/bin/bash

# Obtener la ruta completa del archivo
absolute_path=$(realpath "$1")

# Verificar si el archivo existe
if [ ! -f "$absolute_path" ]; then
  echo "El archivo $1 no existe"
  exit 1
fi

# Obtener el nombre del archivo original
filename=$(basename "$absolute_path")

# Obtener el nombre del enlace simbólico deseado (segundo argumento)
symlink_name="$2"

# Si no se proporcionó un nombre para el enlace simbólico, utilizar el nombre del archivo original
if [ -z "$symlink_name" ]; then
  symlink_name="$filename"
fi

# Crear el directorio ~/.local/bin si no existe
mkdir -p "$HOME/.local/bin"

# Crear el enlace simbólico en ~/.local/bin
ln -s "$absolute_path" "$HOME/.local/bin/$symlink_name"

echo "Enlace simbólico creado correctamente en ~/.local/bin/$symlink_name"
exit 0
