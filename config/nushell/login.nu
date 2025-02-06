# loading ssh keys and environment variables via keychain utility
# keychain --eval --quiet id_ed25519
# | lines
# | where not ($it | is-empty)
# | parse "{k}={v}; export {k2};"
# | select k v
# | transpose --header-row
# | into record
# | load-env

# starting hyprland on startup
if ((uwsm check may-start | complete | get exit_code) == 0) {
    exec uwsm start -- hyprland.desktop
}
