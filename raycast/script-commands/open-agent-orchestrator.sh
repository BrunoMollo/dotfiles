#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Abrir orquestador de agentes
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Modos
# @raycast.description Abre Cursor en Trabajo o T3 Code en Personal y Java

set -euo pipefail

state_file="${XDG_STATE_HOME:-$HOME/.local/state}/raycast/mode"
mode="Personal"
if [[ -f "$state_file" ]]; then
  mode="$(<"$state_file")"
fi

if [[ "$mode" == "Trabajo" ]]; then
  app="Cursor"
else
  app="T3 Code (Alpha)"
fi

open -a "$app"
