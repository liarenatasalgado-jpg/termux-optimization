# 🔧 Solución de Problemas

## Errores Comunes y Soluciones

### ✗ Error: "Permission denied" (Permiso denegado)

**Problema:**
```
bash: optimize.sh: Permission denied
```

**Solución:**
```bash
# Dar permisos de ejecución
chmod +x optimize.sh

# Luego ejecutar
bash optimize.sh
```

---

### ✗ Error: "command not found"

**Problema:**
```
bash: git: command not found
```

**Solución:**
```bash
# Instalar dependencias faltantes
apt update
apt install -y git
apt install -y curl
```

---

### ✗ Error: "No such file or directory"

**Problema:**
```
bash: optimize.sh: No such file or directory
```

**Solución:**
```bash
# Verificar ubicación
pwd

# Ir a la carpeta correcta
cd ~/termux-optimization

# Verificar que el archivo existe
ls -la optimize.sh

# Ejecutar
bash optimize.sh
```

---

### ✗ Error: "sudo: command not found"

**Problema:**
No puedes ejecutar con `sudo`

**Solución:**
```bash
# Instalar sudo
apt install -y sudo

# Configurar usuario como sudoer
su  # cambiar a root
usermod -aG sudo $USER

# O ejecutar directamente como root
su
bash optimize.sh
```

---

### ✗ Error: "read-only file system"

**Problema:**
```
Read-only file system
```

**Solución:**
El sistema de archivos está montado como solo lectura

```bash
# Remontar como escritura
mount -o remount,rw /

# O intentar en /data
cd /data
bash optimize.sh
```

---

### ✗ Erro: "No space left on device"

**Problema:**
```
No space left on device
```

**Solución:**
```bash
# Ver espacio disponible
df -h

# Ver carpetas grandes
du -sh /data/* | sort -rh

# Limpiar manualmente
rm -rf /data/data/*/cache/*
rm -rf /tmp/*
rm -rf ~/.cache/*

# Luego ejecutar optimización
bash optimize.sh
```

---

## Problemas de Ejecución

### ✗ El script se detiene a mitad

**Solución:**
```bash
# Ejecutar sin detener en errores
bash -x optimize.sh 2>&1 | tee debug.log

# Esto mostrará cada línea ejecutada
```

### ✗ La memoria no se libera

**Posibles causas:**
- Aplicaciones activas usando mucha memoria
- Procesos del sistema bloqueados

**Solución:**
```bash
# Cerrar todas las aplicaciones
# Luego ejecutar
sudo bash optimize.sh
```

### ✗ El teléfono se ralentiza después

**Posible causa:**
El sistema está reindexando

**Solución:**
```bash
# Esperar 10-15 minutos
# El sistema se optimizará solo

# Mientras tanto, reinicia si es posible
# Configuración > Acerca de > Forzar reinicio
```

---

## Problemas de Automatización

### ✗ Los scripts programados no se ejecutan

**Verificar cron:**
```bash
# Ver trabajos cron
crontab -l

# Editar cron
crontab -e

# Ver logs de cron
cat /var/log/cron.log
```

### ✗ Errores en los logs de automatización

**Revisar logs:**
```bash
# Ver logs recientes
tail -50 ~/.termux-optimization/logs/daily.log

# O todos
cat ~/.termux-optimization/logs/*.log
```

---

## Problemas de Compatibilidad

### ✗ El script no reconoce el dispositivo

**Verificar información del dispositivo:**
```bash
# Ver propiedades
getprop ro.product.model
getprop ro.build.version.release

# Ver procesador
getprop ro.product.cpu.abi
```

### ✗ Algunas optimizaciones no se aplican

**Causa posible:** Tu dispositivo no soporta esa optimización

**Solución:**
```bash
# Ver qué optimizaciones funcionan
bash optimize.sh 2>&1 | grep "✓"

# Las que muestren ✓ se aplicaron correctamente
```

---

## Recuperación de Datos

### ⚠️ Accidentalmente eliminé archivos importantes

**Recuperación:**
```bash
# El script NO debería eliminar tus archivos personales
# Si sucedió algo raro, verifica:

# 1. Los archivos están en backup del teléfono
# 2. Puedes recuperarlos desde:
#    - Configuración > Backup
#    - Google Drive
#    - Microsoft OneDrive

# 3. Si usas Git, puedes recuperar:
git reflog
git checkout <commit>
```

---

## Obtener Ayuda

### Información para reportar un bug

Cuando reportes un problema, incluye:

```bash
# 1. Versión de Android
getprop ro.build.version.release

# 2. Modelo del dispositivo
getprop ro.product.model

# 3. Versión de Termux
termux-info

# 4. Output del error
bash optimize.sh 2>&1 | tee error.log

# 5. Tu versión del script
head -20 optimize.sh
```

### Crear un informe de diagnóstico

```bash
# Ejecutar este comando para generar diagnóstico
{
    echo "=== SISTEMA ==="
    uname -a
    echo ""
    echo "=== ANDROID ==="
    getprop | grep -E "(model|version|device)"
    echo ""
    echo "=== MEMORIA ==="
    free -h
    echo ""
    echo "=== ALMACENAMIENTO ==="
    df -h /
    echo ""
    echo "=== TERMUX ==="
    termux-info
} > diagnostics.txt

# Compartir el archivo
cat diagnostics.txt
```

---

## Contacto y Soporte

- **GitHub Issues:** [Reportar un problema](https://github.com/liarenatasalgado-jpg/termux-optimization/issues)
- **Discusiones:** Abierto para preguntas
- **Email:** Disponible en el perfil

---

## FAQ Rápido

**P: ¿Es seguro ejecutar este script?**
R: Sí, solo limpia caché y archivos temporales. No toca datos personales.

**P: ¿Perderé mis datos?**
R: No. El script solo limpia caché, no datos de aplicaciones.

**P: ¿Necesito root?**
R: Recomendado, pero el script funciona sin root con limitaciones.

**P: ¿Con qué frecuencia ejecuto?**
R: Una vez por semana es ideal.

**P: ¿Qué versión de Android necesito?**
R: Android 5.0+ recomendado.

---

**¡Esperamos haberte ayudado!** 😊
