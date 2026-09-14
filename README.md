# 🚀 Optimizador de Rendimiento para Termux

Script completo para optimizar el rendimiento general de Android usando Termux.

## ✨ Características

- 🧹 Limpieza de caché del sistema
- 🏃 Liberación de memoria RAM
- 📁 Eliminación de archivos temporales
- 🔧 Optimización de permisos del sistema
- ⚙️ Ajuste de parámetros del kernel
- 📊 Limpieza de logs del sistema
- 🌐 Optimización de configuración de red
- 📈 Información del sistema en tiempo real
- 📋 Generación de reportes de optimización

## 📋 Requisitos Previos

- **Termux** instalado en Android
- **Acceso root** (opcional pero recomendado para máxima optimización)
- **Bash** (incluido en Termux)

## 🔧 Instalación

### 1. Clonar el repositorio
```bash
git clone https://github.com/liarenatasalgado-jpg/termux-optimization.git
cd termux-optimization
```

### 2. Dar permisos de ejecución
```bash
chmod +x optimize.sh
chmod +x advanced.sh
chmod +x scheduler.sh
```

## 🚀 Uso

### Optimización Básica
```bash
bash optimize.sh
```

### Optimización Avanzada (requiere root)
```bash
sudo bash optimize.sh
# o
bash advanced.sh
```

### Programa de Optimización Automática
```bash
bash scheduler.sh
```

## 📚 Scripts Disponibles

### optimize.sh
Script principal que realiza:
- Limpieza de caché
- Liberación de RAM
- Optimización del kernel
- Generación de reportes

**Tiempo de ejecución:** 2-5 minutos

### advanced.sh
Optimizaciones avanzadas:
- Limpieza profunda del sistema
- Optimización de aplicaciones
- Ajustes de batería
- Compactación de memoria

**Tiempo de ejecución:** 5-10 minutos

### scheduler.sh
Programar optimizaciones automáticas:
- Ejecución diaria
- Ejecución semanal
- Ejecución personalizada

## 📊 Información del Sistema

El script muestra:
- Núcleos de CPU disponibles
- Versión de Android
- Modelo del dispositivo
- Espacio disponible en disco
- Memoria RAM disponible

## 📈 Mejoras de Rendimiento Esperadas

Después de ejecutar el script, deberías notar:

✅ **30-50% más de RAM disponible**
✅ **Aplicaciones se cargan más rápido**
✅ **Menos lag y stuttering**
✅ **Mejor duración de batería**
✅ **Menor consumo de datos**
✅ **Sistema más responsivo**

## ⚠️ Advertencias Importantes

⚠️ **Hacer backup** antes de usar versiones avanzadas
⚠️ **No ejecutar mientras** instala actualizaciones
⚠️ **Reinicia el dispositivo** después de la optimización
⚠️ **Se recomienda ejecutar semanalmente**
⚠️ **Ten cuidado con aplicaciones críticas**

## 📋 Interpretación de Reportes

Los reportes se guardan en:
```
$HOME/optimization_report_YYYYMMDD_HHMMSS.txt
```

Cada reporte contiene:
- Timestamp de ejecución
- Procesos realizados
- Memoria liberada
- Espacio en disco
- Errores (si los hay)

## 🛠️ Customización

Puedes editar el script para:

1. Cambiar directorio de reportes:
```bash
REPORT_FILE="/ruta/personalizada/reporte.txt"
```

2. Ajustar parámetros del kernel:
```bash
echo 20 > /proc/sys/vm/swappiness
```

3. Agregar más rutas de limpieza:
```bash
rm -rf /ruta/a/limpiar/*
```

## 📞 Troubleshooting

### El script no se ejecuta
```bash
# Verificar permisos
ls -la optimize.sh

# Dar permisos si es necesario
chmod +x optimize.sh
```

### Error de permisos
```bash
# Ejecutar como root
sudo bash optimize.sh

# O instalar sudo si no existe
apt install sudo
```

### Caché lleno nuevamente después de un tiempo
```bash
# Ejecutar el script scheduler para automatizar
bash scheduler.sh
```

## 🤝 Contribuciones

Las sugerencias y mejoras son bienvenidas. Puedes:
- Reportar bugs
- Sugerir nuevas optimizaciones
- Mejorar la documentación
- Compartir resultados

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Ver `LICENSE` para más detalles.

## 💡 Tips Adicionales

1. **Ejecuta regularmente**: Una vez a la semana para máximo rendimiento
2. **Desinstala bloatware**: Apps preinstaladas que no usas
3. **Limita procesos en background**: Ajusta en Configuración > Aplicaciones
4. **Usa un launcher ligero**: Nova Launcher o KISS Launcher
5. **Desactiva animaciones**: Configuración > Opciones de desarrollador

## 📞 Soporte

Si tienes problemas:
1. Lee el archivo TROUBLESHOOTING.md
2. Consulta los logs generados
3. Abre un issue en GitHub

---

**Hecho con ❤️ para optimizar tu Android**
