#!/usr/bin/env nu

if (ps | where name == wf-recorder | is-empty) {
    let region = (slurp | complete)
    if (($region.exit_code) == 1) {
        notify-send "wf-recorder.nu" "No selection made"
    } else {
        notify-send "wf-recorder.nu" "Recording started"
        let timestamp = (date now | format date "%Y-%m-%d_%H:%M:%S")
        wf-recorder -g $region.stdout -f ~/Videos/wf-recorder_($timestamp).mp4
    }
} else {
    kill (ps | where name == wf-recorder | get pid.0)
    notify-send "wf-recorder.nu" "Recording stopped"
}
