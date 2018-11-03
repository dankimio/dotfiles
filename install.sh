# Dotfiles
dir="$HOME/Developer/dotfiles"
cd $dir

files="gemrc gitconfig hushlogin irbrc pryrc rubocop.yml zshrc"
for file in $files; do
  echo "Creating symlink to $file in home directory."
  ln -s $dir/$file ~/.$file
done

# Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install git heroku imagemagick node openssl postgresql rbenv ruby-build ssh-copy-id unrar yarn zsh

# Caskroom
brew cask install 1password atom dash dropbox firefox gitup gitup google-chrome iina paw postgres sublime-text transmission tunnelbear

# Fonts
brew tap caskroom/fonts
brew install font-fira-mono font-open-sans font-roboto font-roboto-mono

# Ruby
rbenv install 2.5.1
rbenv global 2.5.1
gem install bundler rails jekyll pry rubocop
gem install fastlane cocoapods

# Generate SSH key
ssh-keygen -N ''
