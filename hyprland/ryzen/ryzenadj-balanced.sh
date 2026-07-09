#!/bin/bash
# RyzenAdj Balanced Profile - Buen rendimiento sin tanto calor
/usr/local/bin/ryzenadj \
  --stapm-limit=28000 \
  --fast-limit=32000 \
  --slow-limit=25000 \
  --tctl-temp=80
