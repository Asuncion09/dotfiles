#!/bin/bash
# RyzenAdj Power Save - Máxima duración de batería
/usr/local/bin/ryzenadj \
  --stapm-limit=15000 \
  --slow-limit=15000 \
  --fast-limit=18000 \
  --slow-time=30 \
  --tctl-temp=75 || { echo "ryzenadj falló (power-save)"; exit 1; }
