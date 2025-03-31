#!/usr/bin/env nu

# Creates a table from the template.toml
let template_config = open ($env.XDG_CONFIG_HOME | path join "himalaya/template.toml")

let sanch_email = (pass show google/sanch/username | str trim)
let sanch_pass = ("pass show google/sanch/app_pass" | str trim)
let sanch_config = ($template_config
    | reject accounts.leet accounts.spag accounts.sbc
    | update accounts.sanch.email $sanch_email
    | update accounts.sanch.backend.login $sanch_email
    | update accounts.sanch.message.send.backend.login $sanch_email
    | update accounts.sanch.backend.auth.command $sanch_pass
    | update accounts.sanch.message.send.backend.auth.command $sanch_pass
)

let leet_email = (pass show google/leet/username | str trim)
let leet_pass = ("pass show google/leet/app_pass" | str trim)
let leet_config = ($template_config
    | reject accounts.sanch accounts.spag accounts.sbc
    | update accounts.leet.email $leet_email
    | update accounts.leet.backend.login $leet_email
    | update accounts.leet.message.send.backend.login $leet_email
    | update accounts.leet.backend.auth.command $leet_pass
    | update accounts.leet.message.send.backend.auth.command $leet_pass
)

let spag_email = (pass show google/spag/username | str trim)
let spag_pass = ("pass show google/spag/app_pass" | str trim)
let spag_config = ($template_config
    | reject accounts.leet accounts.sanch accounts.sbc
    | update accounts.spag.email $spag_email
    | update accounts.spag.backend.login $spag_email
    | update accounts.spag.message.send.backend.login $spag_email
    | update accounts.spag.backend.auth.command $spag_pass
    | update accounts.spag.message.send.backend.auth.command $spag_pass
)

let sbc_email = (pass show yahoo/sbc/username | str trim)
let sbc_pass = ("pass show yahoo/sbc/app_pass" | str trim)
let sbc_config = ($template_config
    | reject accounts.leet accounts.sanch accounts.spag
    | update accounts.sbc.email $sbc_email
    | update accounts.sbc.backend.login $sbc_email
    | update accounts.sbc.message.send.backend.login $sbc_email
    | update accounts.sbc.backend.auth.command $sbc_pass
    | update accounts.sbc.message.send.backend.auth.command $sbc_pass
)

let himalaya_config = $sanch_config
    | merge deep -s append $leet_config | update accounts.leet.default false
    | merge deep -s append $spag_config | update accounts.spag.default false
    | merge deep -s append $sbc_config | update accounts.sbc.default false

# make accounts dir if it doesn't exist
let accounts_dir = ($env.XDG_CONFIG_HOME | path join "himalaya/accounts")
mkdir $accounts_dir

# Save each account config as a separate .toml file
$sanch_config | to toml | save -f $"($accounts_dir)/sanch.toml"
$leet_config | to toml | save -f $"($accounts_dir)/leet.toml"
$spag_config | to toml | save -f $"($accounts_dir)/spag.toml"
$sbc_config | to toml | save -f $"($accounts_dir)/sbc.toml"
$himalaya_config | to toml | save -f ($env.XDG_CONFIG_HOME | path join "himalaya/config.toml")
