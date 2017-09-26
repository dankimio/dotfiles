# Dotfiles
dir="$HOME/Developer/dotfiles"
cd $dir

files="gemrc gitconfig hushlogin irbrc pryrc rubocop.yml zpreztorc zshrc"
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
brew install heroku

# Caskroom
brew cask install atom paw postgres gitup
brew cask install dropbox iina

brew tap caskroom/fonts

# Ruby
rbenv install 2.4.2
rbenv global 2.4.2
gem install bundler rails jekyll pry rubocop
gem install fastlane cocoapods

# Generate SSH key
ssh-keygen -N ''
