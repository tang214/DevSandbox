FROM debian:stretch-slim

ENV HOME /home/app

# RUN apt-get update && apt-get -y install --no-install-recommends \
#     default-jre \
#     libgtk2.0-0 \
#     libcanberra-gtk-module \
# 	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p $HOME/.ApacheDirectoryStudio \
    && groupadd -r app \ 
    && useradd -r -g app -G audio,video app

RUN apt-get update && apt-get install -y \ 
  mysql-workbench \
  && apt-get purge -y

WORKDIR ${HOME}

# RUN mkdir -p ${HOME}/workspace && \
#     sudo apt-get install -y libproj-dev gnome-keyring

VOLUME ${HOME}/workspace
VOLUME ${HOME}/.mysql/workbench

CMD ["mysql-workbench"]
