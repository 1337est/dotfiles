#!/usr/bin/env nu

# ics file information
let ics_file = open leet.ics
let ics_file_lines = $ics_file | lines
let ics_file_parsed = $ics_file | parse --regex '(?s)(?P<VCalendar>.*?)(?P<VEvents>BEGIN:VEVENT.*?END:VCALENDAR)' | get 0

# vcalendar information
let ics_vcal = $ics_file_parsed | get VCalendar
let ics_vcal_lines = $ics_vcal | lines

# vevents information
let ics_ve = $ics_file_parsed | get VEvents
let ics_ve_parsed = $ics_ve | parse --regex '(?s)(?P<Event>BEGIN:VEVENT.*?END:VEVENT)'
let ics_ve_lines = $ics_ve_parsed | each {|it| $it.Event | lines }

# list of lines with a starting space
let indices_with_starting_space = $ics_ve_lines | each {||
    $in | enumerate
} | enumerate | each {|list_item|
    $list_item.item | each {|line|
        if ($line.item | str starts-with ' ') { $line.index }
    }
}

let indices_to_join = $indices_with_starting_space | each {|list|
    mut grouped = []
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

# TESTING: Below are things I'm testing
# NOTE: $indices_to_join.0 = first event with list<manysublistings<int>> for the lines to get/join
# NOTE: $ics_ve_lines.0 = first event with lines already applied
# TEST: First event (0.item)'s first entry (0.item)
# Same as: $ics_ve_lines.0 $ics.ve_lines.1 $ics.ve_lines.2 $ics.ve_lines.3
let enumerated_ics_ve_lines = $ics_ve_lines | each {|event| $event | enumerate } | enumerate
$enumerated_ics_ve_lines | each {|event|
        # list = each events list of lines to join.
        # 0[<3><2><2><17><2><2><2>] where 1st $list is 0<2> 3rd is 0<17>
        # 1[<3><3><3><17><2><2><2>] where 1st $list is 1<3> 3rd is 1<17>
        # 2[<3><3><3><17><2><2><2>] where 1st $list is 2<3> 3rd is 2<17>
        # 3[<3><3><3><17><2><2><2>] where 1st $list is 3<3> 3rd is 3<17>
            # list_item = each item in a $list. So the $list == 0<3> == [8 9 10] items themselves, which are 8 9 and 10.
            # The first $list_item == 8, the second $list_item == 9, the third $list_item == 10, etc.
    let cur_e_index = $event.index # event index 0 1 2 3
    print $"Current event: ($cur_e_index)"
    let cur_e_item = $event.item   # full event  0 1 2 3
    print $cur_e_item
    let cur_e_indices_list = $indices_to_join | get $cur_e_index # list of join indices 0 1 2 3
    print $"Current list:"
    print $cur_e_indices_list
    # $cur_e_indices_list | each {|list| $list | each {|| print $in }}
    # FIXME: Currently only gets first item of each sublist. Need to fix
    let sublists = $cur_e_indices_list | each {|list| enumerate | each {|list_item| $list_item } } | enumerate | each {|| $in | get item.0 }
    print $sublists
}
# NOTE: get (0-3 event index).item.(0-x line_item index).item
# NOTE: each goes through the indices so the first each should be the $in.item
# NOTE: The second each should be the line numbers to str join for each event
# TEST: Find a formula to not hard-code $ics_ve_lines.0 test.0 test.1 etc.
let test = [8 9 10] # should be 
let test2 = $ics_ve_lines.0 | get $test.0 $test.1 $test.2 | each {|| str trim } | str join
