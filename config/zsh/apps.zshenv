#!/usr/bin/env zsh

# npm: App/user config directories/files
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc" && mkdir -p "$XDG_CONFIG_HOME/npm"

# Node.js: repl history location
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node/node_repl_history"

# go: App/user data directories/files
export GOPATH="$XDG_DATA_HOME/go" && mkdir -p "$GOPATH"

# grim: Setting the grim default screenshot directory
export GRIM_DEFAULT_DIR="$HOME/Pictures/Screenshots" && mkdir -p "$GRIM_DEFAULT_DIR"

# wget: Settings for ~/.wgetrc, where we will set the wget-hsts file location
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

# nnn:


# My setup needed for neomutt
export MYMAILDIR="$XDG_DATA_HOME/mail"
for acct_dir in "$MYMAILDIR/email_1" "$MYMAILDIR/email_2" "$MYMAILDIR/email_3" "$MYMAILDIR/email_4"; do
    for box in "INBOX" "Drafts" "Sent" "Trash"; do
        for cnt in "cur" "new" "tmp"; do
            mkdir -p "$acct_dir/$box/$cnt"
        done
    done
done

