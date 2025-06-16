#!/usr/bin/env nu

let audio_device = pactl list sources | grep 'Name:' | str replace -a 'Name: ' ''
| lines | each {|| str trim}
| input list $"(ansi yellow)Select the audio device you want to use(ansi reset)"

if (ps | where name == wf-recorder | is-empty) {
    if ($audio_device | is-empty) {
        notify-send "wf-recorder.nu" "No audio device selected"
    }
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
