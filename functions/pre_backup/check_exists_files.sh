#!/bin/bash


check_exists_files() {
    log DEBUG "Call check_exists_files $*"
    local missing_files=()  # Arreglo para almacenar archivos faltantes

    # Itera sobre cada archivo pasado como parámetro
    for file in "$@"; do
        # Verifica si el archivo no existe
        if [ ! -f "$file" ]; then
            missing_files+=("$file")  # Agrega el archivo a la lista de archivos faltantes
        fi
    done

    # Verifica si hay archivos faltantes
    if [ ${#missing_files[@]} -gt 0 ]; then
        log ERROR "The following files do not exist:"
        for missing_file in "${missing_files[@]}"; do
            log ERROR "$missing_file"
        done
        exit 1
    fi
}
