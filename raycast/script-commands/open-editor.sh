#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Editor
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 💻
# @raycast.packageName Modos
# @raycast.description Abre IntelliJ IDEA en Java o Ghostty en Personal y Trabajo

set -euo pipefail

state_file="${XDG_STATE_HOME:-$HOME/.local/state}/raycast/mode"
mode="Personal"
if [[ -f "$state_file" ]]; then
  mode="$(<"$state_file")"
fi

if [[ "$mode" == "Java" ]]; then
  app="IntelliJ IDEA"
else
  app="Ghostty"
fi

open -a "$app"
