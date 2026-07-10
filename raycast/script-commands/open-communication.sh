#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Abrir comunicación
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 💬
# @raycast.packageName Modos
# @raycast.description Abre Slack en Trabajo o Legcord en Personal

set -euo pipefail

state_file="${XDG_STATE_HOME:-$HOME/.local/state}/raycast/mode"
mode="Personal"
if [[ -f "$state_file" ]]; then
  mode="$(<"$state_file")"
fi

if [[ "$mode" == "Trabajo" ]]; then
  app="Slack"
else
  app="legcord"
fi

open -a "$app"
