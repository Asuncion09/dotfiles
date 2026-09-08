#!/usr/bin/env bash
# Evitar instancias duplicadas en segundo plano
SCRIPT_NAME=$(basename "$0")
if pidof -x -o $$ "$SCRIPT_NAME" > /dev/null; then
    exit 0
fi

# Configuración de umbrales
LOW_BATTERY=25
CRITICAL_BATTERY=15

# Archivos temporales para evitar spam de notificaciones
NOTIF_LOW="/tmp/battery_low_notif"
NOTIF_CRIT="/tmp/battery_crit_notif"
NOTIF_FULL="/tmp/battery_full_notif"

# Rutas de sonidos en Fedora (usando los temas de sonidos estándar en /usr/share/sounds)
# Asegúrate de que existan o reemplázalos por tus propios archivos .ogg / .wav
SOUND_LOW="/usr/share/sounds/freedesktop/stereo/dialog-warning.oga"
SOUND_CRIT="/usr/share/sounds/freedesktop/stereo/dialog-error.oga"
SOUND_FULL="/usr/share/sounds/freedesktop/stereo/complete.oga"

while true; do
    # Obtener el porcentaje actual y el estado (Charging, Discharging, Full)
    BATTERY_LEVEL=$(acpi -b 2>/dev/null | grep -P -o '[0-9]+(?=%)' | head -n 1)
    BATTERY_STATUS=$(acpi -b 2>/dev/null | grep -o 'Charging\|Discharging\|Full' | head -n 1)

    if [ -z "$BATTERY_LEVEL" ] || [ -z "$BATTERY_STATUS" ]; then
        sleep 60
        continue
    fi

    if [ "$BATTERY_STATUS" = "Discharging" ]; then
        # Si se está descargando, reseteamos la bandera de carga completa
        rm -f "$NOTIF_FULL"
        
        # Caso 1: Batería Crítica
        if [ "$BATTERY_LEVEL" -le "$CRITICAL_BATTERY" ]; then
            if [ ! -f "$NOTIF_CRIT" ]; then
                notify-send -u critical "🔋 BATERÍA CRÍTICA" "El equipo se apagará pronto. Conecta el cargador inmediatamente ($BATTERY_LEVEL%)."
                [ -f "$SOUND_CRIT" ] && paplay "$SOUND_CRIT" &
                touch "$NOTIF_CRIT"
            fi
        
        # Caso 2: Batería Baja
        elif [ "$BATTERY_LEVEL" -le "$LOW_BATTERY" ]; then
            if [ ! -f "$NOTIF_LOW" ]; then
                notify-send -u normal "⚠️ Batería Baja" "Te queda el $BATTERY_LEVEL% de energía."
                [ -f "$SOUND_LOW" ] && paplay "$SOUND_LOW" &
                touch "$NOTIF_LOW"
            fi
        fi

    elif [ "$BATTERY_STATUS" = "Charging" ]; then
        # Si se está cargando, reseteamos las banderas de batería baja/crítica
        rm -f "$NOTIF_LOW" "$NOTIF_CRIT"

        # Caso 3: Llegó al 100% pero el estado de ACPI aún figura como 'Charging'
        if [ "$BATTERY_LEVEL" -ge 100 ]; then
            if [ ! -f "$NOTIF_FULL" ]; then
                notify-send -u normal "⚡ Carga Completa" "La batería está al 100%. Ya puedes desconectar el cargador."
                [ -f "$SOUND_FULL" ] && paplay "$SOUND_FULL" &
                touch "$NOTIF_FULL"
            fi
        fi

    elif [ "$BATTERY_STATUS" = "Full" ]; then
        # Caso 4: El sistema reporta explícitamente el estado como cargado por completo
        rm -f "$NOTIF_LOW" "$NOTIF_CRIT"
        if [ ! -f "$NOTIF_FULL" ]; then
            notify-send -u normal "⚡ Carga Completa" "La batería está totalmente cargada. Ya puedes desconectar el cargador."
            [ -f "$SOUND_FULL" ] && paplay "$SOUND_FULL" &
            touch "$NOTIF_FULL"
        fi
    fi

    # Esperar 60 segundos antes de volver a comprobar
    sleep 60
done
