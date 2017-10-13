# Dotfiles

## What's included

- [Homebrew](https://brew.sh/)
- Ruby 2.4 managed by [rbenv](https://github.com/rbenv/rbenv)
- Gems for development: Rails, Jekyll, Bundler, etc.
- Zsh with [Prezto](https://github.com/sorin-ionescu/prezto)
- Common development dependencies: PostgreSQL, ImageMagick, ssh-copy-id
- Apps: [Atom](https://atom.io/), [Paw](https://paw.cloud/), [Postgres.app](https://postgresapp.com/), and many other (customize in `install.sh`)
- [Homebrew Fonts](https://github.com/caskroom/homebrew-fonts)
- SSH key generation

## Screenshot

![Screenshot](screenshot.png)

## Install

```bash
# Install Xcode tools
xcode-select --install

# Clone dotfiles repo and change directory
git clone https://github.com/dankimio/dotfiles.git ~/Developer/dotfiles
cd ~/Developer/dotfiles

# Install using the script
./install.sh
```

Import Terminal.app theme in settings and set it as the default.
