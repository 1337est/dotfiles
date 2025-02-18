# TODO: Integrate this setup with notifications using mako, and a waybar notification for when there is a recording going on.
if (ps | where name == wf-recorder | is-empty) {
    let region = (slurp)
    if ($region | is-empty) {
        print "Selection cancelled."
    } else {
        let timestamp = (date now | format date "%Y-%m-%d_%H:%M:%S")
        wf-recorder -g $region -f ~/Videos/wf-recorder_($timestamp).mp4
    }
} else {
    kill (ps | where name == wf-recorder | get pid.0)
    print "killed already running process"
}
