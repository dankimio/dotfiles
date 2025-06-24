#!/bin/bash

# Dotfiles
dir="$HOME/Developer/dotfiles"
cd "$dir"

echo "🚀 Setting up dotfiles..."

# ohmyzsh
echo "📦 Installing Oh My Zsh..."
rm -rf ~/.oh-my-zsh
RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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
latest="$(rbenv install -l | grep -v '^-' | tail -1 | tr -d ' ')"
echo "  Installing Ruby $latest..."
rbenv install -s "$latest"
rbenv global "$latest"

echo "  Installing gems..."
bundle install

# SSH key
echo "🔑 Setting up SSH key..."
ssh-keygen -t ed25519 -N '' -f ~/.ssh/id_ed25519

echo "✅ Dotfiles setup complete!"
