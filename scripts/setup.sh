#!/usr/bin/env bash

set -e

DOTFILES="$HOME/.dotfiles"

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
    brew bundle --file="$DOTFILES/Brewfile"
}


configure_environment() {
    echo "Setting up Zed..."
    mkdir -p "$HOME/.config/zed"
    ln -sfn "$DOTFILES/zed/settings.json" "$HOME/.config/zed/settings.json"

    echo "Setting up Ghostty..."
    GHOSTTY_CONFIG="$HOME/Library/Application Support/com.mitchellh.ghostty"
    
    mkdir -p "$GHOSTTY_CONFIG"
    cp "$DOTFILES/ghostty/config.ghostty" "$GHOSTTY_CONFIG/config.ghostty"

    echo "Setting up Helix..."
    mkdir -p "$HOME/.config"
    ln -sfn "$DOTFILES/helix" "$HOME/.config/helix"

    echo "Setting up Starship..."
    ln -sfn "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"

    echo "Setting up bat..."
    ln -sfn "$DOTFILES/bat" "$HOME/.config/bat"

    echo "Setting up zsh..."
    if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
        mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
    fi
    ln -sfn "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"

    echo "Setting up fastfetch..."
    ln -sfn "$DOTFILES/fastfetch" "$HOME/.config/fastfetch"
}


install_homebrew
clone_dotfiles
install_dependencies
configure_environment

echo "Installation finished!"
echo "Run 'exec zsh -l' to restart your shell."