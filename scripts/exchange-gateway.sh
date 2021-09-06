#!/usr/bin/env bash

GATEWAYS=("lc72635" "testrack-delta1" "testrack-delta2")
SELECTED_HOST=$( echo "${GATEWAYS[@]}" | tr " ", "\n"  | rofi -dmenu -p "Select Host")

[ -n "$SELECTED_HOST" ] && ssh -D 1337 -q -C -N -f "$SELECTED_HOST"
[ $? -ne 0 ] && echo "failed to create ssh gateway" || echo "success"
