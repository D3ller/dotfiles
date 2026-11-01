#!/usr/bin/env bash

set -e

DOTFILES="$HOME/.dotfiles"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_homebrew() {
    if ! command -v brew >/dev/null 2>&1; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    eval "$(/opt/homebrew/bin/brew shellenv)"
}

clone_dotfiles() {
    if [ ! -d "$DOTFILES" ]; then
        git clone https://github.com/D3ller/dotfiles.git "$DOTFILES"
    fi
}

install_dependencies() {
    echo "Installing dependencies..."
    brew bundle --file="$SCRIPT_DIR/Brewfile"
}


configure_environment() {
    echo "Setting up Zed..."
    mkdir -p "$HOME/.config/zed"
    cp "$DOTFILES/zed/settings.json" "$HOME/.config/zed/settings.json"
}


install_homebrew
clone_dotfiles
install_dependencies
configure_environment

echo "Installation finished!"
echo "Run 'exec zsh -l' to restart your shell."