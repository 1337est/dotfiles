#!/usr/bin/env zsh

# ZSH & history configuration
export ZDOTDIR="$XDG_CONFIG_HOME/zsh" # first called by /etc/security/pam_env.conf
export HISTFILE="$XDG_STATE_HOME/zsh/history" && mkdir -p "$XDG_STATE_HOME/zsh"
export HISTSIZE=10000
export SAVEHIST=10000

export TERM="ghostty" # Terminal emulator supporting 256 color
export PAGER="bat"
export MANPAGER='nvim +Man!' # View man pages with nvim
export MANWIDTH=999
# Editor configuration
export EDITOR="nvim"
export VISUAL="nvim"
# x/100 seconds to wait before keystrokes (important for vi mode)
export KEYTIMEOUT=1

# When things say "add this to your path", this is where they mean.
export PATH="$PATH"
# Default browser
export BROWSER="vivaldi"

# Load additional environment variables from extra.env
[[ -s "$XDG_CONFIG_HOME/zsh/user-dirs.zshenv" ]] && source "$XDG_CONFIG_HOME/zsh/user-dirs.zshenv"

# Load additional environment variables from extra.env
[[ -s "$XDG_CONFIG_HOME/zsh/apps.zshenv" ]] && source "$XDG_CONFIG_HOME/zsh/apps.zshenv"

# Load functions.zshrc for functions needed for .zshrc file
[[ -s "$XDG_CONFIG_HOME/zsh/functions.zshrc" ]] && source "$XDG_CONFIG_HOME/zsh/functions.zshrc"

# Load .zshrc for shell configuration and executing commands
[[ -s $XDG_CONFIG_HOME/zsh/.zshrc ]] && source $XDG_CONFIG_HOME/zsh/.zshrc

