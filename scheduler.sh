#!/bin/bash

# Script Programador de Optimizaciones Automáticas
# Programa ejecuciones periódicas del optimizador

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

print_header() {
    echo -e "\n${BLUE}═══════════════════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════════════════${NC}\n"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_option() {
    echo -e "${YELLOW}$1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

# Directorio de configuración
CONFIG_DIR="$HOME/.termux-optimization"
CRON_FILE="$CONFIG_DIR/crontab.conf"

# Crear directorio de configuración si no existe
setup_config_dir() {
    if [ ! -d "$CONFIG_DIR" ]; then
        mkdir -p "$CONFIG_DIR"
        print_success "Directorio de configuración creado"
    fi
}

# Menú principal
show_menu() {
    clear
    echo -e "${BLUE}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║   PROGRAMADOR DE OPTIMIZACIÓN         ║"
    echo "║        Ejecución Automática             ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo ""
    print_option "1) Optimización DIARIA (automática)"
    print_option "2) Optimización SEMANAL (automática)"
    print_option "3) Optimización PERSONALIZADA"
    print_option "4) Ver Cronograma Actual"
    print_option "5) Cancelar Automatización"
    print_option "6) Ver Logs de Optimización"
    print_option "0) Salir"
    echo ""
    read -p "Selecciona una opción: " option
}

# Configurar optimización diaria
setup_daily() {
    print_header "Configurar Optimización Diaria"
    
    read -p "¿A qué hora ejecutar? (HH:MM, ej: 03:00): " time_input
    
    if [[ ! $time_input =~ ^[0-2][0-9]:[0-5][0-9]$ ]]; then
        print_error "Formato inválido. Usa HH:MM"
        return 1
    fi
    
    # Obtener horas y minutos
    HOUR=$(echo $time_input | cut -d: -f1)
    MIN=$(echo $time_input | cut -d: -f2)
    
    # Crear script de ejecución
    SCRIPT_FILE="$CONFIG_DIR/daily_optimize.sh"
    cat > "$SCRIPT_FILE" << 'EOF'
#!/bin/bash
bash $(dirname "$0")/../termux-optimization/optimize.sh >> $HOME/.termux-optimization/logs/daily.log 2>&1
EOF
    chmod +x "$SCRIPT_FILE"
    
    # Configurar cron
    CRON_ENTRY="$MIN $HOUR * * * $SCRIPT_FILE"
    
    # Guardar configuración
    echo "DAILY_TIME=$time_input" > "$CONFIG_DIR/daily.conf"
    
    print_success "Optimización diaria configurada para las $time_input"
    print_info "Se ejecutará automáticamente cada día"
}

# Configurar optimización semanal
setup_weekly() {
    print_header "Configurar Optimización Semanal"
    
    echo -e "\n${YELLOW}Días disponibles:${NC}"
    echo "1) Lunes    2) Martes   3) Miércoles"
    echo "4) Jueves   5) Viernes  6) Sábado"
    echo "7) Domingo"
    echo ""
    read -p "¿Qué día? (1-7): " day_input
    read -p "¿A qué hora? (HH:MM, ej: 02:00): " time_input
    
    if [[ ! $time_input =~ ^[0-2][0-9]:[0-5][0-9]$ ]]; then
        print_error "Formato inválido"
        return 1
    fi
    
    if [[ ! $day_input =~ ^[1-7]$ ]]; then
        print_error "Día inválido"
        return 1
    fi
    
    HOUR=$(echo $time_input | cut -d: -f1)
    MIN=$(echo $time_input | cut -d: -f2)
    
    DAYS=("" "Lunes" "Martes" "Miércoles" "Jueves" "Viernes" "Sábado" "Domingo")
    
    # Crear script
    SCRIPT_FILE="$CONFIG_DIR/weekly_optimize.sh"
    cat > "$SCRIPT_FILE" << 'EOF'
#!/bin/bash
bash $(dirname "$0")/../termux-optimization/advanced.sh >> $HOME/.termux-optimization/logs/weekly.log 2>&1
EOF
    chmod +x "$SCRIPT_FILE"
    
    # Guardar configuración
    echo "WEEKLY_DAY=$day_input" > "$CONFIG_DIR/weekly.conf"
    echo "WEEKLY_TIME=$time_input" >> "$CONFIG_DIR/weekly.conf"
    
    print_success "Optimización semanal configurada"
    print_info "Se ejecutará todos los ${DAYS[$day_input]} a las $time_input"
}

# Configurar personalizado
setup_custom() {
    print_header "Configuración Personalizada"
    
    echo -e "\n${YELLOW}Opciones:${NC}"
    echo "1) Cada 3 días"
    echo "2) Cada 5 días"
    echo "3) Cada 15 días (mensual)"
    echo "4) Personalizado (manual)"
    echo ""
    read -p "Selecciona: " freq_option
    
    case $freq_option in
        1)
            FREQ=3
            FREQ_NAME="3 días"
            ;;
        2)
            FREQ=5
            FREQ_NAME="5 días"
            ;;
        3)
            FREQ=15
            FREQ_NAME="15 días"
            ;;
        4)
            read -p "¿Cada cuántos días?: " FREQ
            FREQ_NAME="$FREQ días"
            ;;
        *)
            print_error "Opción inválida"
            return 1
            ;;
    esac
    
    read -p "¿A qué hora? (HH:MM): " time_input
    
    # Guardar configuración
    echo "CUSTOM_FREQ=$FREQ" > "$CONFIG_DIR/custom.conf"
    echo "CUSTOM_TIME=$time_input" >> "$CONFIG_DIR/custom.conf"
    
    print_success "Optimización personalizada configurada"
    print_info "Se ejecutará cada $FREQ_NAME a las $time_input"
}

