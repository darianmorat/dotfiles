# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files sourced from it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

# Periodic auto-update on Zsh startup: 'ask' or 'no'.
# You can manually run `z4h update` to update everything.
zstyle ':z4h:' auto-update      'no'
# Ask whether to auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:' auto-update-days '28'

# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey' keyboard  'pc'

# Don't start tmux.
zstyle ':z4h:' start-tmux       no

# Mark up shell's output with semantic information.
zstyle ':z4h:' term-shell-integration 'yes'

# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char 'accept'

# Recursively traverse directories when TAB-completing files.
zstyle ':z4h:fzf-complete' recurse-dirs 'no'

# Enable direnv to automatically source .envrc files.
zstyle ':z4h:direnv'         enable 'no'
# Show "loading" and "unloading" notifications from direnv.
zstyle ':z4h:direnv:success' notify 'yes'

# Enable ('yes') or disable ('no') automatic teleportation of z4h over
# SSH when connecting to these hosts.
zstyle ':z4h:ssh:example-hostname1'   enable 'yes'
zstyle ':z4h:ssh:*.example-hostname2' enable 'no'
# The default value if none of the overrides above match the hostname.
zstyle ':z4h:ssh:*'                   enable 'no'

# Send these files over to the remote host when connecting over SSH to the
# enabled hosts.
zstyle ':z4h:ssh:*' send-extra-files '~/.nanorc' '~/.env.zsh'

# disable syntax highlighting
zstyle ':z4h:zsh-syntax-highlighting' channel 'none' 

# Clone additional Git repositories from GitHub.
#
# This doesn't do anything apart from cloning the repository and keeping it
# up-to-date. Cloned files can be used after `z4h init`. This is just an
# example. If you don't plan to use Oh My Zsh, delete this line.
z4h install ohmyzsh/ohmyzsh || return

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# Extend PATH.
path=(~/bin $path)

# Export environment variables.
export GPG_TTY=$TTY

# Source additional local files if they exist.
z4h source ~/.env.zsh

# =======================================================================================
# =======================================================================================

setopt ignoreeof

z4h bindkey forward-char Ctrl+D

z4h bindkey undefined-key Ctrl+S
z4h bindkey undefined-key Ctrl+F

fzf-global() {
   local selected
   selected=$(find ~/projects -mindepth 1 -maxdepth 1 -type d 2>/dev/null | \
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

zle -N fzf-global
bindkey '^O' fzf-global

alias mpv-all='find . -type f \( -iname "*.mp3" -o -iname "*.m4a" \) | shuf | mpv --playlist=-'
mpv-pick() { find "$@" -type f \( -iname "*.mp3" -o -iname "*.m4a" \) | shuf | mpv --playlist=- ; }

# =======================================================================================
# =======================================================================================

# Autoload functions.
autoload -Uz zmv

# Define functions and completions.
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories md

# Define named directories: ~w <=> Windows home directory on WSL.
[[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home

# Define aliases.
alias tree='tree -a -I .git'

# Add flags to existing aliases.
alias ls="${aliases[ls]:-ls} -A"

eval "$(zoxide init zsh)"

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu

# =======================================================================================
# =======================================================================================

theme-manager() {
   local THEME_DIR="$HOME/.config/theme"
   local CURRENT_THEME_FILE="$HOME/.config/current_theme"
   local CONFIG_DIR="$HOME/.config"
   local GTK_CONFIG="$CONFIG_DIR/gtk-3.0/settings.ini"

   # Toggle
   local current=$([ -f "$CURRENT_THEME_FILE" ] && cat "$CURRENT_THEME_FILE" || echo "dark")
   local theme=$([ "$current" = "dark" ] && echo "light" || echo "dark")

   # Save and export
   echo "$theme" > "$CURRENT_THEME_FILE"
   export THEME_MODE="$theme"

   # GTK
   local gtk_theme=$([ "$theme" = "dark" ] && echo "Materia-dark" || echo "Materia-light")
   sed -i "s|gtk-theme-name=.*|gtk-theme-name=$gtk_theme|" "$GTK_CONFIG"
   gsettings set org.gnome.desktop.interface color-scheme "prefer-$theme"

   # Background
   if [ "$theme" = "dark" ]; then
      xsetroot -solid "#232323"
   else
      xsetroot -solid "#E8E8E8"
   fi

   # Lazygit
   if [ "$theme" = "dark" ]; then
      lg_color="#303030"
   else
      lg_color="#C9C9BF"
   fi
   sed -i "s/- \"#[^\"]*\"/- \"$lg_color\"/" "$CONFIG_DIR/lazygit/config.yml"

   # FZF
   if [ "$theme" = "dark" ]; then
      fzf_opts="--ansi
      --layout=reverse
      --border=none
      --color=fg:#D6CFC4,fg+:#E6E3DE,bg:#1E1E1E,bg+:#303030
      --color=gutter:#1E1E1E,prompt:#579DD4,marker:#B55353
      --color=pointer:#B55353,header:#D19F66,info:#575757
      --color=hl:#72BA62,hl+:#72BA62,query:#D6CFC4"
   else
      fzf_opts="--ansi
      --layout=reverse
      --border=none
      --color=fg:#101010,fg+:#000000,bg:#F7F5EA,bg+:#C9C9BF
      --color=gutter:#F7F5EA,prompt:#0F5289,marker:#AD4B4B
      --color=pointer:#AD4B4B,header:#AE5F05,info:#707070
      --color=hl:#006C00,hl+:#006C00,query:#101010"
   fi
   echo "$fzf_opts" > ~/.fzfrc

   # WezTerm
   touch ~/.config/wezterm/wezterm.lua

   # Notification
   notify-send "Theme switched to $theme"
}

THEME_MODE=$([ -f "$HOME/.config/current_theme" ] && cat "$HOME/.config/current_theme" || echo "dark")

export THEME_MODE
export FZF_DEFAULT_OPTS_FILE=~/.fzfrc
