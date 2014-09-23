
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="mgutz"

DISABLE_UPDATE_PROMPT="true"

# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(bundler cabal gem git heroku mercurial rails rake rbenv ruby sbt scala)

source $ZSH/oh-my-zsh.sh        # Required

# PROMPT="
# %c%# "

echo > "$HOME/.local/share/recently-used.xbel"
touch  "$HOME/.local/share/recently-used.xbel"
echo "gtk-recent-files-max-age=0" > "$HOME/.gtkrc-2.0"

xinput -set-prop "TPPS/2 IBM TrackPoint" "Device Enabled" 0

# echo 2 > /sys/module/hid_apple/parameters/fnmode

export EMACSCLIENT="emacsclient --create-frame --no-wait --alternate-editor=''"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
else
  export EDITOR="$EMACSCLIENT"
fi

function reload() {
  cp $DOTFILES/.zshrc ~
  echo "Copied $DOTFILES/.zshrc to ~"

  . ~/.zshrc
  echo "Reloaded .zshrc from ~"
}

alias cl="clear"
alias open="xdg-open"

alias v="gvim 2> /dev/null"
alias e="$EMACSCLIENT"
alias s="subl"

alias git-pull-all="$SCRIPTS/git-pull-all.sh"

alias hlog="hg log --template '#{rev} {date|isodate} {desc|firstline}\n' | less"

export DROPBOX="$HOME/Dropbox"
export CODE="$DROPBOX/Code"
export DOTFILES="$CODE/dotfiles"
export SCRIPTS="$CODE/scripts"

alias code="cd $CODE"
alias dotfiles="cd $DOTFILES"

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

export PATH="$HOME/.opam/4.01.0/bin:$PATH"
eval `opam config env`

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export PATH="$HOME/.cabal/bin:$PATH"
