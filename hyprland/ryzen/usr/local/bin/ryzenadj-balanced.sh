#!/bin/bash
# RyzenAdj Balanced - Buen rendimiento sin tanto calor
/usr/local/bin/ryzenadj \
  --stapm-limit=25000 \
  --slow-limit=25000 \
  --fast-limit=32000 \
  --slow-time=30 \
  --tctl-temp=80 || { echo "ryzenadj falló (balanced)"; exit 1; }
