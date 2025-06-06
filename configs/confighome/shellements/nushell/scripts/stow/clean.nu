#!/usr/bin/env nu

# Define the main stow directory
let stow_dir = ($env.HOME | path join "Github/dotfiles/configs")

# First thing is to remove any dereferenced symbolic links
let deref_syms = ^find $env.XDG_CONFIG_HOME $env.XDG_DATA_HOME ($env.HOME | path join ".gnupg") -xtype l | lines
for broken_link in $deref_syms { rm -f $broken_link }

# confighome stow restore
let config_pkgs = ls -s $"($stow_dir)/confighome" | where name != README.md | get name
let config_syms = ls -s $"($stow_dir)/confighome/de" $"($stow_dir)/confighome/shellements" $"($stow_dir)/confighome/youhavemail" | where name != README.md | get name
# remove packages before stow if they exist (e.g. carapace and atuin edge cases)
for files in $config_syms { rm -r $"($env.XDG_CONFIG_HOME)/($files)" }
for pkg in $config_pkgs { stow -d $"($stow_dir)/confighome" $pkg -t $env.XDG_CONFIG_HOME }

# datahome stow restore
let data_pkgs = ls -s $"($stow_dir)/datahome" | where name != README.md | get name
# remove packages before stow if they exist
for pkg in $data_pkgs { rm -r $"($env.XDG_DATA_HOME)/($pkg)" }
stow -d $stow_dir datahome -t $env.XDG_DATA_HOME

# gnupghome stow restore
let gnupg_pkgs = ls -s $"($stow_dir)/gnupghome" | where name != README.md | get name
# remove packages before stow if they exist
for pkg in $gnupg_pkgs { rm -r $"($env.HOME)/.gnupg/($pkg)" }
stow -d $stow_dir gnupghome -t $"($env.HOME)/.gnupg"

# systemduser stow restore
let systemduser_pkgs = ls -s $"($stow_dir)/systemduser" | where name != README.md | get name
# remove packages before stow if they exist
for pkg in $systemduser_pkgs { rm -r -f $"($env.XDG_CONFIG_HOME)/systemd/user/($pkg)" }
stow -d $stow_dir systemduser -t $"($env.XDG_CONFIG_HOME)/systemd/user"
# reenable/restart all user services
systemctl --user daemon-reload
for service in $systemduser_pkgs {
    # skips vdirsyncer.service
    if $service != "vdirsyncer.service" {
        systemctl --user enable --now $service
    }
}
