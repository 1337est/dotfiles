#!/usr/bin/env nu

let mutt_config = $"($env.HOME)/.config/neomutt"
let accounts = ["leet", "sanch", "sbc", "spag"]

let selection = ($accounts | str join "\n" | fuzzel --dmenu --prompt "mailto: Select mailfrom account")
if ($selection | is-empty) { exit 0 }

let account_mutt_config = ($mutt_config | path join $"accounts/($selection).muttrc")

def main [x: string] {
    neomutt -F ($mutt_config | path join "neomuttrc") -F $account_mutt_config $x
}
