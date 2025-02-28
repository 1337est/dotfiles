#!/usr/bin/env nu

# Creates a table from the template.toml
let template_config = open ($env.XDG_CONFIG_HOME | path join "himalaya/template.toml")

# Uses the `pass` utility to store email account names
let sanch_email = (pass show email/sanch/username | str trim)
let leet_email = (pass show email/leet/username | str trim)
let crypt_email = (pass show email/crypt/username | str trim)

# Uses the `pass` utility to store email account passwords
let sanch_pass = ("pass show email/sanch/app_pass" | str trim)
let leet_pass = ("pass show email/leet/app_pass" | str trim)
let crypt_pass = ("pass show email/crypt/app_pass" | str trim)

# Stores properly updated values in a table by updating the templated table
let himalaya_config = ($template_config
    | update accounts.sanch.email $sanch_email
    | update accounts.sanch.backend.login $sanch_email
    | update accounts.sanch.message.send.backend.login $sanch_email
    | update accounts.sanch.backend.auth.command $sanch_pass
    | update accounts.sanch.message.send.backend.auth.command $sanch_pass

    | update accounts.leet.email $leet_email
    | update accounts.leet.backend.login $leet_email
    | update accounts.leet.message.send.backend.login $leet_email
    | update accounts.leet.backend.auth.command $leet_pass
    | update accounts.leet.message.send.backend.auth.command $leet_pass

    | update accounts.crypt.email $crypt_email
    | update accounts.crypt.backend.login $crypt_email
    | update accounts.crypt.message.send.backend.login $crypt_email
    | update accounts.crypt.backend.auth.command $crypt_pass
    | update accounts.crypt.message.send.backend.auth.command $crypt_pass
)

#  After updating the `emailN@domain.com`, turn the table back into a toml file
$himalaya_config | to toml | save -f ($env.XDG_CONFIG_HOME | path join "himalaya/config.toml")
