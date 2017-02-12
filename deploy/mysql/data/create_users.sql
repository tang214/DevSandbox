# ************************************************************
#
# Burning Flipside Technology Stack MySQL Users
#
# ************************************************************

CREATE USER 'registration'@'%' IDENTIFIED BY 'p@s5w0rd';
GRANT ALL PRIVILEGES ON registration.* TO 'registration'@'%';

CREATE USER 'tickets'@'%' IDENTIFIED BY 'p@s5w0rd';
GRANT ALL PRIVILEGES ON tickets.* TO 'tickets'@'%';

CREATE USER 'wordpress'@'%' IDENTIFIED BY 'p@s5w0rd';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%';

CREATE USER 'pyropedia'@'%' IDENTIFIED BY 'p@s5w0rd';
GRANT ALL PRIVILEGES ON pyropedia.* TO 'pyropedia'@'%';

FLUSH PRIVILEGES;
