FROM debian:jessie

RUN apt-get update && apt-get -y install \
    ca-certificates \
    curl \
    desktop-file-utils \
    libcairo2 \
    libglib2.0-0 \
    libgl1-mesa-glx \
    libqt5core5a \
    libqt5gui5 \
    libx11-xcb1 \
    nano \
    shared-mime-info \
    xdg-utils \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -L "http://www.valentina-db.com/en/studio/download/current/vstudio_x64_lin-deb?format=raw" -o vstudio_x64_lin.deb && \
    dpkg --install vstudio_x64_lin.deb && \
    rm -f vstudio_x64_lin.deb

# Add application user
RUN mkdir -p /home/valentina && \
    groupadd -r valentina && \ 
    useradd -r -g valentina -G audio,video valentina && \
    chown -R valentina:valentina /home/valentina

# run apache directory studio as non privileged user
USER valentina

ENV HOME /home/valentina

WORKDIR /home/valentina

# run apache directory studio
ENTRYPOINT [ "/opt/VStudio/vstudio" ]
CMD [ "" ]
