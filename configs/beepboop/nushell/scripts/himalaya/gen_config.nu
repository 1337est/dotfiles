#!/usr/bin/env nu

# Creates a table from the template.toml
let template_config = open ($env.XDG_CONFIG_HOME | path join "himalaya/template.toml")

let sanch_email = (pass show email/sanch/username | str trim)
let sanch_pass = ("pass show email/sanch/app_pass" | str trim)
let sanch_config = ($template_config | reject accounts.leet accounts.crypt
    | update accounts.sanch.email $sanch_email
    | update accounts.sanch.backend.login $sanch_email
    | update accounts.sanch.message.send.backend.login $sanch_email
    | update accounts.sanch.backend.auth.command $sanch_pass
    | update accounts.sanch.message.send.backend.auth.command $sanch_pass
)

let leet_email = (pass show email/leet/username | str trim)
let leet_pass = ("pass show email/leet/app_pass" | str trim)
let leet_config = ($template_config | reject accounts.sanch accounts.crypt
    | update accounts.leet.email $leet_email
    | update accounts.leet.backend.login $leet_email
    | update accounts.leet.message.send.backend.login $leet_email
    | update accounts.leet.backend.auth.command $leet_pass
    | update accounts.leet.message.send.backend.auth.command $leet_pass
)

let crypt_email = (pass show email/crypt/username | str trim)
let crypt_pass = ("pass show email/crypt/app_pass" | str trim)
let crypt_config = ($template_config | reject accounts.leet accounts.sanch
    | update accounts.crypt.email $crypt_email
    | update accounts.crypt.backend.login $crypt_email
    | update accounts.crypt.message.send.backend.login $crypt_email
    | update accounts.crypt.backend.auth.command $crypt_pass
    | update accounts.crypt.message.send.backend.auth.command $crypt_pass
)

let himalaya_config = $sanch_config
    | merge deep -s append $leet_config | update accounts.leet.default false
    | merge deep -s append $crypt_config | update accounts.crypt.default false

# make accounts dir if it doesn't exist
let accounts_dir = ($env.XDG_CONFIG_HOME | path join "himalaya/accounts")
mkdir $accounts_dir

# Save each account config as a separate .toml file
$sanch_config | to toml | save -f $"($accounts_dir)/sanch.toml"
$leet_config | to toml | save -f $"($accounts_dir)/leet.toml"
$crypt_config | to toml | save -f $"($accounts_dir)/crypt.toml"
$himalaya_config | to toml | save -f ($env.XDG_CONFIG_HOME | path join "himalaya/config.toml")
