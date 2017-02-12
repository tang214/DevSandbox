#
# ./mysql
#

Use docker to spin up a temporary container to create databases and users
then destroy the container leaving no trace of passwords in command line history
on your public services

generate the initialization container
```bash
docker run --rm \
  --name mysql.init \
  -v ~/src/FlipsideDeveloper/.volumes/mysql:/var/lib/mysql/ \
  -v ~/src/FlipsideDeveloper/deploy/mysql/data:/docker-entrypoint-initdb.d \
  -p 3306:3306 \
  -e MYSQL_RANDOM_ROOT_PASSWORD=1 \
  burnerdev/mysql:5.7
```

search the log output for the line that looks like

GENERATED ROOT PASSWORD:
GENERATED ROOT PASSWORD: iVeengah9ohphooqui1Ierae5airoh6L
GENERATED ROOT PASSWORD:

and make a note of the generated PASSWORD

open a new terminal window and issue the command to stop the mysql.init container
```bash
docker stop mysql.init
```

now the shared volume should contain the users and databases we need
as well as sample mysql data
