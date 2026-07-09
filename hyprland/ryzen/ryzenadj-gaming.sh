#!/bin/bash
# RyzenAdj Gaming Profile - Máximo rendimiento con límite térmico seguro
/usr/local/bin/ryzenadj \
  --stapm-limit=40000 \
  --fast-limit=45000 \
  --slow-limit=40000 \
  --tctl-temp=90
