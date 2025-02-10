# Summary

I tried running Hyprland with `uwsm` but it seems to be a bit buggy for me when exiting and re-entering. Initial startup was fine, but I wasn't able to get back in. This may be because I use `nushell` instead of a standard shell. I'm okay running the `Hyprland` command after logging in through a `tty`. I'm a simple man.

# `hyprland.conf`

Each section is split up into what the original `hyprland.conf` contained.

I didn't change much throughout the overall configuration file other than maybe some formatting tweaks. I'll simply go over the configuration settings I've changed from the default config.

## `DEFAULT APPS`

- **terminal**: I use `ghostty` as my terminal.
- **file manager**: I use the terminal based file manager `yazzi`, hence the call to `$terminal -e nu -e y`. In layman speak this means:
    - `ghostty -e`: open a terminal and execute an external command.
    - `nu -e`: The external command is to execute an external shell command, which opens `yazzi` using the alias I have in my `config.nu` file.
- **menu**: I use `fuzzel` because I like the defaults (just install and no messing around, just works)
- **browser**: I set this for convenience to `vivaldi`.

## `AUTOSTART`

- **status bar**: I use `waybar` for my status bar, and keep a very basic setup for this.
- **notifications**: I use `mako` for this. Tried dunst, and I like mako's defaults better.
- **hyprpolkitagent**: This is started as recommended by the wiki without uwsm.
- **wallpaper**: I'm using `hyprpaper` for the wallpaper. As a quick tid-bit, you need the `hyprpaper.conf` file in the `hypr/` directory for the `exec-once` command to do anything. I found this out by running `systemctl status` and noticing I wasn't getting anything for `hyprpaper` under:
```
-> `user.slice`
    -> `user-1000.slice`
        -> `session-x.scope`
                "login -- adrian"
                -nu
                /usr/bin/Hyprland
                waybar
                mako
                hyprpaper
```
As you can see, after login, nushell starts (since it's a tty). My default shell is `nu`. I then run the `Hyprland` command. This resolves to the full path located above, then on startup, everything in `exec-once` runs, to include `hyprpaper`. However, without the `hyprpaper.conf` file present in the hyprland directory (`XDG_CONFIG_HOME/hypr`), the `hyprpaper` wasn't executed and was not present for the user scope/session. This didn't throw any errors although may have been in a log somewhere. Manually running any of these commands output an error saying that it could not connect to `/run/user/hypr/long-string-of-hex-value-here/.hyprpaper.sock`:
```
hyprctl hyprpaper preload "~/some/location/to/picture"
hyprctl hyprpaper wallpaper , "~/some/location/to/picture"
hyprctl hyprpaper listloaded
```

## `KEYBINDINGS`

I won't rehash a majority of this as it's straightforward. I'll go over the confusing/personal bits.

- **modification key**: I've always liked hitting the **Windows** key to trigger desktop/window/workspace events.

- Apps
    - I have `yazi` open up as a floating terminal. When exiting `yazi`, the terminal stays in case I need it for anything (the terminal doesn't close).

- Quit commands
    - quit a window using `super + q`
    - quit hyprland using `super + shift + q`

- tiling/floating
    - F for toggle float
    - P for pseudo floating/tiling
    - S for toggle split

- vim window focus navigation

- The scratchpad is the magic place. It's basically another workspace.

## `WINDOWS AND WORKSPACES`

I added 2 rules. The first is for making my browser float. I think this is a sane default since when a browser opens up randomly from clicking on something, it doesn't reorganize your workspace (even if sometimes that window has a short lifespan). I'd rather have tiling on demand in the case of browsers by pressing `super + F` to turn my floating window into a tiling one.
