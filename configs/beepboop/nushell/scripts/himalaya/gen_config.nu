#!/usr/bin/env nu

# Creates a table from the template.toml
let template_config = open ($env.XDG_CONFIG_HOME | path join "himalaya/template.toml")

# Uses the `pass` utility to store email account names
let sanch_email = (pass show email/sanch/username | str trim)
let leet_email = (pass show email/leet/username | str trim)
let spag_email = (pass show email/spag/username | str trim)
let sbc_email = (pass show email/sbc/username | str trim)

# Stores properly updated values in a table by updating the templated table
let himalaya_config = ($template_config
    | update accounts.sanch.email $sanch_email
    | update accounts.sanch.backend.login $sanch_email
    | update accounts.sanch.message.send.backend.login $sanch_email

    | update accounts.leet.email $leet_email
    | update accounts.leet.backend.login $leet_email
    | update accounts.leet.message.send.backend.login $leet_email

    | update accounts.spag.email $spag_email
    | update accounts.spag.backend.login $spag_email
    | update accounts.spag.message.send.backend.login $spag_email

    | update accounts.sbc.email $sbc_email
    | update accounts.sbc.backend.login $sbc_email
    | update accounts.sbc.message.send.backend.login $sbc_email
)

#  After updating the `emailN@domain.com`, turn the table back into a toml file
$himalaya_config | to toml | save -f ($env.XDG_CONFIG_HOME | path join "himalaya/config.toml")
