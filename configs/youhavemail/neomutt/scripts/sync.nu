#!/usr/bin/env nu

# Root directory to watch with inotifywait
let mbsync_dir = $"($env.HOME)/.local/share/email/neomutt/mbsync"
let valid_accounts = ["leet", "sanch", "sbc", "spag"]
let cnt = ["cur", "new", "tmp"]

# Sync account mailboxes corresponding to inotifywait events
loop {
    # set check to happen every minute
    let result = (
        inotifywait -e modify -e move -e create -e delete
        -r -m -t 60 --format '%w' $mbsync_dir | complete
    )
    # handle errors
    let exit_code = $result.exit_code
    if not ($exit_code in [0 2]) {
        print $"\nError: inotifywait failed with exit code ($exit_code). Exiting..."
        exit 1
    }

    # event handling logic
    let acc_mb_events = (
        $result.stdout | lines | uniq
        | each { |event|
            if (($event | path split | last) in $cnt) {
                $event | path split | last 3 | drop
            }
        }
        | uniq
        | each {|acc_mb| $"($acc_mb.0):($acc_mb.1 | str replace "." "/")"}
    )
    # If no mailbox event, go back to the start
    if ($acc_mb_events | is-empty) {
        print $"No event and exit code ($exit_code). Restarting..."
        continue
    }

    # sync mailboxes
    print $"\nSTART\nSyncing accounts: ($acc_mb_events | str join ' ')"
    mbsync ...$acc_mb_events
    print $"END\n"
}
