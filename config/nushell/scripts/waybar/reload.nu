#!/usr/bin/env nu

kill (ps | where name == waybar | get pid.0)
hyprctl dispatch exec waybar
