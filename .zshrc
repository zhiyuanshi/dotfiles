#+BABEL: :cache yes
.zshrc

Evaluate the following piece of code every time you've made change to this file.

#+BEGIN_SRC emacs-lisp :tangle no
(save-buffer)
(org-babel-tangle)
(rename-file ".zshrc.sh" ".zshrc" t) ;; TODO: We could have directly export to .zshrc!
#+END_SRC

* Make sure oh-my-zsh is installed

#+BEGIN_SRC sh :tangle yes
[ -d ~/.oh-my-zsh ] || curl -L http://install.ohmyz.sh | sh
#+END_SRC

* Provided by oh-my-zsh

Path to your oh-my-zsh installation.

#+BEGIN_SRC sh :tangle yes
export ZSH=~/.oh-my-zsh
#+END_SRC

Set name of the theme to load.
Look in ~/.oh-my-zsh/themes/
Optionally, if you set this to "random", it'll load a random theme each
time that oh-my-zsh is loaded.

#+BEGIN_SRC sh :tangle yes
ZSH_THEME="mgutz"
#+END_SRC

Automatically update zsh itself without prompting me.

#+BEGIN_SRC sh :tangle yes
DISABLE_UPDATE_PROMPT="true"
#+END_SRC

Uncomment the following line if you want to disable marking untracked files
under VCS as dirty. This makes repository status check for large repositories
much, much faster.

#+BEGIN_SRC sh :tangle yes
# DISABLE_UNTRACKED_FILES_DIRTY="true"
#+END_SRC

* Plugins

#+BEGIN_SRC sh :tangle yes
plugins=(bundler cabal capistrano gem git heroku mercurial rails rake rbenv ruby sbt scala)
#+END_SRC

* Source oh-my-zsh.sh

#+BEGIN_SRC sh :tangle yes
source $ZSH/oh-my-zsh.sh        # Required
#+END_SRC

* User configuration
** Prompt

#+BEGIN_SRC sh :tangle yes
# PROMPT="
# %c%# "
#+END_SRC

** Tasks on Zsh start-up
*** Clear "Recently Used"

#+BEGIN_SRC sh :tangle yes
if [ -e ~/.local/share/recently-used.xbel ]; then
  echo > ~/.local/share/recently-used.xbel
  touch  ~/.local/share/recently-used.xbel
fi

[ -f ~/.gtkrc-2.0 ] && echo "gtk-recent-files-max-age=0" > ~/.gtkrc-2.0
#+END_SRC

*** Disable ThinkPad TrackPoint

#+BEGIN_SRC sh :tangle yes
if which xinput &>/dev/null; then
  xinput -set-prop "TPPS/2 IBM TrackPoint" "Device Enabled" 0
fi
#+END_SRC

*** Invert behavior of Fn key on Apple keyboard

https://help.ubuntu.com/community/AppleKeyboard#Change_Function_Key_behavior

#+BEGIN_SRC sh :tangle yes
# echo 2 > /sys/module/hid_apple/parameters/fnmode
#+END_SRC

** Preferred editor for local and remote sessions

#+BEGIN_SRC sh :tangle yes
export EMACSCLIENT="emacsclient --create-frame --no-wait --alternate-editor=''"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
else
  export EDITOR="$EMACSCLIENT"
fi
#+END_SRC

** Shortcuts to directories

#+BEGIN_SRC sh :tangle yes
# http://stackoverflow.com/a/23259585/1895366
export ZSHRC=${(%):-%N}
export DOTFILES=$(dirname $(readlink -f $ZSHRC))

export DROPBOX="~/Dropbox"
export CODE="$DROPBOX/Code"
export SCRIPTS="$CODE/scripts"

alias code="cd $CODE"
alias dotfiles="cd $DOTFILES"
#+END_SRC

** Aliases
*** General

#+BEGIN_SRC sh :tangle yes
alias cl="clear"
alias open="xdg-open"
#+END_SRC

*** Text editors

#+BEGIN_SRC sh :tangle yes
alias v="gvim 2> /dev/null"
alias e="$EMACSCLIENT"
alias s="subl"
alias a="atom"
#+END_SRC

*** Running Java with one command

Something similar to =runhaskell=, why didn't we have one?

Extracted from the following Japanese blog post:
http://matsu-chara.hatenablog.com/entry/2014/05/17/210000

Also, see:
http://itchyny.hatenablog.com/entry/20130227/1361933011

#+BEGIN_SRC sh :tangle yes
function runjava() {
  javac $1
  class_name=${${1}%.java}
  shift
  java $class_name $@
  rm $class_name.class
}
#+END_SRC

*** Git & Mercurial

#+BEGIN_SRC sh :tangle yes
alias git-pull-all="$SCRIPTS/git-pull-all.sh"

alias hlog="hg log --template '#{rev} {date|isodate} {desc|firstline}\n' | less"
#+END_SRC

*** Utils

https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-14-04-lts

#+BEGIN_SRC sh :tangle yes
alias find-my-ip="ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'"
alias upgrade-system="sudo apt-get update && sudo apt-get -y dist-upgrade"
#+END_SRC

** Functions
#+BEGIN_SRC sh :tangle yes
disable-post-installation-script() {
  sudo mv "/var/lib/dpkg/info/$1.postinst" "/var/lib/dpkg/info/$1.postinst.original"
}
#+END_SRC
** nvm (Node Version Manager)

#+BEGIN_SRC sh :tangle yes
export NVM_DIR="~/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
#+END_SRC

** PostgreSQL

https://devcenter.heroku.com/articles/heroku-postgresql#local-setup
Once Postgres is installed and you can connect, you'll need to export the
DATABASE_URL environment variable for your app to connect to it when running
locally. E.g.:

#+BEGIN_SRC sh :tangle no
export DATABASE_URL=postgres:///$(whoami)
#+END_SRC

** nginx

http://railscasts.com/episodes/357-adding-ssl

#+BEGIN_SRC sh :tangle yes
nginx-load-conf-and-restart() {
  sudo cp $DOTFILES/nginx.conf /etc/nginx/nginx.conf
  sudo nginx -t
  sudo service nginx restart
}
#+END_SRC

** PATH

Defined in =/etc/environment=

#+BEGIN_SRC sh :tangle yes
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
#+END_SRC

#+BEGIN_SRC sh :tangle yes
if which opam &>/dev/null ; then
  export PATH="~/.opam/4.01.0/bin:$PATH"
  source ~/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
  eval `opam config env`
fi

function defined { command -v $1 &>/dev/null }
function require { source "$DOTFILES/$1.sh" }

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# fzf, depends on Ruby
# A general-purpose fuzzy finder for your shell
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# cabal
export PATH=~/.cabal/bin:$PATH
#+END_SRC

Activator is the command-line tool for the Play Framework.
https://www.playframework.com/documentation/2.3.x/Installing

#+BEGIN_SRC sh :tangle yes
export PATH=$PATH:~/Applications/activator-1.2.12-minimal
#+END_SRC
