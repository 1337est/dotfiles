#!/usr/bin/env nu

# Define the maildir path
let maildirs = $"($env.HOME)/.local/share/email/neomutt/mbsync"

# Function to sync only the affected account
def sync_mail [file_path: string] {
    # Extract account name from the file path
    let account_name = ($file_path | path split | last)

    # Check if it's a valid account before running mbsync
    if ($account_name | str length) > 0 and ($maildirs | path join $account_name | path exists) {
        print $"Change detected in ($account_name), running mbsync ($account_name)..."
        ^mbsync $account_name
    }
}

# Monitor the directories for changes and sync the affected account
inotifywait -m -r -e modify -e move -e create -e delete --format '%w' $maildirs | lines | each { |dir| sync_mail $dir }
