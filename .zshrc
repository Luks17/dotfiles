# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/luks/.zshrc'

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select

autoload -Uz promptinit
promptinit

# End of lines added by compinstall
#
neofetch
PROMPT='%F{027}%n%f in %F{154}[ %~ ]%f -> '
