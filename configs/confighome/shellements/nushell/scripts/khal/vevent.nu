#!/usr/bin/env nu

# ics file information
let ics = open leet.ics
let ics_parsed = $ics | parse --regex '(?s)(?P<VCalendar>.*?)(?P<VEvents>BEGIN:VEVENT.*?END:VCALENDAR)' | get 0

# vcalendar information
let vcal = $ics_parsed | get VCalendar
let vcal_lines = $vcal | lines

# vevents information
let vevents = $ics_parsed | get VEvents
let vevents_parsed = $vevents | parse --regex '(?s)(?P<Event>BEGIN:VEVENT.*?END:VEVENT)'
let ve_lines = $vevents_parsed | each {|it| $it.Event | lines }

# list of lines with a starting space
let indices_with_starting_space = $ve_lines | each {||
    $in | enumerate
} | enumerate | each {|list_item|
    $list_item.item | each {|line|
        if ($line.item | str starts-with ' ') { $line.index }
    }
}

let indices_to_join = $indices_with_starting_space | each {|list|
    # top grouped list of lists
    mut grouped = []
    # to hold the current list that will be added into grouped
    mut current = [$list.0]
    for number in ($list | skip 1) {
        if $number == ($current | last | into int) + 1 {
            $current = ($current ++ [$number])
        } else {
            $grouped = ($grouped ++ [$current])
            $current = [$number]
        }
    }
    $grouped = ($grouped ++ [$current])
    $grouped
} | each {|list| each {|sublist| $sublist | prepend (($sublist | first) - 1) }}

mut unfolded_vevents = []

let total_vevents = ($ve_lines | length)

# unfold all of the vevents
for i in 0..($total_vevents - 1) {
    let ve = $ve_lines | get $i
    let ve_join_groups = $indices_to_join | get $i
    mut updated_ve = $ve
    mut offset_joined = 0

    for ve_group in $ve_join_groups {
        mut lines_to_join = []
        for idx in $ve_group {
            let updated_idx = $idx - $offset_joined
            let line = $updated_ve | get $updated_idx | str trim
            $lines_to_join = ($lines_to_join ++ [$line])
        }
        let joined = ($lines_to_join | str join)
        let before = $updated_ve | take (($ve_group | first) - $offset_joined)
        let after = $updated_ve | skip (($ve_group | last) - ($offset_joined - 1))
        $updated_ve = ($before ++ [$joined] ++ $after)
        $offset_joined = $offset_joined + ($ve_group | length) - 1
    }

    $unfolded_vevents = ($unfolded_vevents ++ [$updated_ve])
}


