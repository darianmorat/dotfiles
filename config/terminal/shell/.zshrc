ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c160,)" # Ignore suggestions with more than 100char
zstyle ':z4h:autosuggestions' forward-char 'accept' # Accepts 1char 'partial-accept' or for all 'accept' 

# Aliases
alias dow="cd /mnt/d/DarianToledo/Downloads"
alias doc="cd /mnt/d/DarianToledo/Documents"

alias rm="trash"
alias lg="lazygit"
alias vifm="vifm ."
# Find way to send nvim/vifm directly
# Like in bash: bind -x '"\C-o":"vifm"'

alias ls="eza --color=always --long --git --no-filesize --no-time --no-user --no-permissions -F"
alias lsl="eza --color=always --long --git --no-filesize --no-time --no-user --no-permissions -F --grid"
alias lst="ls --tree --level=2"

alias clear=z4h-clear-screen-soft-bottom
eval "$(zoxide init zsh)"
# export PATH="$HOME/bin:$PATH" # ~/bin/color_test / if needed 
