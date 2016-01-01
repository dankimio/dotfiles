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
brew install git zsh
brew install imagemagick
brew install postgresql
brew install ssh-copy-id

# Caskroom
brew install caskroom/cask/brew-cask
brew cask install atom paw postgres gitup cyberduck
brew cask install dropbox flux vlc
brew cask install heroku-toolbelt

brew tap caskroom/fonts
brew cask install font-fira-mono font-open-sans

# rbenv plugins
git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

# Ruby
rbenv install 2.3.0
rbenv global 2.3.0
gem install bundler rails jekyll pry

# Generate SSH key
ssh-keygen -N ''
