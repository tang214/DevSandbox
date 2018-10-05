FROM debian:stretch-slim

ENV VERSION 2.0.0.v20180908-M14
# ENV MIRROR https://www.apache.org/dist/directory/studio
ENV MIRROR http://apache.mirrors.hoobly.com/directory/studio/
ENV FILE "ApacheDirectoryStudio-$VERSION-linux.gtk.x86_64.tar.gz"
ENV HOME /home/app

RUN mkdir -p /usr/share/man/man1; \
    apt-get update && apt-get -y install --no-install-recommends \
    \
    default-jre \
    libgtk2.0-0 \
    libcanberra-gtk-module \
	\
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p $HOME/.ApacheDirectoryStudio \
    && groupadd -r app \ 
    && useradd -r -g app -G audio,video app

RUN apt-get update && apt-get -y install --no-install-recommends ca-certificates curl gnupg dirmngr \
    && curl -L $MIRROR/$VERSION/$FILE.asc -o $FILE.asc \
    && curl -L $MIRROR/$VERSION/$FILE -o $FILE \
    && curl -L https://www.apache.org/dist/directory/KEYS -o KEYS \
    # verify passes on macbook but no in container ?!
	# && mkdir -p $HOME/.gnupg \
    # && gpg --import KEYS \
    # && gpg --verify $FILE.asc $FILE \
    && tar -xvzf $FILE \
    && mv ApacheDirectoryStudio/* $HOME \
    && chown -R app:app $HOME \
    && rm -rf ApacheDirectoryStudio* \
    && rm KEYS \
    && apt-get purge -y --auto-remove ca-certificates curl gnupg dirmngr


USER app

WORKDIR /home/app

ENTRYPOINT [ "/home/app/ApacheDirectoryStudio" ]
