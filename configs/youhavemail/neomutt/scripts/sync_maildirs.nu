#!/usr/bin/env nu

# Define the directory holding my accounts
let mbsync_dir = $"($env.HOME)/.local/share/email/neomutt/mbsync"

# Function to sync only the affected account:mailbox
def sync_mail [dir: string] {
    # Convert the directory path into an array of parts
    let parts = ($dir | path split)

    # Hardcoded assumption: accX is always at index -3, mailbox name is at index -2
    # TODO: parts includes [leet sanch spag sbc], get that dir
    # Therefore from $parts, get index of "leet,sanch,spag,sbc"
    # whatever index that is, mailbox is +1 that index
    let acc = $parts | drop 2 | last
    let mailbox = $parts | drop 1 | last

    # Ensure we have both values before proceeding
    if ($acc | is-empty) or ($mailbox | is-empty) {
        print "Error: Could not determine account/mailbox from path: ($dir)"
        return
    }

    # Run mbsync for the specific account and mailbox
    let mailbox_name = ($mailbox | str replace "." "/")  # change for mbsync mailbox
    print $"Change detected in ($acc):($mailbox_name), running mbsync..."
    ^mbsync -V $"($acc):($mailbox_name)"
}

# Monitor the directories for changes and sync the affected account
inotifywait -r -e modify -e move -e create -e delete --format '%w' $maildirs | lines | each { |dir| sync_mail $dir }
