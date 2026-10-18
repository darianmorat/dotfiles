# --- history ---
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt share_history hist_ignore_dups

# --- options ---
bindkey -e
setopt ignoreeof glob_dots no_flow_control autocd

# --- completion ---
autoload -Uz compinit && compinit
setopt no_auto_menu

# --- env ---
path=(~/bin $path)
export GPG_TTY=$TTY

THEME_MODE=$([ -f "$HOME/.config/current_theme" ] && cat "$HOME/.config/current_theme" || echo "dark")
export THEME_MODE

[[ -f ~/.env.zsh ]] && source ~/.env.zsh

export FZF_DEFAULT_OPTS_FILE=~/.fzfrc
export FZF_CTRL_R_OPTS="--no-multi"

export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac

# --- fzf + zoxide ---
source <(fzf --zsh)
eval "$(zoxide init zsh)"

# --- keys ---
bindkey '^S' undefined-key
bindkey '^F' undefined-key

bindkey '^D' forward-char
bindkey '^H' backward-kill-word
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

WORDCHARS=${WORDCHARS//\/}

# --- terminal title ---
autoload -Uz add-zsh-hook
_title_precmd() { print -Pn '\e]0;%~\a' }
add-zsh-hook precmd _title_precmd

# --- prompt ---
PROMPT='%F{green}kaizen@root%f:%F{blue}%~%f$ '

# --- aliases ---
alias ls='ls --color=auto -A'
alias grep='grep --color=auto'
alias tree='tree -a -I ".git|node_modules|dist"'

# --- fzf project search ---
fzf-global() {
   local selected
   selected=$(find ~/projects -mindepth 1 -maxdepth 1 -type d 2>/dev/null | \
      sed "s#^$HOME/##" | \
      fzf \
      --ansi \
      --border=sharp \
      --prompt="> ")

   if [[ -n "$selected" ]]; then
      print -s "cd $HOME/$selected"
      builtin cd "$HOME/$selected"
      print -Pn "%F{magenta}→ jumped to%f %F{cyan}~/$selected%f"
      zle send-break
   else
      zle reset-prompt
   fi
}
zle -N fzf-global
bindkey '^O' fzf-global

# --- clipboard utilities ---
FILE_CLIPBOARD=~/.file_clipboard

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
         cp -r "$source" "$target" && ((count++)) || true
      else
         mv "$source" "$target" && ((count++)) || true
      fi
   done < <(tail -n +2 "$FILE_CLIPBOARD")
   echo "Pasted $count item(s)"
   [[ "$mode" == "cut" ]] && rm "$FILE_CLIPBOARD"
}

ll() {
   [[ ! -f "$FILE_CLIPBOARD" ]] && echo "Clipboard empty" && return
   local mode=$(head -1 "$FILE_CLIPBOARD")
   echo "[$mode]"
   tail -n +2 "$FILE_CLIPBOARD"
}

# --- plugins (keep last) ---
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#575757'
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
