FROM debian:jessie

ENV VERSION 2.0.0.v20161101-M12

ENV MIRROR https://www.apache.org/dist/directory/studio
    
RUN apt-get update && apt-get -y install \
    default-jre \
    ca-certificates \
    libgtk2.0-0 \
    libcanberra-gtk-module \
    curl \
    nano \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -L "$MIRROR/$VERSION/ApacheDirectoryStudio-$VERSION-linux.gtk.x86_64.tar.gz.md5" -o ApacheDirectoryStudio.tar.gz.md5 && \
    curl -L "$MIRROR/$VERSION/ApacheDirectoryStudio-$VERSION-linux.gtk.x86_64.tar.gz.asc" -o ApacheDirectoryStudio.tar.gz.asc && \
    curl -L "$MIRROR/$VERSION/ApacheDirectoryStudio-$VERSION-linux.gtk.x86_64.tar.gz" -o ApacheDirectoryStudio.tar.gz && \
    tar -xvzf ApacheDirectoryStudio.tar.gz && \
    mv ApacheDirectoryStudio /home/apache && \
    rm ApacheDirectoryStudio.tar.gz

# verify md5 signature
# verigy pgp signature
# https://www.apache.org/dist/directory/KEYS
# $ gpg --import KEYS
# $ gpg --verify ApacheDirectoryStudio.tar.gz.asc

# Add application user
RUN groupadd -r apache && \ 
    useradd -r -g apache -G audio,video apache && \
    chown -R apache:apache /home/apache

# run apache directory studio as non privileged user
USER apache

ENV HOME /home/apache

WORKDIR /home/apache

# run apache directory studio
ENTRYPOINT [ "/home/apache/ApacheDirectoryStudio" ]
CMD [ "" ]
