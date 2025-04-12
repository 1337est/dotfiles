#!/usr/bin/env nu

let ics_dir = ($env.XDG_CACHE_HOME | path join "neomutt/tmp")
let ics_files = (ls $ics_dir | where name ends-with '.ics' | get name)

if ($ics_files | length) == 1 {
    let $file = $ics_files | get 0
    khal import $file
} else if ($ics_files | length) > 1 {
    let file = $ics_files | input list "Select .ics file to import:"
    khal import $file
} else {
    print $"No .ics files found in ($ics_dir)"
}
