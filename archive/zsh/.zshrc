# History options
setopt APPEND_HISTORY # appends new entries to history instead of overwriting
setopt INC_APPEND_HISTORY # writes histfile when command is executed
setopt SHARE_HISTORY # imports new commands from the history file
setopt HIST_IGNORE_DUPS # will not record duplicate commands run consecutively

# Enables dynamic/customizable prompts in ZSH
setopt PROMPT_SUBST

# aliases
alias ls='lsd --group-dirs=last' # lsd with directories first/last/none
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

# vi mode
bindkey -v

# Use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -v '^?' backward-delete-char

# Source the khal completions file for zsh
source ~/.config/khal/.khal-complete.zsh

# Adding zoxide to zsh
eval "$(zoxide init --cmd cd zsh)"

# Load zsh-syntax-hilighting; should be last
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

