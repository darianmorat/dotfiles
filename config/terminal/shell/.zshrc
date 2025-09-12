# Settings
ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c160,)" # Ignore suggestions with more than 100char

zstyle ':z4h:autosuggestions' forward-char 'accept' # Accepts 1char 'partial-accept' or for all 'accept' 
zstyle ':z4h:' prompt-at-bottom 'no'
zstyle ':z4h:*' fzf-command fzf # Use system fzf instead of z4h bundled version

# Bindings
setopt ignoreeof

z4h bindkey forward-char Ctrl+D
z4h bindkey undefined-key Ctrl+F
z4h bindkey undefined-key Ctrl+S

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

# theme
if [ -f "$HOME/.config/current_theme" ]; then
    THEME_MODE=$(cat "$HOME/.config/current_theme")
fi
if [ -n "$THEME_MODE" ] && [ -f "$HOME/.config/theme-manager/$THEME_MODE/fzf.sh" ]; then
    source "$HOME/.config/theme-manager/$THEME_MODE/fzf.sh"
else
    source "$HOME/.config/theme-manager/dark/fzf.sh"
fi

export THEME_MODE
