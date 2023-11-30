#!/bin/bash

# Configuración predeterminada
script_name=""
destination_dir="/usr/local/bin"  # Directorio por defecto

# Función de ayuda
function show_help {
  echo "Usage: $0 -s <script_name> [-d <destination_dir>]"
  echo "  -s: Nombre del script"
  echo "  -d: Directorio de destino (por defecto: /usr/local/bin)"
  exit 1
}

# Procesa los argumentos
while getopts ":s:d:" opt; do
  case $opt in
    s)
      script_name="$OPTARG"
      ;;
    d)
      destination_dir="$OPTARG"
      ;;
    \?)
      echo "Opción inválida: -$OPTARG"
      show_help
      ;;
    :)
      echo "La opción -$OPTARG requiere un argumento."
      show_help
      ;;
  esac
done

# Verifica que se haya proporcionado el nombre del script
if [ -z "$script_name" ]; then
  echo "Error: Debes proporcionar el nombre del script."
  show_help
fi

# Verifica que el script exista
if [ ! -f "$script_name" ]; then
  echo "Error: El archivo '$script_name' no existe."
  exit 1
fi

# Verifica si el directorio de destino existe
if [ ! -d "$destination_dir" ]; then
  echo "Error: El directorio '$destination_dir' no existe."
  exit 1
fi

# Crea el enlace simbólico en el directorio especificado
sudo ln -s "$(pwd)/$script_name" "$destination_dir/$script_name"

# Verifica el estado del enlace simbólico
if [ $? -eq 0 ]; then
  echo "Enlace simbólico creado exitosamente: $destination_dir/$script_name"
else
  echo "Error al crear el enlace simbólico."
  exit 1
fi
