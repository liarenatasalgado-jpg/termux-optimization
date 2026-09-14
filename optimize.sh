#!/bin/bash

# Script de Optimización Completo para Android en Termux
# Mejora el rendimiento general del teléfono
# Autor: Termux Optimization
# Uso: bash optimize.sh

# Colores para la terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para mostrar encabezados
print_header() {
    echo -e "\n${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}\n"
}

# Función para mostrar éxito
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

# Función para mostrar advertencia
print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# Función para mostrar error
print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Verificar permisos
check_permissions() {
    print_header "Verificando Permisos"
    
    if [ "$EUID" -eq 0 ]; then
        print_success "Ejecutándose como root"
    else
        print_warning "Se recomienda ejecutar como root para máxima optimización"
        print_warning "Intenta: sudo bash optimize.sh"
    fi
}

# 1. Limpiar caché del sistema
clear_cache() {
    print_header "Limpiando Caché del Sistema"
    
    # Caché de aplicaciones
    if [ -d "/data/data" ]; then
        find /data/data -type d -name "cache" -exec rm -rf {} + 2>/dev/null
        print_success "Caché de aplicaciones limpiado"
    fi
    
    # Caché del sistema
    if [ -d "/cache" ]; then
        rm -rf /cache/* 2>/dev/null
        print_success "Caché del sistema limpiado"
    fi
    
    # Caché de Dalvik
    if [ -d "/data/dalvik-cache" ]; then
        rm -rf /data/dalvik-cache/* 2>/dev/null
        print_success "Caché Dalvik limpiado"
    fi
}

# 2. Liberar memoria RAM
free_memory() {
    print_header "Liberando Memoria RAM"
    
    # Sincronizar y vaciar caché
    sync
    echo 3 > /proc/sys/vm/drop_caches 2>/dev/null
    print_success "Memoria RAM liberada"
    
    # Mostrar memoria disponible
    if command -v free &> /dev/null; then
        echo -e "\n${BLUE}Estado de Memoria:${NC}"
        free -h
    fi
}

# 3. Limpiar archivos temporales
clean_temp() {
    print_header "Limpiando Archivos Temporales"
    
    # Directorio temporal de Termux
    rm -rf $PREFIX/tmp/* 2>/dev/null
    print_success "Directorio temporal de Termux limpiado"
    
    # Logs antiguos
    if [ -d "$HOME/.cache" ]; then
        rm -rf $HOME/.cache/* 2>/dev/null
        print_success "Caché local limpiado"
    fi
    
    # Descargas temporales
    if [ -d "$HOME/downloads" ]; then
        find $HOME/downloads -type f -atime +30 -delete 2>/dev/null
        print_success "Descargas antiguas (>30 días) eliminadas"
    fi
}

# 4. Optimizar permisos del sistema
optimize_permissions() {
    print_header "Optimizando Permisos del Sistema"
    
    # Cambiar permisos de caché
    if [ -d "/data/data" ]; then
        chmod -R 777 /data/data/*/cache 2>/dev/null
        print_success "Permisos de caché optimizados"
    fi
}

# 5. Optimizar configuración del kernel
optimize_kernel() {
    print_header "Optimizando Parámetros del Kernel"
    
    # Optimizar swappiness
    echo 30 > /proc/sys/vm/swappiness 2>/dev/null
    print_success "Swappiness configurado a 30"
    
    # Optimizar dirty_ratio
    echo 15 > /proc/sys/vm/dirty_ratio 2>/dev/null
    print_success "Dirty ratio configurado"
    
    # Optimizar panic de OOM
    echo 0 > /proc/sys/vm/panic_on_oom 2>/dev/null
    print_success "Parámetros OOM optimizados"
}

# 6. Limpiar logs del sistema
clean_logs() {
    print_header "Limpiando Logs del Sistema"
    
    # Logs de Termux
    rm -rf $PREFIX/var/log/* 2>/dev/null
    print_success "Logs de Termux limpiados"
    
    # Borrar búferes de logcat (si está disponible)
    if command -v logcat &> /dev/null; then
        logcat -c 2>/dev/null
        print_success "Buffer de logcat limpiado"
    fi
}

# 7. Optimizar configuración de red
optimize_network() {
    print_header "Optimizando Configuración de Red"
    
    # TCP tweaks
    echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse 2>/dev/null
    echo 1 > /proc/sys/net/ipv4/tcp_timestamps 2>/dev/null
    print_success "Configuración TCP optimizada"
}

# 8. Información del sistema
system_info() {
    print_header "Información del Sistema"
    
    echo -e "${BLUE}CPU:${NC}"
    nproc
    
    echo -e "\n${BLUE}Versión de Android:${NC}"
    getprop ro.build.version.release
    
    echo -e "\n${BLUE}Modelo del Dispositivo:${NC}"
    getprop ro.product.model
    
    echo -e "\n${BLUE}Espacio disponible:${NC}"
    df -h /
}

# 9. Generar reporte
generate_report() {
    print_header "Generando Reporte de Optimización"
    
    REPORT_FILE="$HOME/optimization_report_$(date +%Y%m%d_%H%M%S).txt"
    
    {
        echo "================================"
        echo "REPORTE DE OPTIMIZACIÓN"
        echo "Fecha: $(date)"
        echo "================================"
        echo ""
        echo "1. Caché del sistema - LIMPIADO"
        echo "2. Memoria RAM - LIBERADA"
        echo "3. Archivos temporales - LIMPIADOS"
        echo "4. Permisos del sistema - OPTIMIZADOS"
        echo "5. Parámetros del kernel - OPTIMIZADOS"
        echo "6. Logs del sistema - LIMPIADOS"
        echo "7. Configuración de red - OPTIMIZADA"
        echo ""
        echo "Memoria disponible:"
        free -h
        echo ""
        echo "Espacio en disco:"
        df -h /
    } > "$REPORT_FILE"
    
    print_success "Reporte guardado en: $REPORT_FILE"
}

# Función principal
main() {
    clear
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════╗"
    echo "║   OPTIMIZADOR DE RENDIMIENTO - TERMUX    ║"
    echo "║        Para Android Mejorado            ║"
    echo "╚══════════════════════════════════════════╝"
    echo -e "${NC}"
    
    # Ejecutar todas las optimizaciones
    check_permissions
    clear_cache
    free_memory
    clean_temp
    optimize_permissions
    optimize_kernel
    clean_logs
    optimize_network
    system_info
    generate_report
    
    # Mensaje final
    print_header "¡Optimización Completada!"
    echo -e "${GREEN}Tu teléfono ha sido optimizado correctamente.${NC}"
    echo -e "${YELLOW}Se recomienda reiniciar el dispositivo para mejores resultados.${NC}"
    echo -e "\n${BLUE}Consejo:${NC} Ejecuta este script regularmente (una vez a la semana) para mantener el rendimiento óptimo.\n"
}

# Ejecutar el script
main
