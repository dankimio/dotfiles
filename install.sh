#!/bin/bash

set -e

cd "$(dirname "$0")"
dir="$PWD"

# ohmyzsh
echo "📦 Installing Oh My Zsh..."
if [ ! -d ~/.oh-my-zsh ]; then
  RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "  Oh My Zsh already installed, skipping..."
fi

# Create symlinks
echo "🔗 Creating symlinks..."
for file in gemrc gitconfig gitignore hushlogin irbrc rubocop.yml zshrc; do
  echo "  Creating symlink to $file"
  ln -sf "$dir/$file" ~/.$file
done

# Zed settings
mkdir -p ~/.config/zed
ln -sf "$dir/zed/settings.json" ~/.config/zed/settings.json

# Homebrew
echo "🍺 Setting up Homebrew..."
if ! command -v brew >/dev/null 2>&1; then
  echo "  Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Make Homebrew available in this script; Bash does not read our .zshrc.
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "  Installing packages from Brewfile..."
brew bundle

# mise setup
echo "🛠️ Setting up Ruby, Node.js, and Python..."
# Use the version settings from dotfiles as the global mise configuration.
mkdir -p ~/.config/mise
ln -sf "$dir/mise.toml" ~/.config/mise/config.toml
mise install

# mise exec runs commands with the configured Ruby and Node.js versions.
echo "  Installing gems..."
mise exec -- bundle install

echo "  Installing global npm packages..."
mise exec -- npm install -g @antfu/ni git-delete-squashed

# SSH key
echo "🔑 Setting up SSH key..."
bash "$dir/restore-ssh-key.sh"

echo "✅ Dotfiles setup complete!"
