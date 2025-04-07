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

mut fixed_vevents = []

let total = ($ics_ve_lines | length)
for i in 0..($total - 1) {
    let ve_lines = $ics_ve_lines | get $i
    let join_groups = $indices_to_join | get $i
    mut updated = $ve_lines

    # TODO: last left here
    for group in $join_groups {
        mut lines_to_join = []
        for idx in $group {
            let line = $updated | get $idx | str trim
            $lines_to_join = ($lines_to_join ++ [$line])
        }
        let joined = ($lines_to_join | str join)
        print $lines_to_join
        print $joined
        let before = $updated | take ($group | first)
        let after = $updated | skip (($group | last) + 1)
        let updated = ($before ++ [$joined] ++ $after)
    }

    let fixed_vevents = ($fixed_vevents ++ [$updated])
}

# let enumerated_ics_ve_lines = $ics_ve_lines | each {|event| $event | enumerate } | enumerate | each {|event|
#     let cur_e_index = $event.index # event index 0 1 2 3
#     print $"Current event: ($cur_e_index)"
#     let cur_e_item = $event.item   # full event  0 1 2 3
#     print $cur_e_item
#     let cur_e_indices_list = $indices_to_join | get $cur_e_index # list of join indices 0 1 2 3
#     print $"Current list for event:"
#     print $cur_e_indices_list
#     let cur_e_indices_sublists = $cur_e_indices_list | each {||
#         $in | enumerate
#     } | enumerate | each {|sublist|
#         let cur_sublist_index = $sublist.index
#         print $"Current sublist: ($cur_sublist_index)"
#         let cur_sublist_item = $sublist.item
#         print $cur_sublist_item
#         let cur_sublist_indices_items = $cur_sublist_item | each {||
#             $in | enumerate
#         } | enumerate
#         $cur_sublist_indices_items | each {|sublist_listitem|
#             let cur_listitem_index = $sublist_listitem.index
#             print $"Current sublist_listitem: ($cur_listitem_index)"
#             let cur_listitem_item = $sublist_listitem.item.item.item.0
#             print $cur_listitem_item
#         }
#     }
# }
