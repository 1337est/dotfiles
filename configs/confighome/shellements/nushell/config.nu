# To learn more about a particular setting, run any of these terminal commands:
# config nu --doc # for output into the terminal
# config nu --doc | nu-highlight | less -R # for viewing in the terminal
# config nu --doc out> ~/path/to/file # for saving the output to a file

# ------------------------------------------------------------------------------
# Nushell Config
# ------------------------------------------------------------------------------

# History-related settings -----------------------------------------------------

$env.config.history = {
    max_size: 5_000_000
    sync_on_enter: true
    file_format: "sqlite"
    isolation: true
}

# Miscellaneous Settings -------------------------------------------------------

$env.config.show_banner = false
$env.config.rm.always_trash = false
$env.config.recursion_limit = 50

# Commandline Editor Settings --------------------------------------------------

$env.config.edit_mode = "vi"
$env.config.buffer_editor = "editor"
$env.config.cursor_shape = {
    emacs: "inherit"         # Cursor shape in emacs mode
    vi_insert: "blink_block"       # Cursor shape in vi-insert mode
    vi_normal: "block"  # Cursor shape in normal vi mode
}

# Completions Behavior ---------------------------------------------------------

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
            let carapace_completer = {|spans: list<string>|
                carapace $spans.0 nushell ...$spans
                | from json
                | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
            }

            let expanded_alias = scope aliases
            | where name == $spans.0
            | get -i 0.expansion

            let spans = if $expanded_alias != null {
                $spans
                | skip 1
                | prepend ($expanded_alias | split row ' ' | take 1)
            } else {
                $spans
            }

            match $spans.0 {
                _ => $carapace_completer
            } | do $in $spans
        }
    }
    use_ls_colors: true
}

# Keybindings ------------------------------------------------------------------

# keybindings (list): A list of user-defined keybindings
# Nushell/Reedline keybindings can be added or overridden using this setting.
# See https://www.nushell.sh/book/line_editor.html#keybindings for details.

$env.config.keybindings ++= [
    # vim keybinds to cycle through completion menu
    {
        name: completion_menu
        modifier: control
        keycode: char_n
        mode: [emacs vi_normal vi_insert]
        event: {
            until: [
                { send: menu name: completion_menu }
                { send: menunext }
            ]
        }
    },
    {
        name: completion_menu
        modifier: control
        keycode: char_p
        mode: [emacs vi_normal vi_insert]
        event: {
            until: [
                { send: menu name: completion_menu }
                { send: menuprevious }
            ]
        }
    },
    # vim keybindings to accept selection
    # TODO: remove Enter select (currently not working)
    {
        name: completion_menu
        modifier: none
        keycode: enter
        mode: [emacs vi_normal vi_insert]
        event: null
    },
    {
        name: completion_menu
        modifier: control
        keycode: char_y
        mode: [emacs vi_normal vi_insert]
        event: { send: Enter }
    },
]

# Menus ------------------------------------------------------------------------

$env.config.menus ++= [
]

# Terminal Integration ---------------------------------------------------------

$env.config.use_kitty_protocol = false
$env.config.shell_integration = {
    osc2: true
    osc7: true
    osc9_9: false
    osc8: true
    osc133: true
    osc633: true
    reset_application_mode: true
}
$env.config.bracketed_paste = true
$env.config.use_ansi_coloring = true

# Error Display Settings -------------------------------------------------------

$env.config.error_style = "fancy"
$env.config.display_errors = {
    exit_code: false
    termination_signal: true
}

# Table Display ----------------------------------------------------------------

$env.config.footer_mode = 25
$env.config.table = {

    mode: "default"
    index_mode: "always"
    show_empty: false
    padding: {
        left: 0
        right: 0
    }
    trim: {
        methodology: "wrapping"
        wrapping_try_keep_words: true
    }
    header_on_separator: false
    abbreviated_row_count: null
    footer_inheritance: false
}

# Datetime Display -------------------------------------------------------------

$env.config.datetime_format = {
    normal: "%m/%d/%y %I:%M:%S%p"
    table: null
}

