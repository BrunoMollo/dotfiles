#!/bin/zsh
# Installs brew packages

# Check if Homebrew is installed
if ! command -v brew &> /dev/null
then
	echo "Homebrew not found. Installing..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	echo "Homebrew is already installed. 🍺"
fi



packages=(
	# Unix basics
	git
	curl
	stow

	# Remote repos CLI
	gh
	glab

	# Dev tools
	neovim
	tmux
	ripgrep
	fzf
	zsh-autosuggestions
	zoxide

	# PHP specific
	php 
	composer 

	# Node specific
	fnm

	# Gimics
	neofetch
	btop
	starship
	tree
)

for pkg in "${packages[@]}"; do
	if brew list "$pkg" &>/dev/null; then
		echo "$pkg is already installed. 👍🏾"
	else
		echo "Installing $pkg..."
		brew install "$pkg"
	fi
done

echo "🍺 All done! 🍺"
