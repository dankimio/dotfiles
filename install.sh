# Dotfiles
dir="$HOME/Developer/dotfiles"
cd $dir

rm -f ~/.zshrc

files="gemrc gitconfig hushlogin irbrc rubocop.yml zshrc"
for file in $files; do
  echo "Creating symlink to $file in home directory."
  ln -s $dir/$file ~/.$file
done

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle

# Install the latest Ruby version with rbenv
rbenv install $(rbenv install -l | grep -v - | tail -1)
rbenv global $(rbenv install -l | grep -v - | tail -1)
bundle

# ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Generate SSH key
ssh-keygen -N ''
