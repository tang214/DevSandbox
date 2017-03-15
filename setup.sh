#!/usr/bin/env bash

source ./bin/functions.sh

get_platform

banner

bot "Lets get you set up"

./bin/repos

if [ ! -d '.volumes' ]; then
  action "create shared data volume dir"
  mkdir .volumes
  mkdir .volumes/session
  chmod 777 .volumes/session
  ok
fi

if [ ! -f 'docker-compose.yml' ]; then
  action "writing docker-compose.yml"
  sed -e s%/BURNINGFLIPSIDE%`pwd`%g docker-compose.tpl > docker-compose.yml
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
  sudo sed 's/\#X11Forwarding no/X11Forwarding yes/g' /etc/ssh/sshd_config
fi
if [ "$NS_PLATFORM" == "linux" ]; then
  # built in
  sudo sed 's/\#   ForwardX11 no/ForwardX11 yes/g' /etc/ssh/ssh_config
fi
# if [ "$NS_PLATFORM" == "windows" ]; then
#   install xming
# fi

./bin/images 1

action "seeding browsercap cache"
./bin/seed 1
ok

action "seeding mongo databases"
./bin/seed 2
ok

action "seeding mysql databases"
./bin/seed 3
warn "record mysl root password now.. it will not be retrievable later"
ok

warn "run docker-compose up"
warn "and point your browser to https://localhost:3300"
