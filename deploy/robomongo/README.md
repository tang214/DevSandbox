# Robomongo

#### 

run docker container
```
export DOCKER_DISPLAY=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}'):0 \
docker run --rm \
    -e DISPLAY=$DOCKER_DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/.config:/home/robomongo/.config \
    burnerdev/robomongo
```
