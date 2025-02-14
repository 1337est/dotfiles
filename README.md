# Directory Structure of ~
This is the directory structure of the `$HOME` or `~` directory. Each directory listed is of important when it comes to configuring my personal dotfiles and is important for synchronization between computer systems (e.g. personal laptop/computer, work computer, etc.) The details are below as a per directory explanation.

## **XDG User Directories**

I'm also using the `xdg-user-dirs` utility to create common directories such as: `Desktop`, `Documents`, `Downloads`, `Music`, `Pictures`, `Public`, `Templates`, and `Videos`, as well as a personal `Code` directory. More info on how the `xdg-user-dirs` utility works can be found [here](https://wiki.archlinux.org/title/XDG_user_directories)

[//]: # (TODO I need to go through this entire readme as it was never finished, and is also now out of date since: 2024-12-09)

## **XDG Base Directories**

I'm following the XDG directory standard for `~/.config` `~/.local/share`, `~/.local/state`, `~/.cache`, and `~/.local/bin`. A brief intro to the XDG Base Directories Specification can be found [here](https://specifications.freedesktop.org/basedir-spec/latest/)

## Directory Structure of this repo

- **config**: stores my $XDG_CONFIG_HOME directories and files
- **archive**: has old configs that I didn't want to delete
- **resources**: stores the resources needed for the config

## Things to do

- Added microsoft ttf files. What I did to get them on my system:
    1. Download the microsoft 11 iso from there website into the ~/Downloads directory.
    2. Issue these commands to extract the fonts:
    ```bash
    $ cd ~/Downloads
    $ 7z e WinXY_YYMM_English_x64.iso sources/install.wim
    $ 7z e install.wim 1/Windows/{Fonts/"*".{ttf,ttc},System32/Licenses/neutral/"*"/"*"/license.rtf} -ofonts/
    $ cd ~/Downloads/fonts
    $ sudo mkdir /usr/local/share/fonts
    $ sudo mkdir /usr/local/share/fonts/WindowsFonts
    $ sudo cp ./* /usr/local/share/fonts/WindowsFonts
    $ sudo chmod 644 /usr/local/share/fonts/WindowsFonts/*
    $ sudo fc-cache --force
    $ sudo fc-cache-32 --force # Ensure multilib is enabled in pacman.conf and you have lib32-fontconfig downloaded
    ```
    3. Now you should have microsoft fonts on your system
- I use the XDG Base Directory Specification for my workflow, which includes an:
    - $XDG_DATA_HOME - defines the base directory relative to which user-specific data files should be stored. If $XDG_DATA_HOME is either not set or empty, a default equal to $HOME/.local/share should be used.
    - $XDG_CONFIG_HOME - defines the base directory relative to which user-specific configuration files should be stored. If $XDG_CONFIG_HOME is either not set or empty, a default equal to $HOME/.config should be used.
    - $XDG_STATE_HOME - defines the base directory relative to which user-specific state files should be stored. If $XDG_STATE_HOME is either not set or empty, a default equal to $HOME/.local/state should be used. The $XDG_STATE_HOME contains state data that should persist between (application) restarts, but that is not important or portable enough to the user that it should be stored in $XDG_DATA_HOME. It may contain:
        - actions history (logs, history, recently used files, …)
        - current state of the application that can be reused on a restart (view, layout, open files, undo history, …)
    - $XDG_CACHE_HOME - defines the base directory relative to which user-specific non-essential data files should be stored. If $XDG_CACHE_HOME is either not set or empty, a default equal to $HOME/.cache should be used.
    - User-specific executable files may be stored in $HOME/.local/bin. Distributions should ensure this directory shows up in the UNIX $PATH environment variable, at an appropriate place. Since $HOME might be shared between systems of different architectures, installing compiled binaries to $HOME/.local/bin could cause problems when used on systems of differing architectures. This is often not a problem, but the fact that $HOME becomes partially architecture-specific if compiled binaries are placed in it should be kept in mind.

- reboot your computer.
