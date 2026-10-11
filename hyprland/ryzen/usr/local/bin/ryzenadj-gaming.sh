#!/bin/bash
# RyzenAdj Gaming - Alto rendimiento SOLO conectado a corriente
/usr/local/bin/ryzenadj \
  --stapm-limit=35000 \
  --slow-limit=40000 \
  --fast-limit=45000 \
  --slow-time=60 \
  --tctl-temp=88 || { echo "ryzenadj falló (gaming)"; exit 1; }
