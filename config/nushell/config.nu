# To learn more about a particular setting, run any of these terminal commands:
# config nu --doc # for output into the terminal
# config nu --doc | nu-highlight | less -R # for viewing in the terminal
# config nu --doc out> ~/path/to/file # for saving the output to a file

# ------------------------
# History-related settings
# ------------------------

$env.config.history = {
    max_size: 5_000_000
    sync_on_enter: true
    file_format: "sqlite"
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

$env.config.cursor_shape = {
    emacs: "inherit"         # Cursor shape in emacs mode
    vi_insert: "blink_block"       # Cursor shape in vi-insert mode
    vi_normal: "block"  # Cursor shape in normal vi mode
}

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
        completer: {|spans: list<string>|
            carapace $spans.0 nushell ...$spans
            | from json
            | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
        }
    }
    use_ls_colors: true
}

# --------------------
# Terminal Integration
# --------------------

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

# ----------------------
# Error Display Settings
# ----------------------

$env.config.error_style = "fancy"

$env.config.display_errors = {
    exit_code: false
    termination_signal: true
}

# -------------
# Table Display
# -------------

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

# ----------------
# Datetime Display
# ----------------

$env.config.datetime_format = {
    normal: "%m/%d/%y %I:%M:%S%p"
    table: null
}

# ----------------
# Filesize Display
# ----------------

$env.config.filesize = {
    unit: metric
    precision: 1
}

# ---------------------
# Miscellaneous Display
# ---------------------

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

# ---------------------------------------------------------------------------------------
# Environment Variables
# ---------------------------------------------------------------------------------------

# ---------------------------
# Default Program Variables
# ---------------------------

$env.EDITOR     = 'nvim'
$env.VISUAL     = 'nvim'
$env.TERM       = 'ghostty'
$env.SHELL      = 'nu'
$env.PAGER      = 'bat'
$env.MANPAGER   = 'nvim +Man!'
$env.MANWIDTH   = 999
$env.BROWSER    = 'vivaldi'

# --------------------
# XDG Base Directories
# --------------------

$env.XDG_CONFIG_HOME    = ($env.HOME | path join '.config')
$env.XDG_CACHE_HOME     = ($env.HOME | path join '.cache')
$env.XDG_DATA_HOME      = ($env.HOME | path join '.local/share')
$env.XDG_STATE_HOME     = ($env.HOME | path join '.local/state')
$env.XDG_BIN_HOME       = ($env.HOME | path join '.local/bin')
$env.XDG_LIB_HOME       = ($env.HOME | path join '.local/lib')

# --------------------
# XDG User Directories
# --------------------

$env.XDG_DESKTOP_DIR        = ($env.HOME | path join 'Desktop')
$env.XDG_DOCUMENTS_DIR      = ($env.HOME | path join 'Documents')
$env.XDG_DOWNLOAD_DIR       = ($env.HOME | path join 'Downloads')
$env.XDG_MUSIC_DIR          = ($env.HOME | path join 'Music')
$env.XDG_PICTURES_DIR       = ($env.HOME | path join 'Pictures')
$env.XDG_PUBLICSHARE_DIR    = ($env.HOME | path join 'Public')
$env.XDG_TEMPLATES_DIR      = ($env.HOME | path join 'Templates')
$env.XDG_VIDEOS_DIR         = ($env.HOME | path join 'Videos')

# -----------------------
# MY Personal Directories
# -----------------------

$env.MY_CODE_DIR    = ($env.HOME | path join 'Code')
$env.MY_ALGO_DIR    = ($env.HOME | path join 'Code/algo')
$env.MY_CURIOUS_DIR = ($env.HOME | path join 'Code/curious')
$env.MY_PJ_DIR      = ($env.HOME | path join 'Code/pajamas')

$env.MY_SCHOOL_DIR  = ($env.HOME | path join 'Desktop/school')
$env.MY_WORK_DIR    = ($env.HOME | path join 'Desktop/work')

