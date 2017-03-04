#
# TODO
#


## base and size improvements

some of the images are based on alpine linux.

more of these images are based on debian jessie.

this results in images that possibly larger than they need to be.

REPOSITORY            TAG                 IMAGE ID            SIZE
----------------------------------------------------------------------
burnerdev/openldap    1.1.8               246ea04eea73        223 MB
burnerdev/wordpress   4.7.2               c0ed36b39f07        694 MB
burnerdev/php         7.1-apache          833f7b8228f7        669 MB
burnerdev/mysql       5.7                 02d4e8184d69        400 MB
burnerdev/mongo       3.4                 bbfd4c8c8409        402 MB
php                   7.1-apache          399dbfe34f35        386 MB
debian                jessie              e5599115b6a6        123 MB
osixia/openldap       1.1.8               03a4eced0fc7        223 MB

I'd like to see all these images based on alpine to make them as small as possible.


## make production ready versions

eventually this approach to deployment will make it to production.

this will require implementing a good approach for secrets management and PKI infrastructure.
