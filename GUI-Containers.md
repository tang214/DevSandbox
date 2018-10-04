# GUI containers

this repo includes several GUI application containers.

making these run on your system may require extra setup.

## setup example for OSX

install xQuartz

```sh
brew cask install xQuartz
```

edit ssh config

```sh
sudo sed 's/\#X11Forwarding no/X11Forwarding yes/g' /etc/ssh/sshd_config 
```

restart sshd

```sh
/etc/init.d/sshd restart
```

add ip address to list of allowed remotes for xhost

```sh
xhost + $(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
```

export DOCKER_DISPLAY env var from your .bash_profile

```sh
export DOCKER_DISPLAY=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}'):0 \
```
