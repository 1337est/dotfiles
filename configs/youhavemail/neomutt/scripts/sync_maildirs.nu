#!/usr/bin/env nu

# Define the directory holding my accounts
let mbsync_dir = $"($env.HOME)/.local/share/email/neomutt/mbsync"

# Valid account names go here as subdirectories to 'mbsync_dir'
let accounts = ["leet", "sanch", "sbc", "spag"]

# Function to extract the "accX:mailbox_name" from the path
def extract_account [dir: string] {
    # When using 'split', acc is in the 8th index, and mailbox is in the 9th
    let parts = ($dir | path split)
    if ($parts | length) < 10 {
        return "" # Not a valid mail directory
    }
    let acc = ($parts | get 8)
    if ($accounts | any { |a| $a == $acc }) {
        return $acc
    }
    return "" # Return empty if not a valid account
}

# Monitor mail directories and mbsync modified accounts
while true {
    let modified_accounts = (
        inotifywait -r -e modify -e move -e create -e delete --format '%w' $mbsync_dir
        | lines
        | each { |dir| extract_account $dir }
        | where { |acc| not ($acc | is-empty) } # Remove empty results
        | uniq
    )
    # If no modified accounts, go back to start with you!
    if ($modified_accounts | is-empty) {
        continue
    }

    # Use modified accounts to run mbsync
    print $"\n\n\nSyncing accounts: ($modified_accounts | str join ' ')"
    mbsync -V ...$modified_accounts
}
