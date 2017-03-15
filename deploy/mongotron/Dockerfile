FROM debian:jessie

ENV VERSION 1.0.0-alpha.5

RUN apt-get update && apt-get -y install \
    ca-certificates \
    curl \
    libasound2 \
    libgconf-2-4 \
    libgtk2.0-0 \
    libnss3 \
    libxtst6 \
    nano \
    unzip \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/officert/mongotron/releases/download/$VERSION/Mongotron-linux-x64.zip -o Mongotron-linux-x64 && \
    unzip Mongotron-linux-x64.zip && \
    mv Mongotron-linux-x64 Mongotron && \
    rm Mongotron-linux-x64.zip

RUN groupadd -r mongotron && \ 
    useradd -r -g mongotron -G audio,video mongotron && \
    chown -R mongotron:mongotron /home/mongotron

USER mongotron

ENV HOME /home/mongotron

WORKDIR /home/mongotron

ENTRYPOINT [ "/home/mongotron/Mongotron" ]
