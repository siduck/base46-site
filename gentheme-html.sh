#!/bin/sh

# Install plugins
echo "Installing plugins"
mkdir -p ~/.local/share/nvim/site/pack/plugins/start
cd ~/.local/share/nvim/site/pack/plugins/start

git clone https://github.com/nvim-lua/plenary.nvim --depth 1
git clone https://github.com/nvim-treesitter/nvim-treesitter --depth 1
git clone https://github.com/lukas-reineke/indent-blankline.nvim --depth 1
git clone https://github.com/nvchad/base46 --depth 1

cd 

cd path0

echo "Setting up nvim"

mkdir ~/.config
mv nvim ~/.config/nvim
ls ~/.config/nvim

curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar -zxf nvim-linux64.tar.gz

mv nvim-linux64 nv

mkdir src/lib/vihtml

echo "Compiling base46 themes"
nv/bin/nvim --headless +"TSUpdate | lua require('base46').compile()" +"q"

echo "Generating svelte components from base46 themes"
nv/bin/nvim --headless +":lua require 'vihtml'" +"q"
