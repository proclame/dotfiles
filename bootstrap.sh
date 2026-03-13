#!/bin/bash

echo ""
echo "==============================="
echo "  Dotfiles Bootstrap"
echo "==============================="
echo ""

# Keep sudo alive
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Xcode CLI tools if missing
if ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "Press any key once Xcode CLI tools installation is complete..."
  read -r -s -k 1
fi

# Install Homebrew if missing
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Add Homebrew to PATH on Apple Silicon
if [[ $(uname -m) == "arm64" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install gh CLI for cloning private repo
if ! command -v gh &>/dev/null; then
  echo "Installing GitHub CLI..."
  brew install gh
fi

# Authenticate with GitHub
echo ""
echo "Authenticating with GitHub..."
gh auth login

# Clone dotfiles repo
echo ""
echo "Cloning dotfiles..."
gh repo clone proclame/dotfiles ~/.dotfiles

# Run main install script
echo ""
echo "Running install script..."
cd ~/.dotfiles && bash install.sh
