FROM php:7.1-apache

RUN buildDeps=" \
  libfreetype6-dev \
  libgmp-dev \
  libjpeg62-turbo-dev \
  libldap2-dev \
  libmagickwand-dev \
  libmagickcore-dev \
  libmemcached-dev \
  libmysqlclient15-dev \
  libpng12-dev \
  libpq-dev \
  libpspell-dev \
  librecode-dev \
  libsqlite3-dev \
  libsqlite3-0 \
  libssh2-1-dev \
  libssl-dev \
  libxml2-dev \
  libxpm-dev \
  libxslt-dev \
  libxslt1-dev \
  libyaml-dev \
  zlib1g-dev \
  wget \
  "; \
  set -x \
  && apt-get update && apt-get install -y $buildDeps --no-install-recommends \
    libfreetype6 libjpeg62 libx11-6 libxpm4 libxml2 \
    libmcrypt4 libltdl7 libxslt1.1 ssmtp mysql-client ssl-cert \
  && rm -rf /var/lib/apt/lists/* \
  \
  && ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
  && docker-php-ext-configure gd \
    --with-jpeg-dir=/usr/include/ \
    --with-freetype-dir=/usr/include/ \
    --with-xpm-dir=/usr/include/ \
  && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
  && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
  && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
  \
  && docker-php-ext-install -j$(nproc) \
    bz2 \
    calendar \
    ftp \
    hash \
    gettext \
    gd \
    gmp \
    iconv \
    json \
    ldap \
    mbstring \
    mysqli \
    opcache \
    pcntl \
    pdo_mysql pdo_sqlite \
    phar \
    posix \
    shmop \
    simplexml \
    sockets \
    sysvmsg sysvsem sysvshm \
    exif \
    wddx \
    xsl \
    zip \
  \
  && wget http://pear.php.net/go-pear.phar \
  && php go-pear.phar \
  # && pear install \
  # pear installs the following automagically
  #   Archive_Tar-1.4.0 \
  #   Console_Getopt-1.4.1 \
  #   Structures_Graph-1.1.1 \
  #   XML_Util-1.3.0 \
  #   PEAR-1.10.1 \
  \
  && pecl install \
  # example for including pecl libs
  #   xdebug-2.4.0 \
  #   mongo-1.6.14 \
  #   memcached-2.2.0 \
  #   redis-2.2.8 \
  #   ssh2-0.12 \
  #   yaml-1.2.0 \
  #   imagick-3.4.1 \
  # \
  # && rm -rf /tmp/*
  \
  && a2enmod expires \
  && a2enmod headers \
  && a2enmod remoteip \
  && a2enmod rewrite \
  && a2enmod ssl \
  && a2ensite default-ssl \
  && a2dissite 000-default
  # && apt-get purge -y --auto-remove $buildDeps
  # && cd /usr/src/php \
  # && make clean

  RUN { \
      echo ';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;' \
      echo '; Burning Flipside App Mods      ;' \
      echo ';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;' \
      echo 'include_path = .:/var/www/common:/usr/share/pear' \
      echo 'output_buffering = 1' \
      echo '' \
  		echo '[Session]'; \
  		echo 'session.cookie_domain = .burningflipside.com'; \
  		echo 'session.save_path = /var/lib/php/session'; \
  	} | tee "/usr/local/etc/php/conf.d/docker-php-ext-session.ini" \

# RUN sed -i \
#   -e "s|  |  |g" \
#   ${php_conf}

EXPOSE 443

# ENTRYPOINT ["phpinfo();"]