# Filesize Display -------------------------------------------------------------

$env.config.filesize = {
    unit: metric
    precision: 1
}

# Miscellaneous Display --------------------------------------------------------

$env.config.render_right_prompt_on_last_line = false
$env.config.float_precision = 2
$env.config.ls.use_ls_colors = true
$env.config.hooks = {
    pre_prompt: []
    pre_execution: []
    env_change: {
        PWD: [{|before, after| null }]
    }
    display_output: "if (term size).columns >= 100 { table -e } else { table }"
    command_not_found: []
}

# ------------------------------------------------------------------------------
# Aliases
# ------------------------------------------------------------------------------

alias sanch = himalaya -c ~/.config/himalaya/accounts/sanch.toml
alias leet = himalaya -c ~/.config/himalaya/accounts/leet.toml
alias spag = himalaya -c ~/.config/himalaya/accounts/spag.toml
alias sbc = himalaya -c ~/.config/himalaya/accounts/sbc.toml
alias define = dict -d wn
alias synonym = dict -d moby-thesaurus
alias git-yoyo = ~/.config/nushell/scripts/git/yoyo.nu
alias stow-clean = ~/.config/nushell/scripts/stow/clean.nu

# ------------------------------------------------------------------------------
# Environment Variables
# ------------------------------------------------------------------------------

# Default Program Variables ----------------------------------------------------

$env.EDITOR     = 'nvim'
$env.VISUAL     = 'nvim'
$env.TERM       = 'ghostty'
$env.SHELL      = 'nu'
$env.PAGER      = 'bat'
$env.MANPAGER   = 'nvim +Man!'
$env.MANWIDTH   = 999
$env.BROWSER    = 'brave'
$env.ESCDELAY   = 0
$env.LANG       = 'en_US.UTF-8'

# XDG Base Directories ---------------------------------------------------------

$env.XDG_CONFIG_HOME    = ($env.HOME | path join '.config')
$env.XDG_CACHE_HOME     = ($env.HOME | path join '.cache')
$env.XDG_DATA_HOME      = ($env.HOME | path join '.local/share')
$env.XDG_STATE_HOME     = ($env.HOME | path join '.local/state')
$env.XDG_BIN_HOME       = ($env.HOME | path join '.local/bin')
$env.XDG_LIB_HOME       = ($env.HOME | path join '.local/lib')
mkdir $env.XDG_CONFIG_HOME
mkdir $env.XDG_CACHE_HOME
mkdir $env.XDG_DATA_HOME
mkdir $env.XDG_STATE_HOME
mkdir $env.XDG_BIN_HOME
mkdir $env.XDG_LIB_HOME

# XDG/MY_USER_DIRS -------------------------------------------------------------

$env.XDG_DESKTOP_DIR        = ($env.HOME | path join 'Desktop')
$env.XDG_DOCUMENTS_DIR      = ($env.HOME | path join 'Documents')
$env.XDG_DOWNLOAD_DIR       = ($env.HOME | path join 'Downloads')
$env.XDG_MUSIC_DIR          = ($env.HOME | path join 'Music')
$env.XDG_PICTURES_DIR       = ($env.HOME | path join 'Pictures')
$env.XDG_PUBLICSHARE_DIR    = ($env.HOME | path join 'Public')
$env.XDG_TEMPLATES_DIR      = ($env.HOME | path join 'Templates')
$env.XDG_VIDEOS_DIR         = ($env.HOME | path join 'Videos')
mkdir $env.XDG_DESKTOP_DIR
mkdir $env.XDG_DOCUMENTS_DIR
mkdir $env.XDG_DOWNLOAD_DIR
mkdir $env.XDG_MUSIC_DIR
mkdir $env.XDG_PICTURES_DIR
mkdir $env.XDG_PUBLICSHARE_DIR
mkdir $env.XDG_TEMPLATES_DIR
mkdir $env.XDG_VIDEOS_DIR

# MY Personal Directories ------------------------------------------------------

