
### I/O pre-instant prompt
pfetch
if [[ "$(tty)" == "/dev/tty1" ]]; then
  Hyprland
fi


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


### OPTIONS
setopt HIST_IGNORE_DUPS   # ignores immediate duplicate commands
setopt CORRECT            # spelling correction


### ALIASES
source $ZDOTDIR/aliases


### PLUGINS
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme


### COMPLETION
autoload -U compinit; compinit
zstyle ':completion:*' menu select
# SHIFT+TAB for going back on the menu list
bindkey "^[[Z" reverse-menu-complete

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

### SYNTHAX HIGHTLIGHTING PLUGIN - Has to be in the last line
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