$env.MY_GITHUB_DIR  = ($env.HOME | path join 'Github')

$env.MY_NOTES_DIR   = ($env.HOME | path join 'Notes')

$env.MY_CAM_DIR         = ($env.HOME | path join 'Pictures/camera')
$env.MY_ICONS_DIR       = ($env.HOME | path join 'Pictures/icons')
$env.MY_PHONE_DIR       = ($env.HOME | path join 'Pictures/phone')
$env.MY_PROFILE_DIR     = ($env.HOME | path join 'Pictures/profile')
$env.MY_SCREENSHOTS_DIR = ($env.HOME | path join 'Pictures/screenshots')
$env.MY_WALLPAPERS_DIR  = ($env.HOME | path join 'Pictures/wallpapers')

# -------------------------
# App Environment Variables
# -------------------------

# `grim` - directory for screenshots taken by grim
$env.GRIM_DEFAULT_DIR = ($env.HOME | path join 'Pictures/screenshots')

# `gpg` - Get the current tty dynamically
$env.GPG_TTY = (tty)

# `go` - go data (modules/pkg/binaries) directory
$env.GOPATH = ($env.XDG_DATA_HOME | path join 'go')

# `starship` - config location
$env.STARSHIP_CONFIG = ($env.HOME | path join '.config/starship/starship.toml')

# carapace-bin bridges: https://carapace-sh.github.io/carapace-bin/spec/bridge.html
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'

$env.__zoxide_hooked = default false

# ------
# PROMPT
# ------

$env.PROMPT_INDICATOR           = "🚀 "
$env.PROMPT_INDICATOR_VI_INSERT = "👺 "
$env.PROMPT_INDICATOR_VI_NORMAL = "👻 "
$env.PROMPT_MULTILINE_INDICATOR = "🐢 "

# ---------------
# App Integration
# ---------------

# yazi shell wrapper for `y` command. Need to start yazi through `y` to use
# `q` quit with change to cwd
# `Q` quit without changing cwd
def --env y [...args] {
    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    yazi ...$args --cwd-file $tmp
    let cwd = (open $tmp)
    if $cwd != "" and $cwd != $env.PWD {
        cd $cwd
    }
    rm -fp $tmp
}

# ------------------------
# Autoload App Integration
# ------------------------

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
        description: "A minimal, blazingly-fast, and infinitely customizable prompt
        for any shell."
    },
    {
        name: "atuin",
        file: "atuin.nu",
        command: (atuin init nu --disable-up-arrow)
        description: "atuin replaces your existing shell history with a SQLite database,
        and records additional context for your commands. Additionally, it provides optional
        and fully encrypted synchronisation of your history between machines, via an Atuin server."
    },
    {
        name: "carapace",
        file: "carapace.nu",
        command: (carapace _carapace nushell)
        description: "carapace provides argument completion for multiple CLI commands,
        and works across multiple POSIX and non-POSIX shells (to include nushell)."
    },
    {
        name: "zoxide",
        file: "zoxide.nu",
        command: (zoxide init --cmd cd nushell)
        description: "zoxide is a smarter cd command. It remembers directories!"
    },
]

# Iterate over list of apps and generate the file
# NOTE: The file will be generated each time you open a shell to ensure app updates are incorporated
for app in $apps {
    let file_path = ($autoload_dir | path join $app.file)
    $app.command | save -f $file_path
}

# ---------
# SSG Agent
# ---------

# loading ssh keys and environment variables via keychain utility
keychain --eval --quiet id_ed25519
    | lines
    | where not ($it | is-empty)
    | parse "{k}={v}; export {k2};"
    | select k v
    | transpose --header-row
    | into record
    | load-env

# ----
# PATH
# ----

use std/util "path add"
path add $env.XDG_BIN_HOME
path add ($env.GOPATH | path join "bin")

# Remove duplicate directories from the PATH
$env.PATH = ($env.PATH | uniq)
