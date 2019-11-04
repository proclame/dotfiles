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
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

cd ~/.dotfiles/
brew bundle

## Install Package Control & Link Sublime User Prefs Folder
cp ~/.dotfiles/Sublime/Package\ Control.sublime-package ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/
rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
ln -s ~/.dotfiles/Sublime ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User


## @todo: BAKCBLAZE INSTALLER
composer global require laravel/installer
composer global require laravel/valet

## @todo: add check if exists / valet parked ?
valet install
mkdir ~/Sites
cd ~/Sites
valet park


brew cleanup

touch ~/.hushlogin

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

mkdir ~/Documents/tmp

# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.dotfiles/"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
