#!/bin/bash

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para mostrar mensajes con colores
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Función para verificar si estamos en un repositorio git
check_git_repo() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        print_error "No estás en un repositorio Git."
        exit 1
    fi
}

# Función para obtener la rama actual
get_current_branch() {
    git branch --show-current
}

# Función para verificar si una rama existe
branch_exists() {
    git show-ref --verify --quiet refs/heads/"$1"
}

# Función para verificar si glab está instalado
check_glab() {
    if ! command -v glab &> /dev/null; then
        print_error "GitLab CLI (glab) no está instalado. Instálalo primero."
        print_info "Instalación: https://gitlab.com/gitlab-org/cli"
        exit 1
    fi
}

# Verificaciones iniciales
check_git_repo
check_glab

# Obtener rama actual
current_branch=$(get_current_branch)
print_info "Rama actual: $current_branch"

# Verificar que no estemos en una de las ramas base
if [[ "$current_branch" == "main" || "$current_branch" == "release" || "$current_branch" == "dev" ]]; then
    print_error "Debes estar en una rama feature, no en una rama base ($current_branch)"
    exit 1
fi

# Paso 1: Elegir rama base
echo
print_info "Selecciona la rama base para comparar con $current_branch:"
echo "1) main"
echo "2) release"  
echo "3) dev"
echo
read -p "Ingresa tu opción (1-3): " option

case $option in
    1)
        selected_branch="main"
        other_branches=("release" "dev")
        ;;
    2)
        selected_branch="release"
        other_branches=("main" "dev")
        ;;
    3)
        selected_branch="dev"
        other_branches=("main" "release")
        ;;
    *)
        print_error "Opción inválida"
        exit 1
        ;;
esac

print_success "Rama seleccionada: $selected_branch"

# Verificar que las ramas base existan
for branch in "$selected_branch" "${other_branches[@]}"; do
    if ! branch_exists "$branch"; then
        print_error "La rama '$branch' no existe"
        exit 1
    fi
done

# Actualizar ramas remotas
print_info "Actualizando referencias remotas..."
git fetch origin

# Paso 2: Mostrar commits de diferencia
echo
print_info "Commits de diferencia entre $current_branch y $selected_branch:"
commits_diff=$(git log --oneline "$selected_branch".."$current_branch" --reverse)

if [ -z "$commits_diff" ]; then
    print_warning "No hay commits de diferencia entre $current_branch y $selected_branch"
    exit 0
fi

echo "$commits_diff"
commit_hashes=($(echo "$commits_diff" | awk '{print $1}'))

echo
print_info "Se encontraron ${#commit_hashes[@]} commits para hacer cherry-pick"

# Confirmar continuación
echo
read -p "¿Deseas continuar? (y/N): " continue_choice
if [[ ! "$continue_choice" =~ ^[Yy]$ ]]; then
    print_info "Operación cancelada"
    exit 0
fi

# Paso 3: Crear nuevas ramas feature
new_branches=()
for branch in "${other_branches[@]}"; do
    new_branch="${current_branch}-${branch}"
    new_branches+=("$new_branch")
    
    print_info "Creando rama $new_branch desde $branch..."
    
    # Si la rama ya existe, preguntar si eliminarla
    if branch_exists "$new_branch"; then
        echo
        read -p "La rama $new_branch ya existe. ¿Eliminarla y recrearla? (y/N): " delete_choice
        if [[ "$delete_choice" =~ ^[Yy]$ ]]; then
            git branch -D "$new_branch"
            print_success "Rama $new_branch eliminada"
        else
            print_error "Operación cancelada. Elimina manualmente la rama $new_branch si deseas continuar."
            exit 1
        fi
    fi
    
    # Crear nueva rama
    git checkout "$branch"
    git pull origin "$branch"
    git checkout -b "$new_branch"
    print_success "Rama $new_branch creada desde $branch"
done

# Paso 4: Cherry-pick commits a las nuevas ramas
for new_branch in "${new_branches[@]}"; do
    print_info "Haciendo cherry-pick en rama $new_branch..."
    git checkout "$new_branch"
    
    for commit in "${commit_hashes[@]}"; do
        print_info "Cherry-picking commit $commit..."
        if git cherry-pick "$commit"; then
            print_success "Cherry-pick exitoso: $commit"
        else
            print_error "Error en cherry-pick de $commit en $new_branch"
            print_info "Resuelve los conflictos manualmente y ejecuta 'git cherry-pick --continue'"
            read -p "Presiona Enter después de resolver los conflictos..."
        fi
    done
    
    # Push de la nueva rama
    print_info "Haciendo push de $new_branch..."
    git push origin "$new_branch"
    print_success "Push completado para $new_branch"
done

# También hacer push de la rama original si no existe en remoto
print_info "Verificando rama original $current_branch en remoto..."
git checkout "$current_branch"
if ! git ls-remote --heads origin "$current_branch" | grep -q "$current_branch"; then
    print_info "Haciendo push de la rama original $current_branch..."
    git push origin "$current_branch"
fi

# Paso 5: Crear Merge Requests usando GitLab CLI
echo
print_info "Creando Merge Requests..."

# Array con todas las ramas (original + nuevas)
all_branches=("$current_branch" "${new_branches[@]}")
target_branches=("$selected_branch" "${other_branches[@]}")

# Arrays para almacenar los links de MR
declare -A mr_links

for i in "${!all_branches[@]}"; do
    source_branch="${all_branches[$i]}"
    target_branch="${target_branches[$i]}"
    
    print_info "Creando MR: $source_branch -> $target_branch"
    
    # Crear MR con título descriptivo
    mr_title="feat: merge $current_branch into $target_branch"
    mr_description="Merge request automático generado para integrar cambios de la rama feature $current_branch hacia $target_branch"
    
    # Capturar la salida del comando glab mr create
    mr_output=$(glab mr create \
        --source-branch "$source_branch" \
        --target-branch "$target_branch" \
        --title "$mr_title" \
        --description "$mr_description" \
        --assignee "@me" 2>&1)
    
    if [ $? -eq 0 ]; then
        print_success "MR creado: $source_branch -> $target_branch"
        # Extraer el URL del MR de la salida
        mr_url=$(echo "$mr_output" | grep -o 'https://[^[:space:]]*' | head -1)
        if [ -n "$mr_url" ]; then
            mr_links["$target_branch"]="$mr_url"
        fi
    else
        print_error "Error creando MR: $source_branch -> $target_branch"
        print_error "$mr_output"
    fi
done

# Volver a la rama original
git checkout "$current_branch"

echo
print_success "¡Proceso completado exitosamente!"
print_info "Resumen:"
print_info "- Rama original: $current_branch"
print_info "- Ramas creadas: ${new_branches[*]}"
print_info "- Commits aplicados: ${#commit_hashes[@]}"
print_info "- Merge Requests creados: ${#all_branches[@]}"

echo
print_info "Enlaces a los Merge Requests:"
# Mostrar los links en el orden específico: main, release/stage, dev
for target in "main" "release" "dev"; do
    if [ -n "${mr_links[$target]}" ]; then
        # Cambiar "release" por "stage" en la salida
        display_target="$target"
        if [ "$target" == "release" ]; then
            display_target="stage"
        fi
        echo "MR $display_target: ${mr_links[$target]}"
    fi
done
