#!/usr/bin/env bash
set -e

# We add ghostty, zed and search to the dock
dockutil --remove all --no-restart
dockutil --add "/Applications/Search.app" --no-restart
dockutil --add /Applications/Ghostty.app --no-restart
dockutil --add "/Applications/Zed.app" --no-restart

defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock persistent-others -array
killall Dock

wallpaper set "$HOME/.dotfiles/assets/wallpaper.heic"

mkdir -p "/Users/$USER/IdeaProjects"