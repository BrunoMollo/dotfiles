#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Cambiar modo Personal/Trabajo
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🔄
# @raycast.packageName Modos
# @raycast.description Alterna entre el modo Personal y Trabajo

set -euo pipefail

state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/raycast"
state_file="$state_dir/mode"
mkdir -p "$state_dir"

current_mode="Personal"
if [[ -f "$state_file" ]]; then
  current_mode="$(<"$state_file")"
fi

if [[ "$current_mode" == "Trabajo" ]]; then
  next_mode="Personal"
else
  next_mode="Trabajo"
fi

printf '%s\n' "$next_mode" > "$state_file"
printf 'Modo activo: %s\n' "$next_mode"
