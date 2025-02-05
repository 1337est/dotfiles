if ((uwsm check may-start | complete | get exit_code) == 0) {
    exec uwsm start -- hyprland.desktop
}
