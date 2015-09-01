# Dotfiles
dir="$HOME/Developer/dotfiles"
cd $dir

files="gemrc gitconfig zshrc"
for file in $files; do
  echo "Creating symlink to $file in home directory."
  ln -s $dir/$file ~/.$file
done

# Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew install rbenv ruby-build
brew install git zsh nvm
brew install imagemagick
brew install postgresql
brew install ssh-copy-id

# Caskroom
brew install caskroom/cask/brew-cask
brew cask install atom paw postgres gitup cyberduck
brew cask install dropbox flux firefox