$env.MY_CODE_DIR    = ($env.HOME | path join 'Code')
$env.MY_ALGO_DIR    = ($env.HOME | path join 'Code/algo')
$env.MY_CURIOUS_DIR = ($env.HOME | path join 'Code/curious')
$env.MY_LEARN_DIR   = ($env.HOME | path join 'Code/learn')
$env.MY_PJ_DIR      = ($env.HOME | path join 'Code/pajamas')
mkdir $env.MY_CODE_DIR
mkdir $env.MY_ALGO_DIR
mkdir $env.MY_CURIOUS_DIR
mkdir $env.MY_LEARN_DIR
mkdir $env.MY_PJ_DIR

$env.MY_SCHOOL_DIR  = ($env.HOME | path join 'Desktop/school')
$env.MY_WORK_DIR    = ($env.HOME | path join 'Desktop/work')
mkdir $env.MY_SCHOOL_DIR
mkdir $env.MY_WORK_DIR  

$env.MY_GITHUB_DIR  = ($env.HOME | path join 'Github')
mkdir $env.MY_GITHUB_DIR

$env.MY_NOTES_DIR   = ($env.HOME | path join 'Notes')
mkdir $env.MY_NOTES_DIR

$env.MY_CAM_DIR         = ($env.HOME | path join 'Pictures/camera')
$env.MY_ICONS_DIR       = ($env.HOME | path join 'Pictures/icons')
$env.MY_PHONE_DIR       = ($env.HOME | path join 'Pictures/phone')
$env.MY_PROFILE_DIR     = ($env.HOME | path join 'Pictures/profile')
$env.MY_SCREENSHOTS_DIR = ($env.HOME | path join 'Pictures/screenshots')
$env.MY_WALLPAPERS_DIR  = ($env.HOME | path join 'Pictures/wallpapers')
mkdir $env.MY_CAM_DIR
mkdir $env.MY_ICONS_DIR
mkdir $env.MY_PHONE_DIR
mkdir $env.MY_PROFILE_DIR
mkdir $env.MY_SCREENSHOTS_DIR
mkdir $env.MY_WALLPAPERS_DIR

$env.MY_EMAIL_DIR       = ($env.HOME | path join '.local/share/email')
# Create email directories for email accounts in MY_EMAIL_DIR
mkdir $env.MY_EMAIL_DIR
mkdir $"($env.MY_EMAIL_DIR)/neomutt/mbsync/leet"
mkdir $"($env.MY_EMAIL_DIR)/neomutt/mbsync/sanch"
mkdir $"($env.MY_EMAIL_DIR)/neomutt/mbsync/sbc"
mkdir $"($env.MY_EMAIL_DIR)/neomutt/mbsync/spag"
mkdir $"($env.MY_EMAIL_DIR)/neomutt/msmtp"
mkdir $"($env.MY_EMAIL_DIR)/neomutt/notmuch"
mkdir $"($env.XDG_CACHE_HOME)/neomutt/leet/message_cache"
mkdir $"($env.XDG_CACHE_HOME)/neomutt/sanch/message_cache"
mkdir $"($env.XDG_CACHE_HOME)/neomutt/sbc/message_cache"
mkdir $"($env.XDG_CACHE_HOME)/neomutt/spag/message_cache"

# App Environment Variables ----------------------------------------------------

$env.GRIM_DEFAULT_DIR = ($env.HOME | path join 'Pictures/screenshots')
$env.GPG_TTY = (tty)
$env.GOPATH = ($env.XDG_DATA_HOME | path join 'go')
$env.STARSHIP_CONFIG = ($env.HOME | path join '.config/starship/starship.toml')
$env.CARAPACE_BRIDGES = 'fish,bash'

# PROMPT -----------------------------------------------------------------------

$env.PROMPT_INDICATOR           = "🚀 "
$env.PROMPT_INDICATOR_VI_INSERT = "👺 "
$env.PROMPT_INDICATOR_VI_NORMAL = "👻 "
$env.PROMPT_MULTILINE_INDICATOR = "🐢 "

# App Integration --------------------------------------------------------------

