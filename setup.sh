#!/usr/bin/env bash
# shellcheck disable=SC1090

# set -eo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$DIR/lib/bashui.sh"

get_platform

banner

bot "Lets get you set up"

action "install php and composer package manager for php"
./bin/composer
ok

action "checkout git repo projects"
./bin/repos
ok

if [ ! -d '.volumes' ]; then
  action "create shared data volume dir"
  mkdir .volumes
  mkdir .volumes/session
  chmod 777 .volumes/session
  ok
fi

if [ ! -f 'src/secure_settings/class.FlipsideSettings.php' ]; then
  action "writing class.FlipsideSettings.php"
  cp src/secure_settings/class.FlipsideSettings.example src/secure_settings/class.FlipsideSettings.php
  ok
fi

if [ ! -f 'src/secure_settings/client_secret.json' ]; then
  action "writing client_secret.json"
  cp src/secure_settings/client_secret.example src/secure_settings/client_secret.json
  ok
fi

if [ ! -f 'src/secure_settings/aws.ini' ]; then
  action "writing aws.ini"
  cp src/secure_settings/aws.example src/secure_settings/aws.ini
  ok
fi

if [ "$NS_PLATFORM" == "darwin" ]; then
  require_cask xquartz
  (sudo sed 's/\#X11Forwarding no/X11Forwarding yes/g' /etc/ssh/sshd_config > /dev/null 2>&1)
fi
if [ "$NS_PLATFORM" == "linux" ]; then
  # built in
  (sudo sed 's/\#   ForwardX11 no/ForwardX11 yes/g' /etc/ssh/ssh_config > /dev/null 2>&1)
fi
if [ "$NS_PLATFORM" == "windows" ]; then
  # install xming
  die "windows support not yet implemented in this project"
fi

if [ "$NS_PLATFORM" == "linux" ]; then
    action "creating config persistence dirs for GUI containers"
    (
      mkdir "$HOME"/.ApacheDirectoryStudio  > /dev/null 2>&1
      sudo chown 999:999 "$HOME"/.ApacheDirectoryStudio
      mkdir -p  "$HOME"/.config/robomongo  > /dev/null 2>&1
      sudo chown 999:999 "$HOME"/.config/robomongo
      mkdir -p  "$HOME"/.config/ParadigmaSoft > /dev/null 2>&1
      sudo chown 999:999 "$HOME"/.config/ParadigmaSoft
    )
  ok
fi

./bin/image 1

action "seeding browsercap cache"
./bin/seed 1
ok

action "create jwt keypair"
./bin/jwtkey
ok

action "loading composer dependencies"
./bin/seed 4

action "fixing permissions on browser cache volume"
sudo chown -R www-data:www-data .volumes/php_cache
ok

action "seeding mongo databases"
./bin/seed 2
ok

action "seeding mysql databases"
./bin/seed 3
warn "record mysl root password now.. it will not be retrievable later"
ok

warn "run bin/compose up"
warn "and point your browser to https://localhost:3300"
