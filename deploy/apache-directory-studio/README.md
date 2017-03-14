# Apache Directory Studio™

#### The Eclipse-based LDAP browser and directory client

to make this container work on OSX i had to do the following

install xQuartz
```
brew cask install xQuartz
```

edit ssh config
```
sudo sed 's/\#X11Forwarding no/X11Forwarding yes/g' /etc/ssh/sshd_config 
sudo sed 's/\#X11UseLocalhost yes/X11UseLocalhost yes/g' /etc/ssh/sshd_config 
```

add ip address to list of allowed remotes for xhost
```
xhost + $(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
```

run docker container
```
docker run --rm \
    -e DISPLAY=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}'):0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/.ApacheDirectoryStudio:/home/apache/.ApacheDirectoryStudio \
    burnerdev/apache-directory-studio
```
