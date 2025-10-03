# 📦 Gestor de Backups para MariaDB/MySQL

Este script en **Bash** permite gestionar de forma sencilla y profesional los **backups y restauraciones** de bases de datos en **MariaDB/MySQL**.  
Incluye opciones para respaldar bases completas, solo estructuras, restaurar, programar en `cron` y mantener un log detallado.

![Debian](https://img.shields.io/badge/Linux-Debian-red?logo=debian&logoColor=white)
![Sh](https://img.shields.io/badge/SH-Script-blue?logo=ssh&logoColor=white)
![Gvim](https://img.shields.io/badge/VI-Editor-orange?logo=Gvim&logoColor=white)
---
![Logo del proyecto](https://github.com/moleculax/backup-manager/blob/main/pantalla.png)


## ✨ Características

- 🔑 **Login seguro** con usuario y contraseña de MariaDB/MySQL  
- 📂 **Listado interactivo** de bases de datos disponibles  
- 🏗️ Opción de **respaldar solo estructura**  
- 📑 Opción de **backup completo** (estructura + datos + SP/funciones/eventos/triggers)  
- 🗜️ **Compresión automática** en `.sql.gz`  
- 📜 **Logs detallados** de cada operación (`backup_manager.log`)  
- 🔄 **Restauración directa** de backups desde el menú  
- ⏰ **Programación automática en cron** (ejecución diaria a las 02:00 AM)  
- 🖥️ Interfaz amigable con menús en la terminal (mejorado con [fzf](https://github.com/junegunn/fzf) si está disponible)

---


## 📥 Instalación

Clonar o copiar el script:

```bash
git clone https://github.com/tuusuario/backup-manager.git
cd backup-manager
chmod +x backup_manager.sh
./backup_manager.sh
```



