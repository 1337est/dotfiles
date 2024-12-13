# get version control info
autoload -Uz vcs_info

# customize the way git looks with zstyle
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

# Function to run before each prompt
precmd() {
    vcs_info # Get version control information
    set_prompt_color_vi_mode # Update the prompt color based on vi mode
}

# Enables dynamic/customizable prompts in ZSH
setopt PROMPT_SUBST

# Right side prompt that shows user@machine in red brackets
RPROMPT='%F{red}[%F{yellow}%n%F{green}@%F{blue}%M%F{red}]'

# History options
setopt APPEND_HISTORY # appends new entries to history instead of overwriting
setopt INC_APPEND_HISTORY # writes histfile when command is executed
setopt SHARE_HISTORY # imports new commands from the history file
setopt HIST_IGNORE_DUPS # will not record duplicate commands run consecutively

# aliases
alias ls='lsd --group-dirs=first' # lsd with directories first
alias lsa='ls -A' # ls All
alias lsl='ls -lh --git --header' # ls long
alias lst='ls --tree --depth=2' # ls tree
alias lsal='ls -A -lh --git --header' # ls All long
alias lsat='ls -A --tree --depth=2' # ls All tree
alias lslt='ls -lh --git --header --tree --depth=2' # ls long tree
alias lsalt='ls -A -lh --git --header --tree --depth=2' # ls All long tree
alias cat='bat' # better cat
alias open='xdg-open'
alias history='history 1' # show all history
alias lg='lazygit' # git but better?
alias mbsync='mbsync -c "$XDG_CONFIG_HOME/isync/mbsyncrc"'

# Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
_comp_options+=(globdots)   #include hidden files
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# vi mode
bindkey -v

# Function to set prompt color based on vi mode
# In order this formats the left prompt in 2 levels:
# 1st level is the path followed by version control info if present
# 2nd level is where you type and has a Visual/Insert mode indicator
function set_prompt_color_vi_mode {
    local dir_color
    if [[ $KEYMAP == vicmd ]]; then
        dir_color="%F{yellow}" # Yellow for visual mode
    else
        dir_color="%F{blue}" # Blue for insert mode
    fi

    # 1st level with red brackets around CWD
    PROMPT="%F{red}[${dir_color}%~%F{red}] ${vcs_info_msg_0_}
"
    # 2nd level line indicator based on vi mode
    if [[ $KEYMAP == vicmd ]]; then
        PROMPT+="%F{yellow}V%{$reset_color%}%f " # Visual mode indicator
    else
        PROMPT+="%F{green}$%{$reset_color%}%f "  # Insert mode indicator
    fi
}

# Function to update prompt color when vi mode changes
function zle-line-init zle-keymap-select {
    set_prompt_color_vi_mode
    zle reset-prompt
}

# Explicitly register zle-keymap-select and zle-line-init as ZLE widgets
zle -N zle-keymap-select
zle -N zle-line-init

# Use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Source the khal completions file for zsh
source ~/.config/khal/.khal-complete.zsh

# Adding zoxide to zsh
eval "$(zoxide init --cmd cd zsh)"

# Load zsh-syntax-hilighting; should be last
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

