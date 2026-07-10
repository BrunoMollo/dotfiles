# Dotfiles

## Clone repo
```bash
git clone https://github.com/BrunoMollo/dotfiles 
cd dotfiles
```


## Install dependencies
```bash
sh ./brew.install.sh
```


## Add symlinks
```bash
stow .
```

## Raycast

Agregar `~/dotfiles/raycast/script-commands` como Script Commands Directory en
Raycast (`Settings > Extensions > Script Commands`). Después, asignar estos
hotkeys desde esa misma pantalla:

- `⌥ 4`: **Abrir orquestador de agentes**
- `⌥ 3`: **Abrir comunicación**

El comando **Cambiar modo Personal/Trabajo** queda disponible en el launcher.
El modo inicial es `Personal` y la selección se persiste entre reinicios.
