# 📦 Guía de Instalación

## Instalación Rápida

### Paso 1: Descargar el Repositorio

```bash
git clone https://github.com/liarenatasalgado-jpg/termux-optimization.git
cd termux-optimization
```

### Paso 2: Dar Permisos de Ejecución

```bash
chmod +x optimize.sh
chmod +x advanced.sh
chmod +x scheduler.sh
```

### Paso 3: Instalar Dependencias (Opcional)

```bash
apt update
apt install -y curl git
```

## Variantes de Instalación

### Opción A: Instalación Manual

1. Abre Termux
2. Descarga los archivos manualmente
3. Navega a la carpeta del proyecto
4. Ejecuta: `bash optimize.sh`

### Opción B: Instalación con Git

```bash
# Clonar
git clone https://github.com/liarenatasalgado-jpg/termux-optimization.git

# Entrar a la carpeta
cd termux-optimization

# Hacer ejecutables
chmod +x *.sh

# Crear enlace simbólico (opcional)
sudo ln -s $(pwd)/optimize.sh /usr/local/bin/optimize
```

### Opción C: Crear Alias

Agrega esto a `~/.bashrc`:

```bash
alias optimize='bash $HOME/termux-optimization/optimize.sh'
alias optimize-advanced='bash $HOME/termux-optimization/advanced.sh'
alias optimize-schedule='bash $HOME/termux-optimization/scheduler.sh'
```

Luego ejecuta:
```bash
source ~/.bashrc
```

Ya puedes usar:
```bash
optimize
```

## Verificación de Instalación

```bash
# Verificar que los archivos existen
ls -la optimize.sh advanced.sh scheduler.sh

# Verificar permisos
file optimize.sh
```

## Primera Ejecución

### Ejecutar Optimización Básica

```bash
bash optimize.sh
```

### Ejecutar Optimización Avanzada (necesita root)

```bash
sudo bash optimize.sh
# O
bash advanced.sh
```

### Configurar Automatización

```bash
bash scheduler.sh
```

## Solucion de Problemas

### Error: "Permiso denegado"

```bash
chmod +x optimize.sh
bash optimize.sh
```

### Error: "git: command not found"

```bash
apt install -y git
```

### Error: "sudo: command not found"

```bash
apt install -y sudo
```

### El script no se ejecuta

1. Verifica que Bash está instalado:
```bash
which bash
```

2. Verifica el código del archivo:
```bash
head -1 optimize.sh
```

Debería mostrar: `#!/bin/bash`

## Configuración Posterior a la Instalación

### 1. Crear Carpeta de Reportes

```bash
mkdir -p ~/optimization_reports
```

### 2. Configurar Permisos de Root

```bash
sudo visudo
```

Añade esta línea al final:
```
%sudo ALL=(ALL) NOPASSWD: /path/to/optimize.sh
```

### 3. Configurar Cron (Automatización)

```bash
crontab -e
```

Ejemplos:

- **Diaria a las 3 AM:**
```
0 3 * * * bash /ruta/a/optimize.sh
```

- **Semanal (Domingo a las 2 AM):**
```
0 2 * * 0 bash /ruta/a/optimize.sh
```

- **Cada 3 días:**
```
0 2 */3 * * bash /ruta/a/optimize.sh
```

## Actualizar la Instalación

```bash
cd termux-optimization
git pull origin main
```

## Desinstalar

```bash
# Eliminar directorio
rm -rf ~/termux-optimization

# Eliminar alias (si existen)
# Edita ~/.bashrc y elimina las líneas que agregaste

# Eliminar trabajos cron
crontab -e  # y elimina las líneas correspondientes
```

## Requisitos Mínimos

✅ **Android 5.0+**  
✅ **Termux instalado**  
✅ **Bash (incluido en Termux)**  
✅ **Almacenamiento: 10 MB libre**  
✅ **RAM: 512 MB mínimo**

## Requisitos Recomendados

✨ **Android 8.0+**  
✨ **Termux con acceso root**  
✨ **Conexión WiFi para cron**  
✨ **Almacenamiento: 100 MB libre**  
✨ **RAM: 1 GB mínimo**

## Soporte Técnico

Si tienes problemas:

1. Consulta TROUBLESHOOTING.md
2. Revisa los logs en `~/.termux-optimization/logs/`
3. Abre un issue en GitHub

---

**¡Listo para optimizar tu Android!** 🚀
