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

# -----------
# Keybindings
# -----------
# keybindings (list): A list of user-defined keybindings
# Nushell/Reedline keybindings can be added or overridden using this setting.
# See https://www.nushell.sh/book/line_editor.html#keybindings for details.
# -----

# Menus
# -----
# menus (list):
#
# Nushell/Reedline menus can be created and modified using this setting.
# See https://www.nushell.sh/book/line_editor.html#menus for details.
#
# Note that menus are usually activated via keybindings, which are defined in
# $env.config.keybindings (above).

# ---------------
# Plugin behavior
# ---------------

$env.config.plugins = {}

$env.config.plugin_gc = {
    default: {
        enabled: true
        stop_after: 10sec
    }
    plugins: {}
}

# -------------------------------------
# Themes/Colors and Syntax Highlighting
# -------------------------------------
# For more information on defining custom themes, see
# https://www.nushell.sh/book/coloring_and_theming.html

# Use and/or contribute to the theme collection at
# https://github.com/nushell/nu_scripts/tree/main/themes

$env.config.highlight_resolved_externals = true

# color_config (record): A record of shapes, types, UI elements, etc. that can be styled (e.g.,
# colorized) in Nushell, either on the commandline itself (shapes) or in output.
#
# Note that this is usually set through a theme provided by a record in a custom command. For
# instance, the standard library contains two "starter" theme commands: "dark-theme" and
# "light-theme". For example:
use std/config dark-theme
$env.config.color_config = (dark-theme)

# Or, individual color settings can be configured or overridden.
#
# Values can be one of:
# - A color name such as "red" (see `ansi -l` for a list)
# - A color RGB value in the form of "#C4C9C6"
# - A record including:
#   * `fg` (color)
#   * `bg` (color)
#   * `attr`: a string with one or more of:
#     - 'n': normal
#     - 'b': bold
#     - 'u': underline
#     - 'r': reverse
#     - 'i': italics
#     - 'd': dimmed

# color_config.shape_*: Applies syntax highlighting based on the "shape" (inferred or declared type) of an
# element on the commandline. Nushell's parser can identify shapes based on many criteria, often
# as the commandline is being typed.

# color.config.<type>
# *Values* of a particular *type* can be styled differently than the *shape*.
# Note that the style is applied only when this type is displayed in *structured* data (list,
# record, or table). It is not currently applied to basic raw values.


$env.config.color_config.shape_table
$env.config.color_config.shape_binary
$env.config.color_config.string
$env.config.color_config.shape_operator
$env.config.color_config.shape_record
$env.config.color_config.shape_raw_string
$env.config.color_config.cell-path
$env.config.color_config.range
$env.config.color_config.shape_keyword
$env.config.color_config.shape_int
$env.config.color_config.search_result
$env.config.color_config.leading_trailing_space_bg
$env.config.color_config.shape_external_resolved
$env.config.color_config.duration
$env.config.color_config.nothing
$env.config.color_config.shape_external
$env.config.color_config.float
$env.config.color_config.block
$env.config.color_config.empty
$env.config.color_config.shape_flag
$env.config.color_config.filesize
$env.config.color_config.shape_filepath
$env.config.color_config.shape_block
$env.config.color_config.shape_globpattern
$env.config.color_config.shape_directory
$env.config.color_config.shape_glob_interpolation
# $env.config.color_config.glob # must be declared
$env.config.color_config.binary
$env.config.color_config.separator
$env.config.color_config.row_index
$env.config.color_config.record
$env.config.color_config.int
$env.config.color_config.shape_range
$env.config.color_config.shape_custom
$env.config.color_config.shape_closure
$env.config.color_config.shape_float
$env.config.color_config.shape_list
$env.config.color_config.hints
$env.config.color_config.header
$env.config.color_config.shape_bool
$env.config.color_config.shape_string_interpolation
$env.config.color_config.shape_garbage
$env.config.color_config.shape_pipe
$env.config.color_config.shape_variable
$env.config.color_config.shape_nothing
$env.config.color_config.shape_string
$env.config.color_config.shape_internalcall
$env.config.color_config.shape_signature
$env.config.color_config.shape_vardecl
$env.config.color_config.shape_redirection
$env.config.color_config.shape_datetime
$env.config.color_config.shape_match_pattern
$env.config.color_config.list
$env.config.color_config.shape_externalarg
$env.config.color_config.shape_literal
$env.config.color_config.date
# $env.config.color_config.closure
$env.config.color_config.shape_matching_brackets
$env.config.color_config.bool

# ------------------------
# `explore` command colors
# ------------------------
# Configure the UI colors of the `explore` command
# Allowed values are the same as for the `color_config` options above.
$env.config.explore = {}

# ---------------------------------------------------------------------------------------
# Environment Variables
# ---------------------------------------------------------------------------------------

$env.PROMPT_COMMAND = $env.PROMPT_COMMAND? | default {||
    let dir = match (do -i { $env.PWD | path relative-to $nu.home-path }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($dir)(ansi reset)"

    $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
}
$env.PROMPT_COMMAND_RIGHT = $env.PROMPT_COMMAND_RIGHT? | default {||
    # create a right prompt in magenta with green separators and am/pm underlined
    let time_segment = ([
        (ansi reset)
        (ansi magenta)
        (date now | format date '%x %X') # try to respect user's locale
    ] | str join | str replace --regex --all "([/:])" $"(ansi green)${1}(ansi magenta)" |
        str replace --regex --all "([AP]M)" $"(ansi magenta_underline)${1}")

    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        ($env.LAST_EXIT_CODE)
    ] | str join)
    } else { "" }

    ([$last_exit_code, (char space), $time_segment] | str join)
}
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ": "
$env.PROMPT_INDICATOR_VI_NORMAL = "〉"
$env.PROMPT_MULTILINE_INDICATOR = "::: "

$env.TRANSIENT_PROMPT_COMMAND = "🚀 "
$env.TRANSIENT_PROMPT_INDICATOR = ""
$env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = ""
$env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = ""
$env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = ""
$env.TRANSIENT_PROMPT_COMMAND_RIGHT = ""

const NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
    ($nu.data-dir | path join 'completions') # default home for nushell completions
]
const NU_LIB_DIRS = $NU_LIB_DIRS ++ [($nu.default-config-dir | path join 'modules')]

const NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]
const NU_PLUGIN_DIRS = $NU_PLUGIN_DIRS ++ [($nu.default-config-dir | path join 'plugins')]

use std/util "path add"
path add "~/.local/bin"

# You can remove duplicate directories from the path using:
$env.PATH = ($env.PATH | uniq)

# TODO: get rid of list and specify individually
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

# carapace
source ~/.cache/carapace/init.nu

# Enabling zoxide
source ~/.local/share/zoxide/db.nu
