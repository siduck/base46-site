# Base46-site

A website showcasing NvChad's Base46 theme with various languages ( previews generated from neovim itself! ). And providing various terminal configs.

## How it works?

1) The prebuild script in package.json runs a shell script gentheme-html.sh
2) This scripts downloads neovim ( on wherever the website is deployed ) and bootstraps the neovim config (nvim dir), installs plugins etc. 
3) Then a lua module `vihtml` from the nvim config runs and generates all theme html as svelte components and saves them to `src/lib` dir
4) Svelte then compiles them well 

https://github.com/user-attachments/assets/38a0a619-0519-4296-8b6f-29b6d5e7eff0
