FROM debian:jessie

RUN apt-get update && apt-get -y install \
    ca-certificates \
    curl \
    libglib2.0-0 \
	libgl1-mesa-glx \
    libqt5gui5 \
    libx11-xcb1 \
    nano \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -L "https://download.robomongo.org/1.0.0-rc1/linux/robomongo-1.0.0-rc1-linux-x86_64-496f5c2.tar.gz" -o robomongo.tar.gz && \
    tar -xvzf robomongo.tar.gz && \
    mv robomongo-1.0.0-rc1-linux-x86_64-496f5c2 /home/robomongo && \
    rm -f robomongo.tar.gz

# Add application user
RUN mkdir -p /home/robomongo/.config/robomongo && \
    groupadd -r robomongo && \ 
    useradd -r -g robomongo -G audio,video robomongo && \
    chown -R robomongo:robomongo /home/robomongo

# run apache directory studio as non privileged user
USER robomongo

ENV HOME /home/robomongo

WORKDIR /home/robomongo

# run apache directory studio
ENTRYPOINT [ "/home/robomongo/bin/robomongo" ]
# CMD [ "/bin/sh" ]
