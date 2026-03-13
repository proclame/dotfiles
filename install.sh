sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Checking for updates & installing them. Restart if necessary"
softwareupdate -ia --restart

echo ""
echo "Install XCode"
xcode-select --install

echo ""
echo "Checking for Homebrew, install if missing"
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Add Homebrew to PATH on Apple Silicon
if [[ $(uname -m) == "arm64" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew update

cd ~/.dotfiles/
brew bundle

## Post-install notes
echo "NOTE: Open 1Password > Settings > Developer and enable the SSH Agent manually."

## Setup Herd - park ~/Sites and configure NVM
mkdir -p ~/Sites
open -a Herd
echo ""
echo "Herd is opening. Complete the initial setup, then press any key to continue..."
read -r -s -k 1

cd ~/Sites && herd park

## Install default Node LTS via Herd's NVM
export NVM_DIR="/Users/nick/Library/Application Support/Herd/config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts
nvm alias default node

## Composer global packages
echo ""
echo "Installing Composer global packages..."
composer global require laravel/installer

brew cleanup

touch ~/.hushlogin

## Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## Source aliases (already configured in .zshrc via source ~/.dotfiles/dotfiles/.aliases)

# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.dotfiles/"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

ln -sf ~/.dotfiles/dotfiles/gitconfig ~/.gitconfig
