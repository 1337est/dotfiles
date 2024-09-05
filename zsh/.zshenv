#!/usr/bin/env zsh
# "The shebang above ensures the zsh shell is used to interpret the script

# XDG environment variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

# ZSH & history configuration
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.hist_zsh"
export HISTSIZE=10000
export SAVEHIST=10000

# Terminal emulator
export TERM="alacritty" # Support for 256 color
# Editor configuration
export EDITOR="nvim"
export VISUAL="nvim"

# Add to you path here
export PATH="$PATH"

# To stop ranger from loading both the default and my custom rc.conf
export RANGER_LOAD_DEFAULT_RC=false

# Define default browsers to try
export BROWSER="firefox"

# Load .zshrc for shell configuration and executing commands
[[ -s $XDG_CONFIG_HOME/zsh/.zshrc ]] && source $XDG_CONFIG_HOME/zsh/.zshrc

