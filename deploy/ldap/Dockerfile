# Use osixia/light-baseimage
# sources: https://github.com/osixia/docker-light-baseimage
FROM osixia/openldap:1.1.7

COPY bootstrap /container/service/slapd/assets/config/bootstrap
COPY certs /container/service/slapd/assets/certs
COPY environment /container/environment/01-custom
