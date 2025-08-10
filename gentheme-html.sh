#!/bin/sh

green='\033[0;32m'
blue='\033[0;34m'
yellow='\033[1;33m'
cyan='\033[0;36m'
magenta='\033[0;35m'
red='\033[0;31m'

log() {
  color=$1
  shift

  # Use parameter expansion to get value of color var, fallback to empty
  color_code="$(printf '%s' "${!color}")"
  printf "${color_code}%s${reset}\n" "$*"
}

log blue "Installing tree-sitter-cli"

curl -LO https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz
gunzip tree-sitter-linux-x64.gz
chmod +x tree-sitter-linux-x64
mv tree-sitter-linux-x64 /usr/local/bin/tree-sitter
tree-sitter --version

log yellow "Downloading Neovim..."
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz
tar -zxf nvim-linux-x86_64.tar.gz

log blue "Installing Neovim"
cp -r nvim-linux-x86_64/* /usr/local/

mkdir ~/.config
mv nvim ~/.config/nvim

mkdir src/lib/vihtml

nvim --headless +"q"

log yellow "Generating svelte components from base46 themes"
nvim --headless +":lua require 'vihtml'" +"q"
