 typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    example # ~/

  function prompt_example() {
    p10k segment -f 4 -i '~/'

  typeset -g POWERLEVEL9K_SHOW_RULER=true
  typeset -g POWERLEVEL9K_RULER_CHAR='.'        
  typeset -g POWERLEVEL9K_RULER_FOREGROUND=0
  
  # Default prompt symbol.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯❯'
  # Prompt symbol in command vi mode.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮❮'

  # typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last
