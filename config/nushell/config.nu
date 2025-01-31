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
        completer: {|spans|
            carapace $spans.0 nushell ...$spans | from json
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
    show_empty: true
    padding: {
        left: 1
        right: 1
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
    metric: true
    format: "auto"
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

# ------
# PROMPT
# ------

# Starship prompt for git integration
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

$env.PROMPT_INDICATOR = "🚀 "
$env.PROMPT_INDICATOR_VI_INSERT = "👺 "
$env.PROMPT_INDICATOR_VI_NORMAL = "👻 "
$env.PROMPT_MULTILINE_INDICATOR = "🐢 "

# ---------------------------
# Default Program Variables
# ---------------------------

$env.EDITOR = 'nvim'
$env.VISUAL = 'nvim'
$env.TERM = 'ghostty'
$env.SHELL = 'nu'
$env.PAGER = 'bat'
$env.MANPAGER = 'nvim +Man!'
$env.MANWIDTH = 999
$env.BROWSER = 'vivaldi'

# --------------------
# XDG Base Directories
# --------------------

$env.XDG_CONFIG_HOME        = ($env.HOME | path join '.config')
$env.XDG_CACHE_HOME         = ($env.HOME | path join '.cache')
$env.XDG_DATA_HOME          = ($env.HOME | path join '.local/share')
$env.XDG_STATE_HOME         = ($env.HOME | path join '.local/state')
$env.XDG_BIN_HOME           = ($env.HOME | path join '.local/bin')
$env.XDG_LIB_HOME           = ($env.HOME | path join '.local/lib')

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

$env.MY_CODE_DIR            = ($env.HOME | path join 'Code')
$env.MY_ALGO_DIR            = ($env.HOME | path join 'Code/algo')
$env.MY_CURIOUS_DIR         = ($env.HOME | path join 'Code/curious')
$env.MY_PJ_DIR              = ($env.HOME | path join 'Code/pajamas')

$env.MY_NOTES_DIR           = ($env.HOME | path join 'Desktop/notes')
$env.MY_SCHOOL_DIR          = ($env.HOME | path join 'Desktop/school')
$env.MY_WORK_DIR            = ($env.HOME | path join 'Desktop/work')

$env.MY_GITHUB_DIR          = ($env.HOME | path join 'Github')

$env.MY_CAM_DIR             = ($env.HOME | path join 'Pictures/camera')
$env.MY_ICONS_DIR           = ($env.HOME | path join 'Pictures/icons')
$env.MY_PHONE_DIR           = ($env.HOME | path join 'Pictures/phone')
$env.MY_PROFILE_DIR         = ($env.HOME | path join 'Pictures/profile')
$env.MY_SCREENSHOTS_DIR     = ($env.HOME | path join 'Pictures/screenshots')
$env.MY_WALLPAPERS_DIR      = ($env.HOME | path join 'Pictures/wallpapers')

# App specific environment variables
$env.GRIM_DEFAULT_DIR = ($env.HOME | path join 'Pictures/screenshots')
$env.GPG_TTY = (tty) # Get the current tty dynamically
$env.GOPATH = ($env.XDG_DATA_HOME | path join 'go')
$env.STARSHIP_CONFIG = ($env.HOME | path join '.config/starship/starship.toml')

use std/util "path add"
# Add to path here
path add $env.XDG_BIN_HOME
path add ($env.GOPATH | path join "bin")

# You can remove duplicate directories from the path using:
$env.PATH = ($env.PATH | uniq)

# carapace
source ~/.cache/carapace/init.nu

# Enabling zoxide
source ~/.local/share/zoxide/db.nu
