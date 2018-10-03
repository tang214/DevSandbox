#!/usr/bin/env bash

# set -eo pipefail

################################################################################
# TUI Functions
################################################################################
# Colors
# shellcheck disable=SC1117
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"

function banner() {
  clear
  # shellcheck disable=SC1004
  echo -e "$COL_GREEN"'
      ___           ___                       ___           ___
     /\__\         /\__\          ___        /\  \         /\__\
    /:/  /        /::|  |        /\  \      /::\  \       /::|  |
   /:/  /        /:|:|  |        \:\  \    /:/\:\  \     /:|:|  |
  /:/  /  ___   /:/|:|  |__      /::\__\  /:/  \:\  \   /:/|:|  |__
 /:/__/  /\__\ /:/ |:| /\__\  __/:/\/__/ /:/__/ \:\__\ /:/ |:| /\__\
 \:\  \ /:/  / \/__|:|/:/  / /\/:/  /    \:\  \ /:/  / \/__|:|/:/  /
  \:\  /:/  /      |:/:/  /  \::/__/      \:\  /:/  /      |:/:/  /
   \:\/:/  /       |::/  /    \:\__\       \:\/:/  /       |::/  /
    \::/  /        /:/  /      \/__/        \::/  /        /:/  /
     \/__/         \/__/                     \/__/         \/__/
'"$COL_RESET"
}

function bot() {
  # shellcheck disable=SC1117
  echo -e "\n$COL_GREEN\[._.]/$COL_RESET - $1"
}

function action() {
  # shellcheck disable=SC1117
  echo -e "\n$COL_YELLOW[action]:$COL_RESET\n ⇒ $1..."
}

function warn() {
  # shellcheck disable=SC1117
  echo -e "$COL_YELLOW[warning]$COL_RESET\n ⇒ $1"
}

function error() {
  # shellcheck disable=SC1117
  echo -e "$COL_RED[error]$COL_RESET\n ⇒ $1"
}

function info() {
  # shellcheck disable=SC1117
  echo -e "$COL_GREEN[info]$COL_RESET\n ⇒ $1"
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
    ( cd "$2" || exit; git checkout master && git pull origin master && git submodule update --recursive > /dev/null 2>&1 )
    ( cd "$2" || exit; git checkout develop && git pull origin develop && git submodule update --recursive > /dev/null 2>&1 )
  else
    action "clone $1"
    git clone --recurse-submodules "$1" "$2" > /dev/null 2>&1
  fi
}

function get_platform() {
  # action "attempt detecting platform"
  # shellcheck disable=SC2003
  if [ "$(uname -s)" == "Darwin" ]; then
    # Do something for OSX
    export NS_PLATFORM="darwin"
  elif [ "$(expr substr "$(uname -s)" 1 5)" == "Linux" ]; then
  	# Do something for Linux platform
  	# assume ubuntu - but surely this can be extended to include other distros
  	export NS_PLATFORM="linux"
    if [ -f '.usesudo' ]; then
      export PREFIX='sudo'
    fi
  elif [ "$(expr substr "$(uname -s)" 1 10)" == "MINGW32_NT" ]; then
    # Do something for Windows NT platform
  	export NS_PLATFORM="windows"
    echo "windoze detected"
    die "Windows not yet supported"
  fi
}

function require_cask() {
  action "brew cask $1"
  brew cask list "$1" > /dev/null 2>&1
  # shellcheck disable=SC2181
  if [[ "$?" != "0" ]]; then
    action "brew cask install $1 $2"
    brew cask install "$1"
    if [[ "$?" != 0 ]]; then
      error "failed to install $1! aborting..."
      # exit -1
    fi
  fi
}

function list_containers() {
  echo "1. ldap.burningflipside.local"
  echo "2. mysql.burningflipside.local"
  echo "3. mongo.burningflipside.local"
  echo "4. www.burningflipside.local"
  echo "5. wiki.burningflipside.local"
  echo "6. profiles.burningflipside.local"
  echo "7. secure.burningflipside.local"
  echo "8. swagger.burningflipside.local"
}

function instance_name_from_selection() {
  case "$1" in
    1) instance=ldap.burningflipside.local
      ;;
    2) instance=mysql.burningflipside.local
      ;;
    3) instance=mongo.burningflipside.local
      ;;
    4) instance=www.burningflipside.local
      ;;
    5) instance=wiki.burningflipside.local
      ;;
    6) instance=profiles.burningflipside.local
     ;;
    7) instance=secure.burningflipside.local
      ;;
    8) instance=swagger.burningflipside.local
      ;;
    *)
      instance=""
      ;;
  esac
  echo "$instance"
}
