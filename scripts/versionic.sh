#!/bin/zsh

# Array de tickets
tickets=("86b6a3cve" "86b6a3k35" )

# Rama destino
target_branch="1.5.1-rc"

# Guardar rama actual para volver después
current_branch=$(git rev-parse --abbrev-ref HEAD)

# Iterar tickets
for ticket in $tickets; do
    echo "🔍 Buscando commits en dev con ticket: $ticket"

    # Cambiar a rama dev
    git checkout dev || exit 1

    # Obtener commits que contengan el ticket en el mensaje
    commits=($(git log --grep="$ticket" --pretty=format:"%H"))

    if (( ${#commits[@]} == 0 )); then
        echo "⚠️  No se encontraron commits para $ticket"
        continue
    fi

    echo "✅ Commits encontrados para $ticket:"
    print -l $commits

    # Cambiar a la rama destino
    git checkout $target_branch || exit 1

    # Cherrypick de cada commit
    for commit in $commits; do
        echo "🚀 Haciendo cherry-pick de $commit"
        git cherry-pick $commit || {
            echo "❌ Conflicto en cherry-pick de $commit. Resuélvelo y continúa con:"
            echo "   git cherry-pick --continue"
            exit 1
        }
    done
done

# Volver a la rama original
git checkout $current_branch
echo "🎉 Proceso terminado, vuelto a la rama $current_branch"
