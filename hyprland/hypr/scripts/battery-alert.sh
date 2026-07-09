#!/usr/bin/env bash

# Configuración de umbrales
LOW_BATTERY=25
CRITICAL_BATTERY=15

# Archivos temporales para evitar spam de notificaciones
NOTIF_LOW="/tmp/battery_low_notif"
NOTIF_CRIT="/tmp/battery_crit_notif"
NOTIF_FULL="/tmp/battery_full_notif"

# Rutas de sonidos por defecto en Fedora
SOUND_LOW=$(find /nix/store -name 'message.oga' 2>/dev/null | head -1)
SOUND_CRIT=$(find /nix/store -name 'suspend-error.oga' 2>/dev/null | head -1)
SOUND_FULL=$(find /nix/store -name 'complete.oga' 2>/dev/null | head -1)

while true; do
    # Obtener el porcentaje actual y el estado (Charging, Discharging, Full)
    BATTERY_LEVEL=$(acpi -b | grep -P -o '[0-9]+(?=%)' | head -n 1)
    BATTERY_STATUS=$(acpi -b | grep -o 'Charging\|Discharging\|Full' | head -n 1)

    if [ "$BATTERY_STATUS" = "Discharging" ]; then
        # Si se está descargando, reseteamos la bandera de carga completa
        rm -f "$NOTIF_FULL"
        
        # Caso 1: Batería Crítica (10% o menos)
        if [ "$BATTERY_LEVEL" -le "$CRITICAL_BATTERY" ]; then
            if [ ! -f "$NOTIF_CRIT" ]; then
                notify-send -u critical "🔋 BATERÍA CRÍTICA" "El equipo se apagará pronto. Conecta el cargador inmediatamente ($BATTERY_LEVEL%)."
                paplay "$SOUND_CRIT" &
                touch "$NOTIF_CRIT"
            fi
        
        # Caso 2: Batería Baja (20% o menos)
        elif [ "$BATTERY_LEVEL" -le "$LOW_BATTERY" ]; then
            if [ ! -f "$NOTIF_LOW" ]; then
                notify-send -u normal "⚠️ Batería Baja" "Te queda el $BATTERY_LEVEL% de energía."
                paplay "$SOUND_LOW" &
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
                paplay "$SOUND_FULL" &
                touch "$NOTIF_FULL"
            fi
        fi

    elif [ "$BATTERY_STATUS" = "Full" ]; then
        # Caso 4: El sistema reporta explícitamente el estado como cargado por completo ('Full')
        rm -f "$NOTIF_LOW" "$NOTIF_CRIT"
        if [ ! -f "$NOTIF_FULL" ]; then
            notify-send -u normal "⚡ Carga Completa" "La batería está totalmente cargada. Ya puedes desconectar el cargador."
            paplay "$SOUND_FULL" &
            touch "$NOTIF_FULL"
        fi
    fi

    # Esperar 60 segundos antes de volver a comprobar
    sleep 60
done
