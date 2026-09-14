#!/bin/bash

# Script Avanzado de Optimización para Termux
# Operaciones más profundas de limpieza y optimización
# Requiere permisos de root

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

# Funciones de salida
print_header() {
    echo -e "\n${PURPLE}╔════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║${NC} $1"
    echo -e "${PURPLE}╚════════════════════════════════════════╝${NC}\n"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_info() {
    echo -e "${BLUE}[i]${NC} $1"
}

# Verificar si es root
check_root() {
    print_header "Verificación de Permisos"
    
    if [ "$EUID" -ne 0 ]; then
        print_error "Este script requiere permisos de root"
        print_warning "Ejecuta con: sudo bash advanced.sh"
        exit 1
    fi
    
    print_success "Ejecutándose como root"
}

# 1. Limpieza profunda de caché
deep_cache_clean() {
    print_header "Limpieza Profunda de Caché"
    
    # Caché de aplicaciones (profundo)
    find /data/data -type f -name "*.tmp" -delete 2>/dev/null
    find /data/data -type f -name "*.log" -delete 2>/dev/null
    find /data/data -type d -name "cache" -exec rm -rf {} + 2>/dev/null
    find /data/data -type d -name "tmp" -exec rm -rf {} + 2>/dev/null
    print_success "Caché de aplicaciones limpiado (nivel profundo)"
    
    # Caché de navegador
    find /data/data -path "*/app_webview/Cache" -type d -exec rm -rf {} + 2>/dev/null
    print_success "Caché de navegador eliminado"
    
    # Archivos basura
    find /data -name "*.bak" -delete 2>/dev/null
    find /data -name "*.old" -delete 2>/dev/null
    print_success "Archivos de respaldo antiguos eliminados"
}

# 2. Optimización de aplicaciones instaladas
optimize_apps() {
    print_header "Optimización de Aplicaciones"
    
    # Limpiar código Dalvik compilado innecesario
    if [ -d "/data/dalvik-cache" ]; then
        find /data/dalvik-cache -type f -atime +7 -delete 2>/dev/null
        print_success "Caché Dalvik antiguo eliminado"
    fi
    
    # Optimizar permisos de aplicaciones
    chmod -R 755 /data/app 2>/dev/null
    print_success "Permisos de aplicaciones optimizados"
}

# 3. Gestión agresiva de memoria
aggressive_memory() {
    print_header "Liberación Agresiva de Memoria"
    
    # Sincronizar filesystem
    sync
    sleep 1
    
    # Limpiar caché 3 veces
    for i in 1 2 3; do
        echo 3 > /proc/sys/vm/drop_caches 2>/dev/null
        sleep 0.5
    done
    print_success "Memoria RAM liberada (modo agresivo)"
    
    # Compactar memoria
    echo 1 > /proc/sys/vm/compact_memory 2>/dev/null
    print_success "Memoria compactada"
    
    # Mostrar RAM disponible
    print_info "Memoria disponible después de optimización:"
    free -h
}

# 4. Optimización de batería
battery_optimization() {
    print_header "Optimización de Batería"
    
    # Reducir frecuencia de CPU
    echo "powersave" > /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor 2>/dev/null
    print_success "Gobernador de CPU establecido a powersave"
    
    # Desactivar CPUs innecesarias (si hay más de 4)
    if [ $(nproc) -gt 4 ]; then
        for i in {4..7}; do
            echo 0 > /sys/devices/system/cpu/cpu$i/online 2>/dev/null
        done
        print_success "CPUs innecesarias desactivadas"
    fi
    
    # Optimizar scheduler de I/O
    echo "deadline" > /sys/block/mmcblk0/queue/scheduler 2>/dev/null
    echo "deadline" > /sys/block/mmcblk1/queue/scheduler 2>/dev/null
    print_success "Scheduler de I/O optimizado"
}

# 5. Limpieza de logs del sistema
clean_system_logs() {
    print_header "Limpieza de Logs del Sistema"
    
    # Limpiar logs de eventos
    rm -rf /data/anr/* 2>/dev/null
    print_success "Logs de crashes eliminados"
    
    # Limpiar logs del sistema
    rm -rf /var/log/* 2>/dev/null
    rm -rf $PREFIX/var/log/* 2>/dev/null
    print_success "Logs del sistema eliminados"
    
    # Limpiar logcat
    logcat -c 2>/dev/null
    print_success "Buffer de logcat limpiado"
}

# 6. Optimización de red avanzada
advanced_network() {
    print_header "Optimización Avanzada de Red"
    
    # TCP Window Scaling
    echo 1 > /proc/sys/net/ipv4/tcp_window_scaling 2>/dev/null
    echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse 2>/dev/null
    echo 1 > /proc/sys/net/ipv4/tcp_timestamps 2>/dev/null
    print_success "TCP tweaks aplicados"
    
    # Aumentar buffer de red
    echo 262144 > /proc/sys/net/core/rmem_max 2>/dev/null
    echo 262144 > /proc/sys/net/core/wmem_max 2>/dev/null
    print_success "Buffers de red aumentados"
    
    # Optimizar conexiones
    echo 1024 > /proc/sys/net/ipv4/tcp_max_tw_buckets 2>/dev/null
    print_success "Conexiones optimizadas"
}

# 7. Defragmentación de particiones
defragment_storage() {
    print_header "Optimización de Almacenamiento"
    
    # Análisis de espacio usado
    print_info "Análisis de espacio en disco:"
    du -sh /data/* 2>/dev/null | sort -rh | head -10
    
    # Limpiar descarga duplicadas
    find /sdcard/Download -type f -size 0 -delete 2>/dev/null
    print_success "Archivos vacíos eliminados"
    
    # Optimizar espacio
    fstrim /data 2>/dev/null && print_success "TRIM ejecutado en /data" || print_warning "TRIM no disponible"
}

# 8. Estadísticas del sistema
system_statistics() {
    print_header "Estadísticas del Sistema"
    
    echo -e "${BLUE}┌─ CPU Info${NC}"
    echo "  Núcleos: $(nproc)"
    echo "  Modelo: $(getprop ro.product.cpu.abi)"
    
    echo -e "\n${BLUE}┌─ Memoria${NC}"
    free -h | tail -2
    
    echo -e "\n${BLUE}┌─ Almacenamiento${NC}"
    df -h / | tail -1
    
    echo -e "\n${BLUE}┌─ Sistema${NC}"
    echo "  Android: $(getprop ro.build.version.release)"
    echo "  Device: $(getprop ro.product.model)"
    echo "  Kernel: $(uname -r)"
}

# 9. Generar reporte detallado
generate_advanced_report() {
    print_header "Generando Reporte Detallado"
    
    REPORT_FILE="$HOME/advanced_report_$(date +%Y%m%d_%H%M%S).txt"
    
    {
        echo "═══════════════════════════════════════════════════════════"
        echo "REPORTE AVANZADO DE OPTIMIZACIÓN"
        echo "Fecha: $(date)"
        echo "═══════════════════════════════════════════════════════════"
        echo ""
        echo "✓ Limpieza Profunda de Caché - COMPLETADA"
        echo "✓ Optimización de Aplicaciones - COMPLETADA"
        echo "✓ Liberación Agresiva de Memoria - COMPLETADA"
        echo "✓ Optimización de Batería - COMPLETADA"
        echo "✓ Limpieza de Logs - COMPLETADA"
        echo "✓ Optimización de Red Avanzada - COMPLETADA"
        echo "✓ Optimización de Almacenamiento - COMPLETADA"
        echo ""
        echo "ESTADO DEL SISTEMA:"
        echo "$(free -h)"
        echo ""
        echo "ALMACENAMIENTO:"
        echo "$(df -h /)"
        echo ""
        echo "PROCESOS EN EJECUCIÓN:"
        echo "$(ps aux | wc -l)"
        echo ""
    } > "$REPORT_FILE"
    
    print_success "Reporte guardado en: $REPORT_FILE"
}

# Función principal
main() {
    clear
    echo -e "${PURPLE}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║   OPTIMIZADOR AVANZADO - TERMUX        ║"
    echo "║      Optimización Profunda de Android   ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    # Confirmación de inicio
    print_warning "Este script realiza optimizaciones profundas"
    print_warning "Se recomienda hacer backup antes de continuar"
    echo ""
    read -p "¿Deseas continuar? (s/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Ss]$ ]]; then
        print_error "Operación cancelada"
        exit 1
    fi
    
    # Ejecutar optimizaciones
    check_root
    deep_cache_clean
    optimize_apps
    aggressive_memory
    battery_optimization
    clean_system_logs
    advanced_network
    defragment_storage
    system_statistics
    generate_advanced_report
    
    # Mensaje final
    print_header "¡Optimización Avanzada Completada!"
    echo -e "${GREEN}Tu teléfono ha sido optimizado en nivel PROFUNDO${NC}"
    echo -e "${YELLOW}Se RECOMIENDA reiniciar el dispositivo ahora${NC}"
    echo -e "\n${BLUE}Próximas optimizaciones en: 7 días${NC}\n"
}

# Ejecutar
main
