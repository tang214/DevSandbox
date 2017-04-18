version: "2"

services:

  ldap:
    container_name: ldap.burningflipside.local
    image: burnerdev/openldap:1.1.8
    volumes:
      - /BURNINGFLIPSIDE/.volumes/ldap/database:/var/lib/ldap
      - /BURNINGFLIPSIDE/.volumes/ldap/config:/etc/ldap/slapd.d
    ports:
      - "389:389"
      - "636:636"
    restart: always
    networks:
      flipside:
        ipv4_address: 172.25.0.101

  mysql:
    container_name: mysql.burningflipside.local
    image: burnerdev/mysql:5.7
    volumes:
      - /BURNINGFLIPSIDE/.volumes/mysql:/var/lib/mysql/
    ports:
      - "3306:3306"
    restart: always
    networks:
      flipside:
        ipv4_address: 172.25.0.102

  mongo:
    container_name: mongo.burningflipside.local
    image: burnerdev/mongo:3.4
    volumes:
      - /BURNINGFLIPSIDE/.volumes/mongo/db:/data/db/
      - /BURNINGFLIPSIDE/.volumes/mongo/configdb:/data/configdb/
    ports:
      - "27017:27017"
    restart: always
    networks:
      flipside:
        ipv4_address: 172.25.0.103

  appserver:
    image: burnerdev/php-appserver:7.1-apache
    env_file:
      - secrets/envvars
    volumes:
      - /BURNINGFLIPSIDE/src/secure_settings:/var/www/secure_settings
      - /BURNINGFLIPSIDE/src/common:/var/www/common
      - /BURNINGFLIPSIDE/.volumes/session:/var/lib/php/session
      - /BURNINGFLIPSIDE/.volumes/browser:/var/php_cache/browser
    restart: always


  # www:
  #   container_name: www.burningflipside.local
  #   extends:
  #     service: appserver
  #   env_file:
  #     - secrets/www/envvars
  #   volumes:
  #     - /BURNINGFLIPSIDE/src/www:/var/www/html
  #   ports:
  #     - "3100:443"
  #   depends_on:
  #     - ldap
  #     - mysql
  #   networks:
  #     flipside:
  #       ipv4_address: 172.25.0.104


  # wiki:
  #   container_name: wiki.burningflipside.local
  #   extends:
  #     service: appserver
  #   env_file:
  #     - secrets/wiki/envvars
  #   volumes:
  #     - /BURNINGFLIPSIDE/src/wiki:/var/www/html
  #   ports:
  #     - "3200:443"
  #   depends_on:
  #     - ldap
  #     - mysql
  #   networks:
  #     flipside:
  #       ipv4_address: 172.25.0.105

  profiles:
    container_name: profiles.burningflipside.local
    extends:
      service: appserver
    env_file:
      - secrets/profiles/envvars
    volumes:
      - /BURNINGFLIPSIDE/src/profiles:/var/www/html
    ports:
      - "3300:443"
    depends_on:
      - ldap
      - mysql
      - mongo
    networks:
      flipside:
        ipv4_address: 172.25.0.106

  secure:
    container_name: secure.burningflipside.local
    extends:
      service: appserver
    env_file:
      - secrets/secure/envvars
    volumes:
      - /BURNINGFLIPSIDE/src/secure:/var/www/html
    ports:
      - "3400:443"
    depends_on:
      - ldap
      - mysql
      - mongo
    networks:
      flipside:
        ipv4_address: 172.25.0.107

  swagger:
    container_name: swagger.burningflipside.local
    image: swaggerapi/swagger-editor
    volumes:
      - /BURNINGFLIPSIDE/dockerfiles/swagger/data/config:/editor/config
      - /BURNINGFLIPSIDE/dockerfiles/swagger/data/docs:/editor/spec-files
    ports:
      - "3500:8080"
    restart: always
    networks:
      flipside:
        ipv4_address: 172.25.0.108

networks:
  flipside:
    driver: bridge
    ipam:
      config:
      - subnet: 172.25.0.0/24
