#!/bin/bash

# -e: stop when a command fails instead of continuing with a broken setup.
# -o pipefail: a pipeline fails if any command in it fails, not just the last one.
set -eo pipefail

dir="$(pwd)"
cd "$dir"

# ohmyzsh
echo "📦 Installing Oh My Zsh..."
if [ ! -d ~/.oh-my-zsh ]; then
  rm -rf ~/.oh-my-zsh
  RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "  Oh My Zsh already installed, skipping..."
fi

rm -f ~/.zshrc

# Create symlinks
echo "🔗 Creating symlinks..."
files="gemrc gitconfig gitignore hushlogin irbrc rubocop.yml zshrc"
for file in $files; do
  echo "  Creating symlink to $file"
  ln -sf "$dir/$file" ~/.$file
done

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

# Ruby setup
echo "💎 Setting up Ruby..."
mise use --global ruby@3

# Reinitialize mise to ensure shell can find Ruby
eval "$(mise activate bash)"

echo "  Installing gems..."
bundle install

# Node setup using mise
echo "🌐 Setting up Node..."
mise use --global node@lts

# Reinitialize mise to ensure shell can find Node
eval "$(mise activate bash)"

echo "  Installing global npm packages..."
npm install -g @antfu/ni git-delete-squashed

# Python setup using mise
echo "🐍 Setting up Python..."
mise use --global python@3

# Reinitialize mise to ensure shell can find Python
eval "$(mise activate bash)"

# SSH key
echo "🔑 Setting up SSH key..."
# Create the directory if missing.
mkdir -p ~/.ssh
# Allow only the owner to access the SSH directory.
chmod 700 ~/.ssh
# Keep the existing SSH key on reruns.
if [ ! -e ~/.ssh/id_ed25519 ]; then
  ssh-keygen -t ed25519 -N '' -f ~/.ssh/id_ed25519
fi

echo "✅ Dotfiles setup complete!"
