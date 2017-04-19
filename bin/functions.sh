#!/usr/bin/env bash

# set -eo pipefail

################################################################################
# TUI Functions
################################################################################
# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"

function banner() {
  clear
  echo -e "$COL_GREEN"'
               _                      _
  ___ ___   __| | ___ _ __ ___  _ __ (_)_ __
 / __/ _ \ / _  |/ _ \  __/ _ \|  _ \| |  _ \
| (_| (_) | (_| |  __/ | | (_) | | | | | | | |
 \___\___/ \__,_|\___|_|  \___/|_| |_|_|_| |_|
'"$COL_RESET"
}

function bot() {
    echo -e "\n$COL_GREEN\[._.]/$COL_RESET - "$1
}

function action() {
    echo -e "\n$COL_YELLOW[action]:$COL_RESET\n ⇒ $1..."
}

function warn() {
    echo -e "$COL_YELLOW[warning]$COL_RESET "$1
}

function error() {
    echo -e "$COL_RED[error]$COL_RESET "$1
}

function info() {
  echo -e "$COL_GREEN[info]$COL_RESET "$1
}

function line() {
  echo -e "------------------------------------------------------------------------------------"
}

function ok() {
    echo -e "$COL_GREEN[ok]$COL_RESET "
}

function die() {
  echo "$@" 1>&2 ; exit 1;
}

function git_clone_or_update() {
  if [ -d "$2/.git" ]; then
    action "update $1"
    ( cd "$2"; git checkout master && git pull origin master > /dev/null 2>&1 )
    ( cd "$2"; git checkout develop && git pull origin develop > /dev/null 2>&1 )
    ok
  else
    action "clone $1"
    git clone "$1" "$2" > /dev/null 2>&1
    ok
  fi
}

function get_platform() {
  if [ "$(uname -s)" == "Darwin" ]; then
    # Do something for OSX
    export NS_PLATFORM="darwin"
    action "darwin platform detected"
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  	# Do something for Linux platform
  	# assume ubuntu - but surely this can be extended to include other distros
  	export NS_PLATFORM="linux"
    if [ -f '.usesudo' ]; then
      export PREFIX='sudo'
    fi
    action "linux platform detected"
  elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # Do something for Windows NT platform
  	export NS_PLATFORM="windows"
    action "windoze platform detected"
    die "Windows not yet supported"
  fi
  ok
}

function require_cask() {
    running "brew cask $1"
    brew cask list $1 > /dev/null 2>&1
    if [[ "$?" != "0" ]]; then
        action "brew cask install $1 $2"
        brew cask install $1
        if [[ $? != 0 ]]; then
            error "failed to install $1! aborting..."
            # exit -1
        fi
    fi
    ok
}
