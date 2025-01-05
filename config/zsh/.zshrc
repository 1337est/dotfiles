# get version control info
autoload -Uz vcs_info

# customize the way git looks with zstyle
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

# Function to run before each prompt
precmd() {
    vcs_info # Get version control information
}

# Enables dynamic/customizable prompts in ZSH
setopt PROMPT_SUBST

# Left prompt configuration
# TODO: Make prompt change slash / char color for directory
PROMPT='%F{red}[%F{yellow}%~%F{red}] ${vcs_info_msg_0_}
%F{green}$%{$reset_color%}%f '
# Right side prompt that shows user@machine
RPROMPT='%F{red}[%F{yellow}%n%F{green}@%F{cyan}%M%F{red}]'

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
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
_comp_options+=(globdots)   #include hidden files
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Source the khal completions file for zsh
source ~/.config/khal/.khal-complete.zsh

# Use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Adding zoxide to zsh
eval "$(zoxide init --cmd cd zsh)"
# Load zsh-syntax-hilighting; should be last
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

