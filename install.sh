#!/bin/bash

# Dotfiles
dir="$(pwd)"
cd "$dir"

echo "🚀 Setting up dotfiles..."

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

echo "  Installing packages from Brewfile..."
brew bundle

# Ruby setup
echo "💎 Setting up Ruby..."
latest="$(rbenv install -l | grep '^[0-9]' | tail -1 | tr -d ' ')"
echo "  Installing Ruby $latest..."
rbenv install -s "$latest"
rbenv global "$latest"

# Initialize rbenv in current shell
eval "$(rbenv init -)"

echo "  Installing gems..."
bundle install

# Node setup using mise
echo "🌐 Setting up Node..."
mise use --global node@lts

# Reinitialize mise to ensure shell can find Node
eval "$(mise activate bash)"

echo "  Installing global npm packages..."
npm install -g @antfu/ni git-delete-squashed

# SSH key
echo "🔑 Setting up SSH key..."
ssh-keygen -t ed25519 -N '' -f ~/.ssh/id_ed25519

echo "✅ Dotfiles setup complete!"
