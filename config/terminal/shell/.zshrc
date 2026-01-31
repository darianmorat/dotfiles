# =======================================================================================
# =======================================================================================

zstyle ':z4h:' prompt-at-bottom 'no' # prompt position - comment line for bottom prompt
zstyle ':z4h:zsh-syntax-highlighting' channel 'none' # disable syntax highlighting
zstyle ':z4h:autosuggestions' forward-char 'accept' # Accepts 1char 'partial-accept' or for all 'accept' 
zstyle ':z4h:*' fzf-command fzf # Use system fzf instead of z4h bundled version

# =======================================================================================
# =======================================================================================

setopt ignoreeof

z4h bindkey undefined-key Ctrl+S
z4h bindkey undefined-key Ctrl+F

z4h bindkey forward-char Ctrl+D

launch-nvim() {
  nvim
}
zle -N launch-nvim
bindkey '^[Z' launch-nvim 

# =======================================================================================
# =======================================================================================

alias rm="trash"
alias lg="lazygit"

alias ls="eza --long --git --no-filesize --no-time --no-user --no-permissions -F --ignore-glob node_modules"
alias lsl="eza --long --git --no-filesize --no-time --no-user --no-permissions -F --grid --ignore-glob node_modules"

alias lst="eza --tree --level=2 --ignore-glob node_modules"
alias lsd="eza --tree --ignore-glob node_modules"

alias clear=z4h-clear-screen-soft-bottom # keep the history intact, so after clearing you can still scroll back

# =======================================================================================
# =======================================================================================

eval "$(zoxide init zsh)"

export NVM_DIR="$HOME/.nvm"
   [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
   [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu

export PATH="/opt/nvim/bin:$PATH"

# =======================================================================================
# =======================================================================================

theme-manager() {
    local THEME_DIR="$HOME/.config/theme"
    local CURRENT_THEME_FILE="$HOME/.config/current_theme"
    local CONFIG_DIR="$HOME/.config"

    # Get current theme
    local current="dark"
    if [ -f "$CURRENT_THEME_FILE" ]; then
        current=$(cat "$CURRENT_THEME_FILE")
    fi

    # Toggle theme
    local theme="dark"
    if [ "$current" = "dark" ]; then
        theme="light"
    else
        theme="dark"
    fi

    # Save new theme
    echo "$theme" > "$CURRENT_THEME_FILE"
    export THEME_MODE="$theme"

    # Apply lazygit theme
    if [ -f "$CONFIG_DIR/lazygit/config.yml" ] && [ -f "$THEME_DIR/$theme/lazygit" ]; then
        local color=$(cat "$THEME_DIR/$theme/lazygit")
        sed -i "s/- \"#[^\"]*\"/- \"$color\"/" "$CONFIG_DIR/lazygit/config.yml"
    fi

    # Apply FZF theme
    if [ -f "$THEME_DIR/$theme/fzf.sh" ]; then
        source "$THEME_DIR/$theme/fzf.sh"
    fi

    echo "Theme switched to: $theme"
}

# =======================================================================================
# =======================================================================================

if [ -f "$HOME/.config/current_theme" ]; then
   THEME_MODE=$(cat "$HOME/.config/current_theme")
fi
if [ -n "$THEME_MODE" ] && [ -f "$HOME/.config/theme/$THEME_MODE/fzf.sh" ]; then
   source "$HOME/.config/theme/$THEME_MODE/fzf.sh"
else
   source "$HOME/.config/theme/dark/fzf.sh"
fi

export THEME_MODE

# =======================================================================================
# =======================================================================================

fzf-history() {
   local selected
   selected=$(dirs -v | awk '{print $2}' | fzf \
      --ansi \
      --prompt="History > ")
   
   if [[ -n "$selected" ]]; then
      selected="${selected/#\~/$HOME}"
      print -s "cd ${(q-)selected}"
      builtin cd "$selected"
      print -Pn "%F{magenta}→ jumped to%f %F{cyan}${selected/#$HOME/\~}%f"
      zle send-break
   else
      zle reset-prompt
   fi
}

fzf-global() {
   local selected
   selected=$(find ~/dev ~/work -mindepth 1 -maxdepth 1 -type d 2>/dev/null | \
      sed "s#^$HOME/##" | \
      fzf \
         --ansi \
         --prompt="Projects > ")
   
   if [[ -n "$selected" ]]; then
      print -s "cd $HOME/$selected"
      builtin cd "$HOME/$selected"
      print -Pn "%F{magenta}→ jumped to%f %F{cyan}~/$selected%f"
      zle send-break
   else
      zle reset-prompt
   fi
}

zle -N fzf-history
zle -N fzf-global

bindkey '^H' fzf-history
bindkey '^O' fzf-global

# =======================================================================================
# =======================================================================================

FILE_CLIPBOARD="/tmp/.file_clipboard_$$"

yy() {
   [[ $# -eq 0 ]] && set -- "."
   echo "copy" > "$FILE_CLIPBOARD"
   for item in "$@"; do
      realpath "$item" >> "$FILE_CLIPBOARD"
   done
   echo "Copied $# item(s)"
}

xx() {
   [[ $# -eq 0 ]] && set -- "."
   echo "cut" > "$FILE_CLIPBOARD"
   for item in "$@"; do
      realpath "$item" >> "$FILE_CLIPBOARD"
   done
   echo "Cut $# item(s)"
}

pp() {
   [[ ! -f "$FILE_CLIPBOARD" ]] && echo "Nothing to paste" && return 1
   local mode=$(head -1 "$FILE_CLIPBOARD")
   local dest="${1:-.}"
   local count=0
   while IFS= read -r source; do
      [[ ! -e "$source" ]] && echo "Skipping: $source (not found)" && continue
      local target="$dest"
      [[ -d "$dest" ]] && target="$dest/$(basename "$source")"
      if [[ "$mode" == "copy" ]]; then
         cp -r "$source" "$target" && ((count++))
      else
         mv "$source" "$target" && ((count++))
      fi
   done < <(tail -n +2 "$FILE_CLIPBOARD")
   echo "Pasted $count item(s)"
   [[ "$mode" == "cut" ]] && rm "$FILE_CLIPBOARD"
}
