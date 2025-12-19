#!/bin/bash

# =========================================
# Script Backup MariaDB/MySQL 
# Author: Emilio J. Gomez (@moleculax)
# http://moleculaxapp.vercel.app
# =========================================

# Función para centrar texto
centrar() {
    local texto="$1"
    local cols=$(tput cols)
    local len=${#texto}
    local padding=$(( (cols - len) / 2 ))
    printf "%*s%s\n" $padding "" "$texto"
}

# Función para imprimir menú con alineación uniforme
menu_opcion() {
    local num="$1"
    local texto="$2"
    local width=50
    printf "| %-3s %-${width}s |\n" "$num)" "$texto"
}

# Función de login con validación
validar_login() {
    while true; do
        clear
        centrar "==============================================="
        centrar "             LOGIN MARIADB / MYSQL - NEUROCODE"
        centrar "==============================================="
        echo ""

        read -p " USUARIO     : " DB_USER
        read -s -p " CONTRASEÑA  : " DB_PASS
        echo ""

        export MYSQL_PWD="$DB_PASS"
        mysql -u"$DB_USER" -e "SELECT 1;" &>/dev/null
        local status=$?
        unset MYSQL_PWD

        if [ $status -eq 0 ]; then
            centrar " Login exitoso"
            sleep 1
            break
        else
            centrar " Usuario o contraseña incorrectos. Intenta nuevamente."
            sleep 2
        fi
    done
}

# Función para listar bases de datos
listar_bases() {
    export MYSQL_PWD="$DB_PASS"
    DATABASES=($(mysql -u"$DB_USER" -e "SHOW DATABASES;" -s --skip-column-names))
    unset MYSQL_PWD
}

# Función para crear backup
crear_backup() {
    local db="$1"
    local tipo="$2"
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    BACKUP_FILE="${db}_${tipo}_${TIMESTAMP}.sql"

    export MYSQL_PWD="$DB_PASS"

    if [ "$tipo" == "estructura" ]; then
        mysqldump -u"$DB_USER" --no-data "$db" > "$BACKUP_FILE"
    else
        mysqldump -u"$DB_USER" --routines --triggers --events "$db" > "$BACKUP_FILE"
    fi

    unset MYSQL_PWD

    centrar "Backup $tipo de '$db' creado: $BACKUP_FILE"
    sleep 2
}

# Función del menú principal
menu_principal() {
    while true; do
        clear
        centrar "==============================================="
        centrar "                MENÚ DE BACKUP - NEUROCODE"
        centrar "==============================================="
        echo ""
        
        # Menú alineado con bordes
        centrar "+------------------------------------------------+"
        menu_opcion "1" "Listar bases de datos"
        menu_opcion "2" "Backup estructura"
        menu_opcion "3" "Backup completo (datos + SP + funciones + triggers)"
        menu_opcion "4" "Salir / Cancelar"
        centrar "+------------------------------------------------+"
        echo ""

        read -p "Selecciona una opción [1-4]: " opcion

        case $opcion in
            1)
                listar_bases
                clear
                centrar "Bases disponibles:"
                for db in "${DATABASES[@]}"; do
                    centrar " - $db"
                done
                read -p "Presiona ENTER para continuar..."
                ;;
            2|3)
                listar_bases
                clear
                centrar "Selecciona la base de datos:"
                select db in "${DATABASES[@]}" "Cancelar"; do
                    if [[ "$db" == "Cancelar" || -z "$db" ]]; then
                        break
                    fi

                    if [ "$opcion" -eq 2 ]; then
                        crear_backup "$db" "estructura"
                    else
                        crear_backup "$db" "full"
                    fi
                    break
                done
                ;;
            4)
                centrar "Saliendo... 👋"
                sleep 1
                exit 0
                ;;
            *)
                centrar "Opción inválida"
                sleep 1
                ;;
        esac
    done
}

# ===========================
# EJECUCIÓN
# ===========================
validar_login
menu_principal
