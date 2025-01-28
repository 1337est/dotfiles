# To learn more about a particular setting, run any of these terminal commands:
# config nu --doc # for output into the terminal
# config nu --doc | nu-highlight | less -R # for viewing in the terminal
# config nu --doc out> ~/path/to/file # for saving the output to a file

# ------------------------
# History-related settings
# ------------------------
# $env.config.history

$env.config.history = {
    max_size: 5_000_000,
    sync_on_enter: true,
    file_format: "sqlite",
    isolation: true
}

# ----------------------
# Miscellaneous Settings
# ----------------------

$env.config.show_banner = false
$env.config.rm.always_trash = false
$env.config.recursion_limit = 50

# ---------------------------
# Commandline Editor Settings
# ---------------------------

$env.config.edit_mode = "vi"
$env.config.buffer_editor = "editor"
$env.config.cursor_shape.emacs = "inherit"         # Cursor shape in emacs mode
$env.config.cursor_shape.vi_insert = "blink_block"       # Cursor shape in vi-insert mode
$env.config.cursor_shape.vi_normal = "block"  # Cursor shape in normal vi mode

# --------------------
# Completions Behavior
# --------------------

$env.config.completions = {
    sort: "smart"
    case_sensitive: false
    quick: true
    partial: true
    algorithm: "prefix"
    external: {
        enable: true
        max_results: 100
        completer: {|spans|
            carapace $spans.0 nushell ...$spans | from json
        }
    }
    use_ls_colors: true
}

# --------------------
# Terminal Integration
# --------------------
# Nushell can output a number of escape codes to enable advanced features in Terminal Emulators
# that support them. Settings in this section enable or disable these features in Nushell.
# Features aren't supported by your Terminal can be disabled. Features can also be disabled,
#  of course, if there is a conflict between the Nushell and Terminal's implementation.

# use_kitty_protocol (bool):
# A keyboard enhancement protocol supported by the Kitty Terminal. Additional keybindings are
# available when using this protocol in a supported terminal. For example, without this protocol,
# Ctrl+I is interpreted as the Tab Key. With this protocol, Ctrl+I and Tab can be mapped separately.
$env.config.use_kitty_protocol = false

# osc2 (bool):
# When true, the current directory and running command are shown in the terminal tab/window title.
# Also abbreviates the directory name by prepending ~ to the home directory and its subdirectories.
$env.config.shell_integration.osc2 = true

# osc7 (bool):
# Nushell will report the current directory to the terminal using OSC 7. This is useful when
# spawning new tabs in the same directory.
$env.config.shell_integration.osc7 = true

# osc9_9 (bool):
# Enables/Disables OSC 9;9 support, originally a ConEmu terminal feature. This is an
# alternative to OSC 7 which also communicates the current path to the terminal.
$env.config.shell_integration.osc9_9 = false

# osc8 (bool):
# When true, the `ls` command will generate clickable links that can be launched in another
# application by the terminal.
# Note: This setting replaces the now deprecated `ls.clickable_links`
$env.config.shell_integration.osc8 = true

# Deprecated
# $env.config.ls.clickable_links = true

# osc133 (bool):
# true/false to enable/disable OSC 133 support, a set of several escape sequences which
# report the (1) starting location of the prompt, (2) ending location of the prompt,
# (3) starting location of the command output, and (4) the exit code of the command.

# originating with Final Term. These sequences report information regarding the prompt
# location as well as command status to the terminal. This enables advanced features in
# some terminals, including the ability to provide separate background colors for the
# command vs. the output, collapsible output, or keybindings to scroll between prompts.
$env.config.shell_integration.osc133 = true

# osc633 (bool):
# true/false to enable/disable OSC 633, an extension to OSC 133 for Visual Studio Code
$env.config.shell_integration.osc633 = true

# reset_application_mode (bool):
# true/false to enable/disable sending ESC[?1l to the terminal
# This sequence is commonly used to keep cursor key modes in sync between the local
# terminal and a remove SSH host.
$env.config.shell_integration.reset_application_mode = true

# bracketed_paste (bool):
# true/false to enable/disable the bracketed-paste feature, which allows multiple-lines
# to be pasted into Nushell at once without immediate execution. When disabled,
# each pasted line is executed as it is received.
# Note that bracketed paste is not currently supported on the Windows version of
# Nushell.
$env.config.bracketed_paste = true

# use_ansi_coloring (bool):
# true/false to enable/disable the use of ANSI colors in Nushell internal commands.
# When disabled, output from Nushell built-in commands will display only in the default
# foreground color.
# Note: Does not apply to the `ansi` command.
$env.config.use_ansi_coloring = true

#####################################################################################################

use std/util "path add"
path add "~/.local/bin"

# You can remove duplicate directories from the path using:
$env.PATH = ($env.PATH | uniq)

