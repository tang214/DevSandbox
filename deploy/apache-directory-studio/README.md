# Apache Directory Studio™

#### The Eclipse-based LDAP browser and directory client

to make this container work on OSX i had to do the following

install xQuartz
```
brew cask install xQuartz
```

edit ssh config
```
sudo nano /etc/ssh/sshd_config    
```
look for the folloiwng lines

#X11Forwarding no

#X11UseLocalhost yes

uncomment and change no to yes for each line. save and reboot


determine your ip address
```
ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
```

add ip address to list of allowed remotes for xhost
```
xhost + $ip
```

run docker container
```
docker run --rm \
    -e DISPLAY=$ip:0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/.ApacheDirectoryStudio:/home/apache/.ApacheDirectoryStudio \
    burnerdev/apache-directory-studio
```
