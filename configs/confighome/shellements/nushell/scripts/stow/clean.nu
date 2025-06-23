#!/usr/bin/env nu

# Define the main stow directory
let stow_dir = ($env.HOME | path join "Code/github/dotfiles/configs")
let config_dir = ($env.HOME | path join ".config")
let data_dir = ($env.HOME | path join ".local/share")
mkdir $data_dir
let gnupg_dir = ($env.HOME | path join ".gnupg")
mkdir $gnupg_dir
let systemduser_dir = ($env.HOME | path join ".config/systemd/user")
mkdir $systemduser_dir

# First thing is to remove any dereferenced symbolic links
let deref_syms = ^find $config_dir $data_dir $gnupg_dir -xtype l | lines

# comment
for broken_link in $deref_syms { rm -f $broken_link }

# === confighome ===
let config_pkgs = ls -s $"($stow_dir)/confighome" | where name != README.md | get name | sort
let config_syms = ls -s $"($stow_dir)/confighome/de" $"($stow_dir)/confighome/shellements" $"($stow_dir)/confighome/youhavemail" | where name != README.md | get name | sort

# remove packages before stow if they exist (e.g. carapace and atuin edge cases)
for filedir in $config_syms { rm -rf $"($config_dir)/($filedir)" }
# comment
for pkg in $config_pkgs { stow -d $"($stow_dir)/confighome" $pkg -t $config_dir }

# === datahome ===
let data_pkgs = ls -s $"($stow_dir)/datahome" | where name != README.md | get name | sort

# remove packages before stow if they exist
for pkg in $data_pkgs { rm -rf $"($data_dir)/($pkg)" }
# comment
stow -d $stow_dir datahome -t $data_dir

# === gnupghome ===
let gnupg_pkgs = ls -s $"($stow_dir)/gnupghome" | where name != README.md | get name | sort

# remove packages before stow if they exist
for pkg in $gnupg_pkgs { rm -rf $"($gnupg_dir)/($pkg)" }
# comment
stow -d $stow_dir gnupghome -t $"($gnupg_dir)"

# === systemduser ===
let systemduser_pkgs = ls -s $"($stow_dir)/systemduser" | where name != README.md | get name | sort

# remove packages before stow if they exist
for pkg in $systemduser_pkgs { rm -rf $"($systemduser_dir)/($pkg)" }
stow -d $stow_dir systemduser -t $"($systemduser_dir)"

# === systemd resets ===
# reenable/restart all user services
systemctl --user daemon-reload
for service in $systemduser_pkgs {
    # skips vdirsyncer.service
    if $service != "vdirsyncer.service" {
        systemctl --user enable --now $service
    }
}
