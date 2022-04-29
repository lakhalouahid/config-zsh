source /etc/environment
bindkey -v
autoload -Uz compinit
compinit


HISTFILE=$ZDOTDIR/.histfile
SAVEHIST=10000
HISTSIZE=10000

[ -f "$HOME/.exports" ] && source "$HOME/.exports"
[ -f "$BASHDIR/.aliases.sh"   ] && source "$BASHDIR/.aliases.sh"
[ -f "$BASHDIR/.functions.sh" ] && source "$BASHDIR/.functions.sh"
[ -f "$ZDOTDIR/.gh-copilot.zsh" ] && source "$ZDOTDIR/.gh-copilot.zsh"

bindkey "^[e" _expand_alias
setopt interactivecomments
zstyle ':completion:*' _expand_alias

stty -ixon
# vi mode
export KEYTIMEOUT=1



# Change cursor shape for different vi modes.
zle-keymap-select() {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne '\e[6 q'
}
zle -N zle-line-init

echo -ne '\e[6 q' # Use beam shape cursor on startup.

preexec() { echo -ne '\e[6 q' ;} # Use beam shape cursor for each new prompt.


# Yank
vi-yank-xclip() {
  zle vi-yank
  print -rn -- $CUTBUFFER | xclip -r -i -selection clipboard;
}
zle -N vi-yank-xclip

bindkey -M vicmd 'y' vi-yank-xclip

# Autosuggestions
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^a' autosuggest-accept

# MOJO
export MODULAR_HOME="$HOME/.modular"
export PATH="$HOME/.modular/pkg/packages.modular.com_mojo/bin:$PATH"

eval "$(starship init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias crdir='source crdir'
alias sros='source ~/.zsh_ros'
alias edpo='xrandr --output eDP-1 --auto'
alias edpf='xrandr --output eDP-1 --off'

ghcs() {
    gh copilot suggest -t shell $@
}


export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

pyenv() {
    eval "$(command pyenv init -)"
    eval "$(command pyenv virtualenv-init -)"
    pyenv "$@"
}

source ~/.config/zsh/.autojump.zsh


export MODULAR_HOME="/home/ouahid/.modular"
export PATH="/home/ouahid/.modular/pkg/packages.modular.com_mojo/bin:$PATH"


fpath+=~/.zfunc

source ~/.config/zsh/lxd-completion-zsh/lxd-completion-zsh.plugin.zsh
