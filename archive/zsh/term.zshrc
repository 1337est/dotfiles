#!/usr/bin/env zsh

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
_comp_options+=(globdots)   #include hidden files
eval "$(dircolors)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# get version control info
autoload -Uz vcs_info
# customize the way git looks with zstyle
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

# Function to set prompt color based on vi mode
# In order this formats the left prompt in 2 levels:
# 1st level is the path followed by version control info if present
# 2nd level is where you type and has a Visual/Insert mode indicator
function set_prompt {
    local dir_color
    if [[ $KEYMAP == vicmd ]]; then
        dir_color="%F{yellow}" # Yellow for visual mode
    else
        dir_color="%F{cyan}" # Blue for insert mode
    fi

    # 1st level with red brackets around CWD
    PROMPT="%F{red}[${dir_color}%~%F{red}] ${vcs_info_msg_0_}
"
    # Right side prompt that shows user@machine
    RPROMPT='%F{red}[%F{yellow}%n%F{green}@%F{blue}%M%F{red}]'

    # 2nd level line indicator based on vi mode
    if [[ $KEYMAP == vicmd ]]; then
        PROMPT+="%F{yellow}V%{$reset_color%}%f " # Visual mode indicator
    else
        PROMPT+="%F{green}$%{$reset_color%}%f "  # Insert mode indicator
    fi
}

# Function to update prompt color when vi mode changes
function zle-line-init zle-keymap-select {
    set_prompt
    zle reset-prompt
}

# Explicitly register zle-keymap-select and zle-line-init as ZLE widgets
zle -N zle-keymap-select
zle -N zle-line-init

# Function to run before each prompt
precmd() {
    vcs_info # Get version control information
    set_prompt # Update the prompt color based on vi mode
}

