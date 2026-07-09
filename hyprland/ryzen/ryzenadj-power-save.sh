#!/bin/bash
# RyzenAdj Power Save Profile - Máxima duración de batería
/usr/local/bin/ryzenadj \
  --stapm-limit=15000 \
  --fast-limit=18000 \
  --slow-limit=12000 \
  --tctl-temp=70
