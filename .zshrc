bindkey -v
autoload -Uz compinit
compinit

export PS1="%1(j.[%j] .)$ "
[ -f "$HOME/.exports" ] && source "$HOME/.exports"
[ -f "$BASHDIR/.aliases.sh"   ] && source "$BASHDIR/.aliases.sh"
[ -f "$BASHDIR/.functions.sh" ] && source "$BASHDIR/.functions.sh"
source /etc/profile



HISTFILE='/home/user/.histfile'
SAVEHIST=0
# if Xorg is running, run randr
[ ! -z ${DISPLAY:+x} ] && xrandr --output $DP --auto

bindkey "^[e" _expand_alias
setopt interactivecomments
zstyle ':completion:*' _expand_alias
# Disable Xon/Off
stty -ixon
# vi mode
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
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

vi-yank-x-selection () {
  print -rn -- $CUTBUFFER | xclip -i -selection clipboard;
}
zle -N vi-yank-x-selection
bindkey -a '^Y' vi-yank-x-selection

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
