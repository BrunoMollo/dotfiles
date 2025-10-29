#!/bin/bash
#
# este script permite hacer un bisect en funcion si un comando devuelve un error o no.
#


# Inicializar variables
CMD=""
GOOD=""
BAD=""

# Leer flags tipo --cmd, --good, --bad
while [[ $# -gt 0 ]]; do
  case "$1" in
    --cmd)
      CMD="$2"
      shift 2
      ;;
    --good)
      GOOD="$2"
      shift 2
      ;;
    --bad)
      BAD="$2"
      shift 2
      ;;
    -*|--*)
      echo "❌ Opción desconocida: $1"
      exit 1
      ;;
    *)
      shift
      ;;
  esac
done

# Validar parámetros requeridos
if [ -z "$CMD" ] || [ -z "$GOOD" ] || [ -z "$BAD" ]; then
  echo "❌ Error: faltan parámetros requeridos."
  echo "Uso: $0 --cmd '<comando>' --good <commit> --bad <commit>"
  exit 1
fi

# Mostrar valores leídos
echo "CMD: $CMD"
echo "GOOD: $GOOD"
echo "BAD: $BAD"


git bisect start
git bisect good $GOOD
git bisect bad $BAD 

while true; do
    if [ "$(git bisect log | grep "first bad commit" | wc -l)" -ne 0 ]; then
        echo "✅ Llegaste al commit final del bisect"
        exit 0
    else
        echo "🔄 Todavía estás en el proceso de bisect"
    fi

    err=$($CMD 2>&1 >/dev/null)
    echo "Error: $err"

    if [ -n "$err" ]; then
        git bisect good
    else
        git bisect bad
    fi
done

