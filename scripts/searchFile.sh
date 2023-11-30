#!/bin/bash

# Inicializar variables con valores predeterminados
directorio_actual="$(pwd)"
archivo=""

# Procesar opciones de línea de comandos
while getopts ":d:f:" opt; do
  case $opt in
    d)
      directorio="$OPTARG"
      ;;
    f)
      archivo="$OPTARG"
      ;;
    \?)
      echo "Opción inválida: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "La opción -$OPTARG requiere un argumento." >&2
      exit 1
      ;;
  esac
done

# Si no se proporciona el nombre del archivo, mostrar mensaje de error
if [ -z "$archivo" ]; then
  echo "Debes proporcionar el nombre del archivo con la opción -f."
  exit 1
fi

# Si se proporciona el directorio, verificar si existe
if [ -n "$directorio" ]; then
  if [ ! -d "$directorio" ]; then
    echo "El directorio '$directorio' no existe."
    exit 1
  fi
else
  directorio="$directorio_actual"
fi

# Buscar el archivo en el directorio
resultado=$(find "$directorio" -type f -name "$archivo")

# Verificar si se encontró el archivo
if [ -z "$resultado" ]; then
  echo "El archivo '$archivo' no se encontró en el directorio '$directorio'."
else
  echo "Se encontró el archivo '$archivo' en el siguiente directorio:"
  echo "$resultado"
fi
