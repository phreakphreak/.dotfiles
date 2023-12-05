#!/bin/bash

# Inicializar variables con valores predeterminados
directorio_actual="$(pwd)"
nombre_archivo=""

# Procesar opciones de línea de comandos
while getopts ":d:n:" opt; do
  case $opt in
    d)
      directorio="$OPTARG"
      ;;
    n)
      nombre_archivo="$OPTARG"
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
if [ -z "$nombre_archivo" ]; then
  echo "Debes proporcionar el nombre del archivo con la opción -n."
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

# Buscar archivos que coincidan parcialmente con el nombre en el directorio
resultado=$(find "$directorio" -type f | grep "$nombre_archivo")

# Verificar si se encontraron archivos
if [ -z "$resultado" ]; then
  echo "No se encontraron archivos que coincidan con '$nombre_archivo' en el directorio '$directorio'."
else
  echo "Se encontraron los siguientes archivos que coinciden con '$nombre_archivo' en el directorio '$directorio':"
  echo "$resultado"
fi
