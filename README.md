# My dotfiles

[//]: # (TODO I need to go through this entire readme as it was never finished, and is also now out of date since: 2024-12-09)

## Directory Structure of ~
This is the directory structure of the `$HOME` or `~` directory. Each directory listed is of important when it comes to configuring my personal dotfiles and is important for synchronization between computer systems (e.g. personal laptop/computer, work computer, etc.) The details are below as a per directory explanation.

### XDG Base Directories

A short specification to the XDG Base Directories can be found [here](https://specifications.freedesktop.org/basedir-spec/latest/){:target="_blank"}:
### **`Videos`**

A directory for organizing video files, such as tutorials, movies, and personal recordings. Applications that use this directory include: TODO: mpv, swappy?, etc

```bash
 adrian
├──  Videos
```

### **`Templates`**

Contains template files for quick use.

```bash
 adrian
├──  Templates
│   ├──  Makefile.vulkan
│   ├──  Makefile
│   └──  .clang-format
```

- **`Makefile.vulkan`**
  A template for Vulkan-specific projects.
- **`.clang-format`**
  A pre-configured Clang format template for code styling.

### **`Public`**

A public directory used for sharing files with other users or systems.

```bash
 adrian
├──  Public
```

### **`Pictures`**

Used for organizing images. Subdirectories categorize the types of images stored:

```bash
 adrian
├── 󰉏 Pictures
│   ├──  Wallpapers
│   ├──  Screenshots
│   ├──  Profile
│   ├──  Phone
│   ├──  Icons
│   ├──  Camera
```

- **`Pictures/Camera`**
  Photos taken with a camera.
- **`Pictures/Icons`**
  Custom and downloaded icons for UI or other design purposes.
- **`Pictures/Phone`**
  Photos and screenshots transferred from a phone.
- **`Pictures/Profile`**
  Profile pictures for various accounts or applications.
- **`Pictures/Screenshots`**
  Screenshots captured on the system.
- **`Pictures/Wallpapers`**
  A collection of desktop and mobile wallpapers.

### **`Music`**

A directory dedicated to music files, including albums, playlists, and personal recordings.

```bash
 adrian
├── 󱍙 Music
```

### **`Downloads`**

The default location for downloaded files. Files are typically moved from here to their respective permanent locations.

```bash
 adrian
├── 󰉍 Downloads
```

### **`Documents`**

This directory is used for storing important documents and is further categorized:

```bash
 adrian
├──  Documents
│   ├──  work
│   ├──  school
```

- **`Documents/work`**
  Work-related documents, such as reports, meeting notes, and proposals.

- **`Documents/school`**
  Contains academic materials, assignments, and other school-related documents.

### **`Desktop`**

The desktop environment folder. Frequently used for temporary organization and ongoing work. It also includes:

```bash
 adrian
├──  Desktop
│   ├──  neorg
│   │   ├──  work
│   │   ├──  school
│   │   │   └──  index.norg
│   │   ├──  rum
│   │   │   ├──  timestop.norg
│   │   │   ├──  the_awakener.norg
│   │   │   ├──  quotes.norg
│   │   │   ├──  kids.norg
│   │   │   └──  cogito_libri_sapientiae.norg
│   │   ├──  research
│   │   │   ├──  nvim.norg
│   │   │   └──  index.norg
│   │   ├──  projects
│   │   ├──  notes
│   │   │   ├──  todo.norg
│   │   │   └──  index.norg
│   │   ├──  ideas
│   │   │   ├──  terminal_platformer.norg
│   │   │   ├──  shapes.norg
│   │   │   ├──  reflection.norg
│   │   │   └──  brrito.norg
│   │   ├──  help
│   │   │   ├──  vim-guide.norg
│   │   │   ├──  new_arch_install.norg
│   │   │   └──  bluetooth_issues.norg
│   │   └──  index.norg
```

- **`Desktop/neorg`**
  A directory specifically for managing Neorg files. Subdirectories within contain structured notes for work, school, projects, research, and personal ideas.

### **`Code`**

This directory contains all coding-related projects and research. It's divided into subdirectories for better organization:

```bash
 adrian
├──  Code
│   ├──  research
│   ├──  projects
│   └──  github
│       └──  dotfiles
```

- **`Code/github`**
  This is where personal GitHub repositories are stored, including configuration files and personal projects.

- **`Code/github/dotfiles`**
  A GitHub repository containing configuration files (dotfiles) for various tools and applications. These are symlinked into the `.config` directory for easy management and version control.

### **`.ssh`**

This directory stores SSH-related configuration and key files. It includes private and public keys, known hosts, and SSH configuration files necessary for secure remote connections.

```bash
 adrian
├── 󰢬 .ssh
```

### **`.password-store`**

A directory used by the `pass` utility to store encrypted password files. Each entry corresponds to a file encrypted with GPG, organizing credentials securely.

```bash
 adrian
├──  .password-store
```

### **`.mozilla`**

Contains profiles and data for Mozilla-based applications, such as Firefox. This includes bookmarks, extensions, cookies, and other user-specific settings.

```bash
 adrian
├──  .mozilla
```

### **`$XDG_STATE_HOME/zsh`**

Stores Zsh state files, such as command history. This ensures persistent and organized shell session tracking.

```bash
 adrian
├──  .local
│   ├──  state
│   │   ├──  zsh
│   │   │   └──  history
```

### **`$XDG_STATE_HOME/nvim`**

Contains Neovim state files, such as undo history, swap files, and logs. This directory enhances Neovim's ability to recover and track session states.

```bash
 adrian
├──  .local
│   ├──  state
│   │   ├──  nvim
│   │   │   ├──  undodir
│   │   │   ├──  swap
│   │   │   ├──  lazy
│   │   │   ├──  log
```

### **`$XDG_STATE_HOME/neomutt`**

Stores state files for Neomutt, such as cached searches and session metadata. This ensures efficient email management and search operations.

```bash
 adrian
├──  .local
│   ├──  state
│   │   ├──  neomutt
│   │   │   └──  notmuch_search_queries
```

### **`$XDG_STATE_HOME/msmtp`**

Holds logs and state information for the msmtp email client, such as sent email logs. This aids in debugging and usage tracking.

```bash
 adrian
├──  .local
│   ├──  state
│   │   ├──  msmtp
│   │   │   └──  msmtp.log
```

### **`$XDG_STATE_HOME/files`**

Contains state files for various tools, such as the history file for `less`. These files enhance session persistence and user experience.

```bash
 adrian
├──  .local
│   ├──  state
│   │   └──  lesshst
```

### **`$XDG_DATA_HOME/zoxide`**

Stores the `zoxide` database, which tracks frequently used directories for fast navigation. The database file improves productivity by enabling smart `cd` commands.

```bash
 adrian
├──  .local
│   ├──  share
│   │   ├──  zoxide
│   │   │   └──  db.zo
```

### **`$XDG_DATA_HOME/vdirsyncer`**

Contains data for `vdirsyncer`, including tokens, status files, and synchronized contacts/calendars. This directory is crucial for managing calendar and contact synchronization.

```bash
 adrian
├──  .local
│   ├──  share
│   │   ├──  vdirsyncer
│   │   │   ├──  tokens
│   │   │   ├──  status
│   │   │   │   ├──  adrian_contacts
│   │   │   │   ├──  adrian_calendar
│   │   │   │   ├──  adrian_contacts.collections
│   │   │   │   └──  adrian_calendar.collections
│   │   │   ├──  contacts
│   │   │   └──  calendars
```

### **`$XDG_DATA_HOME/nvim`**

Holds Neovim data files, including plugin installations, runtime metadata, and log files. This directory enables plugin management and debugging.

```bash
 adrian
├──  .local
│   ├──  share
│   │   ├──  nvim
│   │   │   ├──  mason
│   │   │   ├──  lazy-rocks
│   │   │   ├──  lazy
│   │   │   │   ├──  onedark.nvim
│   │   │   │   ├──  neorg
│   │   │   │   ├──  lazy.nvim
│   │   │   ├──  neorg.mpack
│   │   │   └──  neorg.log
```

### **`$XDG_DATA_HOME/mail`**

Contains email storage for local accounts, organized into folders like Inbox, Sent, and Trash. It is used by email clients for mail synchronization.

```bash
 adrian
├──  .local
│   ├──  share
│   │   ├── 󰇰 mail
│   │   │   ├──  email_5
│   │   │   │   ├──  Trash
│   │   │   │   ├──  Sent
│   │   │   │   ├──  INBOX
│   │   │   │   └──  Drafts
│   │   │   ├──  email_4
│   │   │   │   ├──  Trash
│   │   │   │   ├──  Sent
│   │   │   │   ├──  INBOX
│   │   │   │   └──  Drafts
│   │   │   ├──  email_3
│   │   │   │   ├──  Trash
│   │   │   │   ├──  Sent
│   │   │   │   ├──  INBOX
│   │   │   │   └──  Drafts
│   │   │   ├──  email_2
│   │   │   │   ├──  Trash
│   │   │   │   ├──  Sent
│   │   │   │   ├──  INBOX
│   │   │   │   └──  Drafts
│   │   │   └──  email_1
│   │   │       ├──  Trash
│   │   │       ├──  Sent
│   │   │       ├──  INBOX
│   │   │       └──  Drafts
```

### **`$XDG_DATA_HOME/libs`**

Stores header files for libraries used in projects. These include third-party libraries like `stb` and `tinyobjloader`, simplifying dependency management.

```bash
 adrian
├──  .local
│   ├──  share
│   │   ├──  libs
│   │   │   ├──  tinyobjloader
│   │   │   │   └──  tiny_obj_loader.h
│   │   │   └──  stb
│   │   │       └──  stb_image.h
```

### **`$XDG_DATA_HOME/applications`**

Contains `.desktop` entries for applications, enabling them to appear in menus or launchers. It includes a Neomutt launcher and MIME type associations.

```bash
 adrian
├──  .local
│   ├──  share
│   │   ├──  applications
│   │   │   ├──  neomutt.desktop
│   │   │   └──  mimeinfo.cache
```

### **`$XDG_DATA_HOME/files`**

Stores metadata for recently used files, allowing applications to track and display file usage.

```bash
 adrian
├──  .local
│   ├──  share
│   │   └──  recently-used.xbel
```

### **`~/.local/bin`**

A directory for user-specific executables. It includes scripts and binaries not installed system-wide.

```bash
 adrian
├──  .local
│   └──  bin
```

### **`.gnupg`**

The `.gnupg` directory contains configuration and key files used by GnuPG (GNU Privacy Guard) for encryption, signing, and verification of data. It stores private keys, public keys, and settings for the `gpg-agent`. For example, `gpg-agent.conf` contains user-defined configurations for the GPG agent.

```bash
 adrian
├── 󰢬 .gnupg
│   └──  gpg-agent.conf
```

### **`$XDG_CACHE_HOME`**

The `$XDG_CACHE_HOME` directory is used to store non-essential cached data that can be regenerated if deleted. This directory improves performance by caching frequently accessed data for applications. Examples include shader caches, command histories, and temporary build files.

```bash
 adrian
└── 󰃨 .cache
    ├──  wget
    ├──  nvim
    ├──  npm
    ├──  neomutt
    ├──  mpv
    ├──  mozilla
    ├──  mesa_shader_cache_db
    ├──  mesa_shader_cache
    ├──  luarocks
    ├──  kitty
    ├──  go-build
    ├──  go
    ├──  gegl-0.4
    ├──  fontconfig
    ├──  babl
    └──  .bluetoothctl_history
```

### **`$XDG_CONFIG_HOME`**

Description here

```bash
 adrian
├──  .config
│   ├──  zsh ⇒ ../Code/github/dotfiles/config/zsh
│   ├──  zathura ⇒ ../Code/github/dotfiles/config/zathura
│   ├──  wget ⇒ ../Code/github/dotfiles/config/wget
│   ├──  vdirsyncer ⇒ ../Code/github/dotfiles/config/vdirsyncer
│   ├──  sway ⇒ ../Code/github/dotfiles/config/sway
│   ├──  swappy ⇒ ../Code/github/dotfiles/config/swappy
│   ├──  qalculate
│   ├──  pulse
│   ├──  nvim ⇒ ../Code/github/dotfiles/config/nvim
│   ├──  npm ⇒ ../Code/github/dotfiles/config/npm
│   ├──  notmuch ⇒ ../Code/github/dotfiles/config/notmuch
│   ├──  nnn ⇒ ../Code/github/dotfiles/config/nnn
│   ├──  neomutt ⇒ ../Code/github/dotfiles/config/neomutt
│   ├──  msmtp ⇒ ../Code/github/dotfiles/config/msmtp
│   ├──  mpv ⇒ ../Code/github/dotfiles/config/mpv
│   ├──  libreoffice
│   ├──  lazygit
│   ├──  kitty ⇒ ../Code/github/dotfiles/config/kitty
│   ├──  khard ⇒ ../Code/github/dotfiles/config/khard
│   ├──  khal ⇒ ../Code/github/dotfiles/config/khal
│   ├──  isync ⇒ ../Code/github/dotfiles/config/isync
│   ├──  gtk-3.0
│   ├──  go
│   ├──  git ⇒ ../Code/github/dotfiles/config/git
│   ├──  gh
│   ├──  dconf
│   ├──  clangd ⇒ ../Code/github/dotfiles/config/clangd
│   ├──  audacity
│   ├──  user-dirs.locale ⇒ ../Code/github/dotfiles/config/user-dirs.locale
│   ├──  user-dirs.dirs ⇒ ../Code/github/dotfiles/config/user-dirs.dirs
│   └──  mimeapps.list ⇒ ../Code/github/dotfiles/config/mimeapps.list
```

## Directory Structure of: dotfiles

```bash
 Code/github/dotfiles
├──  config
│   ├──  clangd
│   ├──  git
│   ├──  isync
│   ├──  khal
│   ├──  khard
│   ├──  kitty
│   ├──  mpv
│   ├──  msmtp
│   ├──  neomutt
│   ├──  nnn
│   ├──  notmuch
│   ├──  npm
│   ├──  nvim
│   ├──  swappy
│   ├──  sway
│   ├──  vdirsyncer
│   ├──  wget
│   ├──  zathura
│   ├──  zsh
│   ├──  mimeapps.list
│   ├──  user-dirs.dirs
│   └──  user-dirs.locale
├──  resources
│   └──  MicrosoftFonts
├──  sync
│   └──  archsetup
├──  system
│   ├──  ly.config.ini
│   ├──  neomutt.desktop
│   ├──  pacman.conf
│   └──  pam_env.conf
└──  README.md
```

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
