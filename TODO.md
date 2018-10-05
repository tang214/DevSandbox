# TODO

## future

* all images should inherit from same base image
  * debian:stretch-slim
  * needs work
    * ldap

* switch to openldap docker image which is based on a debian:stretch-slim
    `https://github.com/rroemhild/docker-test-openldap/`

* all images should include tests to verify configuration
    consder using goss: `https://github.com/aelsabbahy/goss`

* refactor mongo container to require authetication

* implement secure service password storage
