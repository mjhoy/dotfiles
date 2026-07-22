#!/usr/bin/env bash

input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

BAR_WIDTH=10
FILLED=$((PCT * BAR_WIDTH / 100))
BAR=$(printf "%${FILLED}s" | tr ' ' '▓')$(printf "%$((BAR_WIDTH - FILLED))s" | tr ' ' '░')

echo "[$MODEL] $BAR $PCT%"
