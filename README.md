# Dotfiles

## What's included

- [Homebrew](https://brew.sh/)
- The latest Ruby, Node.js, and Python managed by [mise](https://github.com/jdx/mise)
- Gems for development: Ruby on Rails, Bundler, RuboCop, Ruby LSP, etc.
- Zsh with [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)
- Common development dependencies: PostgreSQL, ImageMagick, ssh-copy-id
- Apps: 1Password, Figma, Firefox, GitUp, Google Chrome, IINA, Rectangle, SF Symbols, Spotify, Transmission, Zed, and many other (customize in `Brewfile`)
- Homebrew Fonts: Fira Mono, Inter, Noto (Mono, Sans, Serif), etc. (customize in `Brewfile`)
- SSH key generation (ed25519)

## Screenshot

![Screenshot](screenshot.png)

## Install

```bash
# Install Xcode tools
xcode-select --install

# Clone dotfiles repo and change directory
git clone https://github.com/dankimio/dotfiles.git ~/Developer/dotfiles
cd ~/Developer/dotfiles

# Install using the script
./install.sh
```
