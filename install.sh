# Dotfiles
dir="$HOME/Developer/dotfiles"
cd $dir

# ohmyzsh
rm -rf ~/.oh-my-zsh
RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

rm -f ~/.zshrc

files="gemrc gitconfig gitignore hushlogin irbrc rubocop.yml zshrc"
for file in $files; do
  echo "Creating symlink to $file in home directory."
  ln -s $dir/$file ~/.$file
done

# Homebrew
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Make brew immediately available in this shell
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle

# Install the latest Ruby version with rbenv
latest="$(rbenv install -l | grep -v '^-' | tail -1 | tr -d ' ')"
rbenv install -s "$latest"
rbenv global "$latest"
bundle

# Generate SSH key
ssh-keygen -N ''