# yazi terminal file explorer
def --env y [...args] {
    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    yazi ...$args --cwd-file $tmp
    let cwd = (open $tmp)
    if $cwd != "" and $cwd != $env.PWD {
        cd $cwd
    }
    rm -fp $tmp
}

# SSH Agent/key management via keychain utility
keychain --eval --quiet id_ed25519
    | lines
    | where not ($it | is-empty)
    | parse "{k}={v}; export {k2};"
    | select k v
    | transpose --header-row
    | into record
    | load-env
keychain --eval --quiet FE1B05C31D8BACACDC77545B5596860E4313A9F5
    | lines
    | where not ($it | is-empty)
    | parse "{k}={v}; export {k2};"
    | select k v
    | transpose --header-row
    | into record
    | load-env
keychain --eval --quiet 8B75E4F45D7EAAA5E1AF400CF1ABF8C6D0B8B027
    | lines
    | where not ($it | is-empty)
    | parse "{k}={v}; export {k2};"
    | select k v
    | transpose --header-row
    | into record
    | load-env

# Autoload App Integration -----------------------------------------------------

# $env.data-dir is used to in several startup tasks
#   1. ($nu.data-dir)/nushell/completions is added to the $env.NU_LIB_DIRS search path.
#   2. ($nu.data-dir)/vendor/autoload is added as the last path in nu.vendor-autoload-dirs.
#       This means that files in this directory will be read last during startup
#       (and thus override any definitions made in earlier files).
#   3. ($nu.data-dir)/
#
# Note that the directory represented by $nu.data-dir, nor any of its subdirectories,
# are created by default. Creation and use of these directories is up to the user.
# A lot of apps say to source at the end. Adding these files to vendor/autoload, completes
# this step for you.

# Check the output of $nu.data-dir in terminal to see where this will be located
let autoload_dir = ($nu.data-dir | path join "vendor/autoload")
mkdir $autoload_dir

# List of initialization data for apps
let apps = [
    {
        name: "starship",
        file: "starship.nu",
        command: (starship init nu),
        description: "A minimal, blazingly-fast, and infinitely customizable prompt for any shell."
    },
    {
        name: "atuin",
        file: "atuin.nu",
        command: (atuin init nu --disable-up-arrow)
        description: "atuin replaces your existing shell history with a SQLite database, and records additional context for your commands. Additionally, it provides optional and fully encrypted synchronisation of your history between machines, via an Atuin server."
    },
    {
        name: "carapace",
        file: "carapace.nu",
        command: (carapace _carapace nushell)
        description: "carapace provides argument completion for multiple CLI commands, and works across multiple POSIX and non-POSIX shells (to include nushell)."
    },
    {
        name: "zoxide",
        file: "zoxide.nu",
        command: (zoxide init nushell)
        description: "carapace provides argument completion for multiple CLI commands, and works across multiple POSIX and non-POSIX shells (to include nushell)."
    },
]

# Iterate over list of apps and generate the file
for app in $apps {
    let file_path = ($autoload_dir | path join $app.file)
    $app.command | save -f $file_path
}
# WARN: There is a separate invocation of the above `$app.command | save -f $file_path` located in
# the `$nu.user-autoload-dirs` directory. This is to override any setting you may want to change.
# However, any `.nu` files in `$nu.user-autoload-dirs` will be automatically sourced during
# startup. This occurs after any vendor files have been processed, allowing user override of vendor
# settings if needed. However, since the files in $nu.vendor-autoload-dirs are created every shell
# instance to keep updated, this means changes made to the `$nu.user-autoload-dirs` files
# are not necessarily up to date with the latest changes. Ensure no conflicting changes in
# the `$nu.vendor-autoload-dirs` files if something breaks.

# -----------------------------------------------------------------------------
# PATH
# -----------------------------------------------------------------------------

use std/util "path add"
path add $env.XDG_BIN_HOME
path add ($env.GOPATH | path join "bin")

# Remove duplicate directories from the PATH
$env.PATH = ($env.PATH | uniq)
