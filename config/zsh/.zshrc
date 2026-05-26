
### I/O pre-instant prompt
if [[ "$(tty)" == "/dev/tty1" ]]; then
  niri-session
fi


### OPTIONS
setopt SHARE_HISTORY      # history is shared between zsh sessions
setopt HIST_SAVE_NO_DUPS  # saves no duplicate commands to history
setopt HIST_IGNORE_DUPS   # ignores immediate duplicate commands
setopt HIST_IGNORE_SPACE  # ignores commands with spaces before, useful for sensitive commands
setopt CORRECT            # spelling correction


### ALIASES
source $ZDOTDIR/aliases


### AUTO-SUGGESTIONS
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh


### COMPLETION
autoload -Uz compinit; compinit
zstyle ':completion:*' menu select


## STARTUP ZOXIDE AND CD ALIAS
eval "$(zoxide init --cmd cd zsh)"


### AUTO-START SSH-AGENT (only one at a time)
touch "$XDG_RUNTIME_DIR/ssh-agent.env"
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [ ! -f "$SSH_AUTH_SOCK" ]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi


### ENABLE SMART HISTORY SEARCH
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search


### MAPPINGS

# zsh history search
bindkey "^k" up-line-or-beginning-search
bindkey "^j" down-line-or-beginning-search

# SHIFT+TAB for going back on the menu list
bindkey "^[[Z" reverse-menu-complete


### STARTUP STARSHIP
eval "$(starship init zsh)"


### SYNTHAX HIGHTLIGHTING PLUGIN - Has to be in the last line
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
