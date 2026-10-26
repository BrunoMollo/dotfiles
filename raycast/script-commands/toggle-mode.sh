#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Cambiar modo
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🔄
# @raycast.packageName Modos
# @raycast.description Selecciona el modo Personal, Trabajo o Java
# @raycast.argument1 {"type":"dropdown","placeholder":"Modo","optional":false,"data":[{"title":"Personal","value":"Personal"},{"title":"Trabajo","value":"Trabajo"},{"title":"Java","value":"Java"}]}

set -euo pipefail

case "${1:-}" in
  Personal|Trabajo|Java) next_mode="$1" ;;
  *) printf 'Seleccioná un modo: Personal, Trabajo o Java.\n' >&2; exit 1 ;;
esac

state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/raycast"
state_file="$state_dir/mode"
mkdir -p "$state_dir"

printf '%s\n' "$next_mode" > "$state_file"
printf 'Modo activo: %s\n' "$next_mode"
