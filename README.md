# My dotfiles

I need to go through this entire readme as it was never finished, and is also now out of date since: 2024-12-09

## Structure

- **config**: stores my $XDG_CONFIG_HOME directories and files
- **pam_env.conf**: a system file located at /etc/security/pam_env.conf used to set my personal config variables such as my XDG_DIRS, ZDOTDIR, and EMAIL addresses

## Cloning onto a new system

- Before wiping/installing, create a github authorization token that expires after 1-7 days (finish everything by then).
- Save this token to a USB drive.
- Also make sure you backup your directories onto the USB drive as well.
- Now make sure to also update your installed packages by running your script and push that to github.
- Then create a fresh install. After your fresh install:

- Ensure the proper files are installed with this command:
    - Ensure you have network connectivity through ethernet or wifi. For wifi: nmcli device wifi list, then nmcli device wifi connect <device> --ask
    - **Arch Linux**: sudo pacman -S --needed alacritty zsh neovim git github-cli stow base base-devel man-db man-pages openssh xdg-user-dirs zsh-autosuggestions zsh-completions zsh-doc zsh-lovers zsh-syntax-highlighting zshdb
    - (optional/recommended) Then populate the Desktop Downloads, etc directories by running: xdg-user-dirs-update
    - configure github:
        - mkdir -p ~/.config/git
        - touch ~/.config/git/config
        - git config --global user.name "1337est"
        - git config --global user.email "59178218+1337est@users.noreply.github.com"
    - Authenticate with GitHub over SSH:
        - Follow the instructions here to generate a new SSH key: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
            - ssh-keygen -t ed25519 -C "59178218+1337est@users.noreply.github.com"
            - Accept defaults and enter a passphrase.
            - Start the ssh-agent in the background: eval "$(ssh-agent -s)"
            - Add your SSH private key to the ssh-agent: ssh-add ~/.ssh/id_ed25519
            - cat ~/.ssh/id_ed25519.pub (this is your public KEY-FILE)
        - Follow the instructions here to add the SSH key to github for your new device: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account?platform=linux&tool=cli
            - Enter : gh auth login --skip-ssh-key
            - Choose Github
            - Select SSH
            - Paste your authentication token from the usb drive
            - Add your SSH key to github: gh ssh-key add ~/.ssh/id_ed25519.pub --type authentication --title "My Laptop/MiniPC/Work/etc"
        - Test your ssh connection against githubs fingerprint to verify authentication: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/testing-your-ssh-connection
            - ssh -T git@github.com
            - Answer yes if the sha matches.
            - Everything SHOULD be good now for your new SSH token.
        - Now to create your gpg key for signing verification:
            - gpg --full-generate-key
            - go through the prompts until you get to your email address: 59178218+1337est@users.noreply.github.com
            - Create a secure passphrase (this can be the same or different from your SSH passphrase)
            - Type command: gpg --list-secret-keys --keyid-format=long
            - Ex Output:
            ```bash
                $ gpg --list-secret-keys --keyid-format=long
                /Users/hubot/.gnupg/secring.gpg
                ------------------------------------
                sec   4096R/3AA5C34371567BD2 2016-03-10 [expires: 2017-03-10]
                uid                          Hubot <hubot@example.com>
                ssb   4096R/4BB6D45482678BE3 2016-03-10
            ```
            - For this next section you want the long format after "sec". Example below
            - This output is what we're putting in a file: gpg --armor --export 3AA5C34371567BD2
            - Same command with 2 additions: gpg --output github.pgp --armor --export 3AA5C34371567BD2
            - now: gh gpg-key add github.pgp --title "My Laptop/MiniPC/Work/etc"
    - Create the directory to store your GitHub repos: mkdir -p ~/GitHub/{private,public}
    - Navigate to where you're keeping the dotfiles: cd ~/GitHub/public or cd ~/GitHub/private
    - Clone dotfiles via SSH instead of https with this command: git clone git@github.com:1337est/dotfiles.git (normally it's git clone https://github.com/1337est/dotfiles.git)
    - If this was successful, you can now remove the auto-generated gh directory that was added to your computer: rm -r ~/.config/gh
    - Time to stow everything:
        - cd ~/GitHub/private/dotfiles
        - stow config -t ~/.config
    - git clone scripts
    - Run the installer script to get all the applications on your computer
    - Move all the files from the usb to your computer.
    - add the pam_env.conf variables to /etc/security/pam_env.conf
    - add the neomutt.desktop file to ~/.local/share/applications
    - Add the pacman.conf file to /etc/pacman.conf
    - Add the ly.config.ini to /etc/ly/config.ini and ensure to `sudo systemctl enable ly` `sudo systemctl start ly`. This will bring up an instance of the ly display manager on tty2. You can switch back to tty1 (probably your default tty instance) by pressing Ctrl-Alt-F1 through F-6 (tty1 - tty6).
    - Add a section for nmcli, the way to connect to the internet via wifi etc
    Enable and start bluetooth, which provides the bluetoothctl tool
    - Currently using `nb` for my note taking. This currently is only available in the AUR, but I downloaded this time through:
    ```bash
    sudo wget https://raw.github.com/xwmx/nb/master/nb -O /usr/local/bin/nb &&
      sudo chmod +x /usr/local/bin/nb &&
      sudo nb completions install # For this command to work, root needs their $EDITOR set, see the pam_env.conf file and set $EDITOR there.
    ```
    - What I'm currently doing: In my ~/Dev/bin directory I have a file named ~/Dev/bin/nb-completion.zsh (taken from https://github.com/xwmx/nb/blob/master/etc/nb-completion.zsh). I have ~/Dev/bin added to my path in my .zshenv file. Now nb will have tab autosuggestions/complete. Also,
    - Another thing to note. nb pipes passphrases in from STDIN with gpg using `--passphrase-fd 0`. This is no longer supported as of GnuPG 2.1.0 and the use of gpg-agent and pinentry is required which does break the shell when gpg gets involved... Therefore You need to add to ~/.gnupg/gpg-agent.conf:
    ```
    allow-loopback-pinentry
    ```
    - Then also add to ~/.gnupg/gpg.conf:
    ```
    pinentry-mode loopback
    ```
    - Now either reload the gpg-agent by running `gpg-connect-agent reloadagent /bye` (the command should print `OK`), or reboot your computer, which we're doing soon anyways!
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
    - I'm using nnn as my file manager and although you can just download the program using pacman, to get fonts and other things working, you'll need to clone the git repo and make compile with various settings.
    ```bash
    git clone https://github.com/jarun/nnn.git
    cd nnn
    sudo make O_NERD=1
    sudo cp nnn /bin
    ```
    - I use the XDG Base Directory Specification for my workflow, which includes an:
        - $XDG_DATA_HOME - defines the base directory relative to which user-specific data files should be stored. If $XDG_DATA_HOME is either not set or empty, a default equal to $HOME/.local/share should be used.
        - $XDG_CONFIG_HOME - defines the base directory relative to which user-specific configuration files should be stored. If $XDG_CONFIG_HOME is either not set or empty, a default equal to $HOME/.config should be used.
        - $XDG_STATE_HOME - defines the base directory relative to which user-specific state files should be stored. If $XDG_STATE_HOME is either not set or empty, a default equal to $HOME/.local/state should be used. The $XDG_STATE_HOME contains state data that should persist between (application) restarts, but that is not important or portable enough to the user that it should be stored in $XDG_DATA_HOME. It may contain:
            - actions history (logs, history, recently used files, …)
            - current state of the application that can be reused on a restart (view, layout, open files, undo history, …)
        - $XDG_CACHE_HOME - defines the base directory relative to which user-specific non-essential data files should be stored. If $XDG_CACHE_HOME is either not set or empty, a default equal to $HOME/.cache should be used.
        - User-specific executable files may be stored in $HOME/.local/bin. Distributions should ensure this directory shows up in the UNIX $PATH environment variable, at an appropriate place. Since $HOME might be shared between systems of different architectures, installing compiled binaries to $HOME/.local/bin could cause problems when used on systems of differing architectures. This is often not a problem, but the fact that $HOME becomes partially architecture-specific if compiled binaries are placed in it should be kept in mind.

    - reboot your computer.
