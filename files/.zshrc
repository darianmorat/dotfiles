zstyle ':z4h:' prompt-at-bottom 'yes'
ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c160,)" # Ignore suggestions with more than 100char
zstyle ':z4h:autosuggestions' forward-char 'accept' # Accepts 1char 'partial-accept' or for all 'accept' 

# Bindings
z4h bindkey z4h-backward-word Ctrl+Alt+B
z4h bindkey z4h-forward-word Ctrl+Alt+F

# find way to send vifm directly. Bash: bind -x '"\C-o":"vifm"'
bindkey -s '^O' '^Utmux rename-window vifm; vifm .^J'

# Aliases
alias dow="cd /mnt/d/DarianToledo/Downloads"
alias doc="cd /mnt/d/DarianToledo/Documents"
alias mf="touch" # md: make-dir
alias rm="trash"
# `$rm` cli: Trash/files/
# `dd` vifm: Trash/vifm/
# `$empty-trash` cli: Trash/

alias s="tmux"
alias sa="tmux a"
alias lg="lazygit"

alias ls="eza --color=always --long --git --no-filesize --no-time --no-user --no-permissions -F"
alias lsl="eza --color=always --long --git --no-filesize --no-time --no-user --no-permissions -F --grid"
alias lst="ls --tree --level=2"

alias clear=z4h-clear-screen-soft-bottom
eval "$(zoxide init zsh)"
# export PATH="$HOME/bin:$PATH" # ~/bin/color_test / if needed 