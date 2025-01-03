#!/bin/sh

echo "Setting up nvim"
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar -zxf nvim-linux64.tar.gz
mv nvim-linux64 nv

mkdir ~/.config
cp -r tiny ~/.config/nvim

mkdir src/lib/vihtml

echo "Install treesitter parsers"
nv/bin/nvim --headless +"q"

echo "Generating html from themes"
nv/bin/nvim --headless +":lua require 'vihtml'" +"q"
