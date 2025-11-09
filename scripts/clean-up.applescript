#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clean Up
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Cierra las apps que no uso
# @raycast.author bruno_mollo
# @raycast.authorURL https://raycast.com/bruno_mollo

log "Clean Up"


-- Lista de aplicaciones que NO deben cerrarse
set allowedApps to {"Google Chrome", "Ghostty", "Slack", "Cursor", "Raycast"}

-- Obtener la lista de todas las aplicaciones en ejecución
tell application "System Events"
	set runningApps to name of every process whose background only is false
end tell

-- Recorrer la lista de aplicaciones en ejecución
repeat with appName in runningApps
	-- Comprobar si la aplicación actual NO está en la lista de permitidas
	if appName is not in allowedApps then
		try
			-- Intentar cerrar la aplicación
			tell application (appName as string)
				quit
			end tell
			-- Opcional: mostrar un mensaje en el registro o terminal
			log ("Cerrando: " & appName)
		on error
			-- Manejar el caso en que la aplicación no se pueda cerrar (por ejemplo, requiere guardar)
			log ("No se pudo cerrar: " & appName & ". Puede requerir interacción del usuario.")
		end try
	end if

end repeat



do shell script "defaults write com.apple.dock persistent-apps -array"
do shell script "killall dock"

log "Limpiado 🧹"

