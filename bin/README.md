# Burning Flipside Developer cli scripts

### bin/apache-studio

launches Apache Directory Studio: The Eclipse-based LDAP browser and directory client http://directory.apache.org/studio/

### bin/console

connect a console session to a running container 

### bin/images

pull or prune docker images used in this project

### bin/repos

checkout or update main project git repos

### bin/reset

remove data volumes and prune docker images

### bin/robomongo

launches robomongo: Native and cross-platform MongoDB manager

### bin/seed

populate databases and browsercap cache with initial values

### bin/sync

iterate over all repos in .gitmanifest
checkout master and develo branches and pull latest code from production repos
if using private forks push changes to development repos

### bin/valentina-studio

launches Valentina Studio: your universal database management tool for working with MySQL, MariaDB, SQL Server, PostgreSQL, SQLite and Valentina DB databases http://valentina-db.com
