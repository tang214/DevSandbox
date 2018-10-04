# ./mongo

Use docker to spin up a temporary container to create databases and collections
then destroy the container leaving no trace of passwords in command line history
on your public services

generate the initialization container

```sh
docker run --rm \
  --name mongo.init \
  -v ~/src/FlipsideDeveloper/.volumes/mongo/db:/data/db/ \
  -v ~/src/FlipsideDeveloper/.volumes/mongo/configdb:/data/configdb/ \
  -v ~/src/FlipsideDeveloper/deploy/mongo/data:/docker-entrypoint-initdb.d \
  -p 27017:27017 \
  burnerdev/mongo:3.4
```

open a new terminal window and issue the command to stop the mysql.init container

```sh
docker stop mongo.init
```

now the shared volume should contain the users and databases we need

to add a database or collection to the system place files into the deploy/mongo/data directory
name the files <database>-<collection>.json

each time you run this container your mongo data will be destroyed and reset.
