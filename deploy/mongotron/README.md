# Mongotron

#### Cross platform Mongo DB management http://mongotron.io


run docker container
```
docker run --rm \
    -e DISPLAY=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}'):0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/.mongotron:/home/mongotron/.mongotron \
    burnerdev/mongotron
```
