sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo spctl --master-disable


if ! [ -f ~/.zshrc ]; then
	ln -s ~/.dotfiles/dotfiles/.zshrc ~/.zshrc
	source ~/.zshrc
fi


brew update

cd ~/.dotfiles/
brew bundle

## Make redis server autostart
ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.m·l.redis.plist  # Start Redis server via launchctl

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

npm install -g tldr

mkdir ~/Documents/tmp
