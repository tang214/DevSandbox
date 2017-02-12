#
# ./mongo
#

start by building the custom image
```bash
$ make
```

docker run --rm \
  --network src_default \
  --link mongodb:mongo \
  -v /root:/backup \
  mongo:3.4 \
  bash -c ‘mongodump --out /backup --host 172.18.0.3’


docker run --rm \
  --network src_default \
  -v ~/src/BurningFlipside/src/mongo/data:/backup \
  -v ~/src/BurningFlipside/src/.volumes/mongo/db:/data/db/ \
  -v ~/src/BurningFlipside/src/.volumes/mongo/configdb:/data/configdb/ \
  mongo:3.4 \
  bash -c "mongorestore /backup --host 172.18.0.3"