# Ver cronograma actual
view_schedule() {
    print_header "Cronograma Actual"
    
    if [ ! -f "$CONFIG_DIR/daily.conf" ] && [ ! -f "$CONFIG_DIR/weekly.conf" ] && [ ! -f "$CONFIG_DIR/custom.conf" ]; then
        print_info "No hay optimizaciones programadas"
        return
    fi
    
    if [ -f "$CONFIG_DIR/daily.conf" ]; then
        source "$CONFIG_DIR/daily.conf"
        echo -e "${GREEN}📅 OPTIMIZACIÓN DIARIA${NC}"
        echo "   Hora: $DAILY_TIME"
        echo ""
    fi
    
    if [ -f "$CONFIG_DIR/weekly.conf" ]; then
        source "$CONFIG_DIR/weekly.conf"
        DAYS=("" "Lunes" "Martes" "Miércoles" "Jueves" "Viernes" "Sábado" "Domingo")
        echo -e "${GREEN}📅 OPTIMIZACIÓN SEMANAL${NC}"
        echo "   Día: ${DAYS[$WEEKLY_DAY]}"
        echo "   Hora: $WEEKLY_TIME"
        echo ""
    fi
    
    if [ -f "$CONFIG_DIR/custom.conf" ]; then
        source "$CONFIG_DIR/custom.conf"
        echo -e "${GREEN}📅 OPTIMIZACIÓN PERSONALIZADA${NC}"
        echo "   Frecuencia: Cada $CUSTOM_FREQ días"
        echo "   Hora: $CUSTOM_TIME"
        echo ""
    fi
}

# Cancelar automatización
cancel_automation() {
    print_header "Cancelar Automatización"
    
    read -p "¿Estás seguro? (s/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Ss]$ ]]; then
        rm -f "$CONFIG_DIR"/*.conf
        rm -f "$CONFIG_DIR"/*.sh
        print_success "Automatización cancelada"
    fi
}

# Ver logs
view_logs() {
    print_header "Logs de Optimización"
    
    LOG_DIR="$CONFIG_DIR/logs"
    
    if [ ! -d "$LOG_DIR" ]; then
        print_info "No hay logs disponibles aún"
        return
    fi
    
    echo -e "${YELLOW}Archivos de log disponibles:\n${NC}"
    ls -lh "$LOG_DIR" 2>/dev/null || print_info "Carpeta de logs vacía"
    
    echo -e "\n${YELLOW}¿Ver último log? (s/n):${NC}"
    read -n 1 -r
    echo
    if [[ $REPLY =~ ^[Ss]$ ]]; then
        LATEST_LOG=$(ls -t "$LOG_DIR"/*.log 2>/dev/null | head -1)
        if [ -n "$LATEST_LOG" ]; then
            tail -50 "$LATEST_LOG"
        fi
    fi
}

# Bucle principal
main() {
    setup_config_dir
    
    while true; do
        show_menu
        
        case $option in
            1)
                setup_daily
                ;;
            2)
                setup_weekly
                ;;
            3)
                setup_custom
                ;;
            4)
                view_schedule
                ;;
            5)
                cancel_automation
                ;;
            6)
                view_logs
                ;;
            0)
                echo -e "${BLUE}¡Hasta luego!${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}Opción inválida${NC}"
                ;;
        esac
        
        echo ""
        read -p "Presiona Enter para continuar..."
    done
}

# Ejecutar
main
