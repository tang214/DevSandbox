#!/usr/bin/env bash

source ./bin/functions.sh

banner

bot "Lets get you set up"

if [ -f '.githubuser' ]; then
  githubuser=`cat .githubuser`
else
  read -r -p "What is the github.com username or organization from which we will pull source? " githubuser
  echo "$githubuser" > .githubuser
fi

git_clone_or_update git@github.com:$githubuser/CommonCode.git src/common
action "init / update common code submodules"
( cd src/common && git submodule init > /dev/null 2>&1 && git submodule update > /dev/null 2>&1 )
ok

git_clone_or_update git@github.com:$githubuser/Profiles.git src/profiles

git_clone_or_update git@github.com:$githubuser/SecureFramework.git src/secure
action "init / update secure framework submodules"
( cd src/secure && git submodule init > /dev/null 2>&1 && git submodule update > /dev/null 2>&1 )
ok

if [ ! -d '.volumes' ]; then
  action "create shared data volume dir"
  mkdir .volumes
  mkdir .volumes/session
  chmod 777 .volumes/session; ok
fi

if [ ! -f 'docker-compose.yml' ]; then
  action "writing docker-compose.yml"
  sed -e s%/BURNINGFLIPSIDE%`pwd`%g docker-compose.tpl > docker-compose.yml; ok
fi

if [ ! -f 'src/secure_settings/class.FlipsideSettings.php' ]; then
  action "writing class.FlipsideSettings.php"
  cp src/secure_settings/class.FlipsideSettings.example src/secure_settings/class.FlipsideSettings.php; ok
fi

if [ ! -f 'src/secure_settings/client_secret.json' ]; then
  action "writing client_secret.json"
  cp src/secure_settings/client_secret.example src/secure_settings/client_secret.json; ok
fi

if [ ! -f 'src/secure_settings/aws.ini' ]; then
  action "writing aws.ini"
  cp src/secure_settings/aws.example src/secure_settings/aws.ini; ok
fi

action "fetch ldap image"
docker pull burnerdev/openldap:1.1.8; ok

action "fetch mongo image"
docker pull burnerdev/mongo:3.4; ok

warn "in a new terminal execute bin/seed to seed mongo database"
warn "see deploy/mongo/SEEDME.md for detailed instructions"

action "fetch mysql image"
docker pull burnerdev/mysql:5.7; ok

warn "in a new terminal execute bin/seed to seed your mysql database"
warn "see deploy/mysql/SEEDME.md for detailed instructions"

action "fetch php base image"
docker pull php:7.1-apache; ok

action "fetch web service image"
docker pull burnerdev/php:7.1-apache; ok

action "fetch wordpress image"
docker pull burnerdev/wordpress:4.7.2; ok

warn "once you've seeded your databases"
warn "run docker-compose up"
warn "and point your browser to https://localhost:3300"
