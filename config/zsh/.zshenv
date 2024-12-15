#!/usr/bin/env zsh

# ZSH & history configuration
export ZDOTDIR="$XDG_CONFIG_HOME/zsh" # first called by /etc/security/pam_env.conf
export HISTFILE="$XDG_STATE_HOME/zsh/history" && mkdir -p "$XDG_STATE_HOME/zsh"
export HISTSIZE=10000
export SAVEHIST=10000

export TERM="alacritty" # Terminal emulator supporting 256 color
export PAGER="bat"
# Editor configuration
export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER='nvim +Man!' # View man pages with nvim
export KEYTIMEOUT=1 # x/100 seconds to wait before keystrokes (important for vi mode)

# When things say "add this to your path", this is where they mean.
export PATH="$HOME/Dev/bin:$PATH"
# Default browser
export BROWSER="firefox"
# For gpg signing to work
export GPG_TTY=$(tty)

# App/user config directories/files
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc" && mkdir -p "$XDG_CONFIG_HOME/npm"

# App/user data directories/files
export GOPATH="$XDG_DATA_HOME/go" && mkdir -p "$GOPATH"

# Setting the grim default screenshot directory
export GRIM_DEFAULT_DIR="$HOME/Pictures/Screenshots" && mkdir -p "$GRIM_DEFAULT_DIR"

# Settings for nb note taking app
export NBRC_PATH="$XDG_CONFIG_HOME/nb/.nbrc"

# My setup needed for neomutt
export MYMAILDIR="$XDG_DATA_HOME/mail"
for acct_dir in "$MYMAILDIR/email_1" "$MYMAILDIR/email_2" "$MYMAILDIR/email_3" "$MYMAILDIR/email_4"; do
    for box in "INBOX" "Drafts" "Sent" "Trash"; do
        for cnt in "cur" "new" "tmp"; do
            mkdir -p "$acct_dir/$box/$cnt"
        done
    done
done

# Load .zshrc for shell configuration and executing commands
[[ -s $XDG_CONFIG_HOME/zsh/.zshrc ]] && source $XDG_CONFIG_HOME/zsh/.zshrc