let $ENV_VARS = [
    # basic and app specific environment values
    [
        # pager
        { name: "PAGER", value: 'bat' },
        { name: "MANPAGER", value: 'nvim +Man!' },
        { name: "MANWIDTH", value: 999 },

        # editor
        { name: "EDITOR", value: 'nvim' },
        { name: "VISUAL", value: 'nvim' },

        # terminal
        { name: "TERM", value: 'ghostty' },

        # browser
        { name: "BROWSER", value: "vivaldi" },

        # npm
        { name: "NPM_CONFIG_USERCONFIG", value: ($env.XDG_CONFIG_HOME | path join 'npm/npmrc') },

        # Node.js
        { name: "NODE_REPL_HISTORY", value: '' },

        # Grim
        { name: "GRIM_DEFAULT_DIR", value: ($env.HOME | path join 'Pictures/screenshots') },

        # wget
        { name: "WGETRC", value: ($env.XDG_CONFIG_HOME | path join 'wget/wgetrc') },

        # GPG
        { name: "GNUPGHOME", value: ($env.XDG_DATA_HOME | path join 'gnupg') },
        { name: "GPG_TTY", value: (tty) }, # Get the current tty dynamically

        # pass
        { name: "PASSWORD_STORE_DIR", value: ($env.XDG_DATA_HOME | path join 'pass') },

        # nnn
        { name: "NNN_SSHFS", value: "sshfs -o follow_symlinks" },
        { name: "NNN_COLORS", value: "2136" },
        { name: "NNN_TRASH", value: "1" },
        { name: "NNN_PLUG", value: "p:preview-tui" },
        { name: "NNN_FIFO", value: "/tmp/nnn.fifo" }
    ]
    # environment values and paths that need to be generated if not present
    [
        # XDG_COMMON_DIRS
        { name: "DESKTOP_DIR", path: ($env.HOME | path join 'Desktop') },
        { name: "DOCUMENTS_DIR", path: ($env.HOME | path join 'Documents') },
        { name: "DOWNLOAD_DIR", path: ($env.HOME | path join 'Downloads') },
        { name: "MUSIC_DIR", path: ($env.HOME | path join 'Music') },
        { name: "PICTURES_DIR", path: ($env.HOME | path join 'Pictures') },
        { name: "PUBLICSHARE_DIR", path: ($env.HOME | path join 'Public') },
        { name: "TEMPLATES_DIR", path: ($env.HOME | path join 'Templates') },
        { name: "VIDEOS_DIR", path: ($env.HOME | path join 'Videos') }

        # USER_CODE_DIRS
        { name: "CODE_DIR", path: ($env.HOME | path join 'Code') },
        { name: "GITHUB_DIR", path: ($env.HOME | path join 'Code/github') },
        { name: "LEET_DIR", path: ($env.HOME | path join 'Code/leet') },
        { name: "PROJECTS_DIR", path: ($env.HOME | path join 'Code/projects') },
        { name: "RESEARCH_DIR", path: ($env.HOME | path join 'Code/research') },

        # USER_DESKTOP_DIRS
        { name: "SCHOOL_DIR", path: ($env.HOME | path join 'Desktop/school') },
        { name: "WORK_DIR", path: ($env.HOME | path join 'Desktop/work') },

        # USER_PICTURES_DIRS
        { name: "CAMERA_DIR", path: ($env.HOME | path join 'Pictures/camera') },
        { name: "ICONS_DIR", path: ($env.HOME | path join 'Pictures/icons') },
        { name: "PHONE_DIR", path: ($env.HOME | path join 'Pictures/phone') },
        { name: "PROFILE_DIR", path: ($env.HOME | path join 'Pictures/profile') },
        { name: "SCREENSHOTS_DIR", path: ($env.HOME | path join 'Pictures/screenshots') },
        { name: "WALLPAPERS_DIR", path: ($env.HOME | path join 'Pictures/wallpapers') },

        # USER_BIN_DIR
        { name: "BIN_DIR", path: ($env.HOME | path join '.local/bin') },

        # USER_LIB_DIR
        { name: "LIB_DIR", path: ($env.HOME | path join '.local/lib') }

        # Go
        { name: "GOPATH", path: ($env.XDG_DATA_HOME | path join 'go') },

        # My mail directories
        { name: "MYMAILDIR", path: ($env.XDG_DATA_HOME | path join 'mail') },
    ],
]

# Iterate over the directory definitions to export variables and create directories
for entry in $ENV_VARS.0 {
    load-env { $entry.name: $entry.value }
}
for entry in $ENV_VARS.1 {
    load-env { $entry.name: $entry.path }
    mkdir $entry.path
    if $entry.name == "MYMAILDIR" {
        for acct in [ "email_1" "email_2" "email_2" "email_4" ] {
            for box in [ "INBOX" "Drafts" "Sent" "Trash" ] {
                for cnt in [ "cur" "new" "tmp" ] {
                    mkdir ($entry.path | path join $acct | path join $box | path join $cnt)
                }
            }
        }
    }
}

# starship prompt
###############################################################################
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

$env.STARSHIP_SHELL = "nu"

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ": "
$env.PROMPT_INDICATOR_VI_NORMAL = "〉"
$env.PROMPT_MULTILINE_INDICATOR = "::: "

# carapace
source ~/.cache/carapace/init.nu

# Enabling zoxide
source ~/.local/share/zoxide/db.nu
