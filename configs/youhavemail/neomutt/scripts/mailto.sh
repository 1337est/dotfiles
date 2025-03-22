#!/usr/bin/env bash

# Capture the mailto URL from the first argument
mailto_url="${1:-}"
if [[ -z "$mailto_url" ]]; then
    exit 1  # Exit if no mailto link is provided
fi

# NeoMutt config directory
MUTT_CONFIG="$HOME/.config/neomutt"

# List of email accounts
ACCOUNTS=("leet" "sanch" "sbc" "spag")

# Prompt user to select an email account using fuzzel
CHOICE=$(printf "%s\n" "${ACCOUNTS[@]}" | fuzzel --dmenu --prompt "mailto: Select mailfrom account")
if [[ -z "$CHOICE" ]]; then
    exit 0  # Exit if the user cancels selection
fi

# Construct the account-specific NeoMutt config path
ACCOUNT_CONFIG_FILE="$MUTT_CONFIG/accounts/$CHOICE.muttrc"

# Run NeoMutt with the selected account and the mailto link
exec neomutt -F "$MUTT_CONFIG/neomuttrc" -F "$ACCOUNT_CONFIG_FILE" "$mailto_url"
