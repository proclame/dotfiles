# dotfiles

Personal macOS dotfiles for a fresh machine setup.

## Fresh Install

Paste this into Terminal on a new machine:

```zsh
/bin/bash -c "$(curl -fsSL https://gist.githubusercontent.com/proclame/996be0aaabea163419d661a4914f9e10/raw/bootstrap.sh)"
```

This will:

1. Install Xcode Command Line Tools
2. Install Homebrew (with Apple Silicon support)
3. Install the GitHub CLI and authenticate via browser
4. Clone this repo to `~/.dotfiles`
5. Run `install.sh` to set up everything else

## What install.sh does

- Installs all apps and tools via `brew bundle` (see `Brewfile`)
- Sets up Herd, parks `~/Sites`, and installs Node LTS via NVM
- Installs Composer global packages (`laravel/installer`)
- Sets up oh-my-zsh
- Configures iTerm2 to load preferences from this repo

## Manual steps after install

- **1Password** — open Settings > Developer and enable the SSH Agent
- **Herd** — complete initial setup when prompted during install

## What's in here

| File | Description |
|------|-------------|
| `Brewfile` | All Homebrew formulae, casks, and VS Code extensions |
| `install.sh` | Main setup script run after cloning |
| `bootstrap.sh` | Minimal bootstrap for a blank machine |
| `dotfiles/.aliases` | Shell aliases, sourced in `.zshrc` |
| `gitconfig` | Git configuration and aliases |
| `com.googlecode.iterm2.plist` | iTerm2 preferences |
