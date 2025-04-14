#!/usr/bin/env nu

let ics_dir = ($env.XDG_CACHE_HOME | path join "neomutt/tmp")
let ics_files = (ls $ics_dir | where name ends-with '.ics' | get name)

if ($ics_files | length) > 0 {
    let file = $ics_files | input list $'(ansi blue_bold)Select .ics file to import:(ansi reset)'
    if ($file != null ) {
        do { khal import $file }
    } else {
        print $'(ansi red_bold)Nothing selected.(ansi reset)'
    }
} else {
    print $'(ansi red_bold)No .ics files found in (ansi blue)($ics_dir)(ansi reset)'
}
