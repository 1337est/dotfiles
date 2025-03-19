#!/usr/bin/env nu

# Define the directory holding my accounts
let mbsync_dir = $"($env.HOME)/.local/share/email/neomutt/mbsync"

# Valid account names go here as subdirectories to 'mbsync_dir'
let accounts = ["leet", "sanch", "sbc", "spag"]

# Function to extract the account name from the path
def extract_account [dir: string] {
    let parts = ($dir | path split)
    let acc = ($parts | where { |p| $accounts | any { |a| $a == $p } } | first)
    if ($acc | is-empty) { return "" }
    return $acc
}

# Run sync every 10-ish seconds
while true {
    let affected_accounts = (
        # Monitor directories and handle events continuously for 10 seconds
        # WARN: incomplete solution:
        # while mbsync runs, you could miss update events
        inotifywait -r -e modify -e move -e create -e delete --format '%w' $mbsync_dir
        | lines
        | each { |dir| extract_account $dir }
        | where { |acc| not ($acc | is-empty) } # Remove empty results
        | uniq
    )

    if ($affected_accounts | is-empty) {
        continue # No changes, go back to waiting
    }

    print $"\n\n\nSyncing accounts: ($affected_accounts | str join ' ')"
    mbsync -V ...$affected_accounts
}
