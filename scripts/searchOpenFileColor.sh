#!/bin/bash

# Inicializar variables con valores predeterminados
directorio_actual="$(pwd)"
directorio=""
nombre_archivo=""

# Definir extensiones permitidas para Neovim (puedes personalizar esto)
extensiones_validas=("txt" "md" "sh" "js" "py" "c" "cpp" "java" "html" "css" "json")

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
archivos_coincidentes=($(find "$directorio" -type f | grep "$nombre_archivo"))

# Verificar si se encontraron archivos
if [ ${#archivos_coincidentes[@]} -eq 0 ]; then
  echo "No se encontraron archivos que coincidan con '$nombre_archivo' en el directorio '$directorio'."
else
  echo "Se encontraron los siguientes archivos que coinciden con '$nombre_archivo' en el directorio '$directorio':"
  for ((i=0; i<${#archivos_coincidentes[@]}; i++)); do
    archivo="${archivos_coincidentes[i]}"
    extension="${archivo##*.}"

    # Comprobar si la extensión es válida para Neovim
    if [[ " ${extensiones_validas[@]} " =~ " $extension " ]]; then
      # Colorear en verde los archivos con extensiones válidas
      echo -e "\e[32m$((i+1)). $archivo\e[0m"
    else
      echo "$((i+1)). $archivo"
    fi
  done

  # Solicitar al usuario que elija el número de ocurrencia para abrir con Neovim
  read -p "Seleccione el número de ocurrencia para abrir con Neovim: " opcion

  if [[ $opcion =~ ^[0-9]+$ && $opcion -gt 0 && $opcion -le ${#archivos_coincidentes[@]} ]]; then
    archivo_seleccionado="${archivos_coincidentes[opcion-1]}"
    ruta_completa="$(realpath "$archivo_seleccionado")"

    # Abrir el archivo con Neovim
    nvim "$ruta_completa"
  else
    echo "Opción inválida. El número de ocurrencia no es válido."
    exit 1
  fi
fi
