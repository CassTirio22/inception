UPDATE mysql.user SET Password = PASSWORD('$MARIADB_PSW') WHERE User = 'root';

CREATE DATABASE $MARIADB_DATABASE;
CREATE USER '$MARIADB_USER_NAME'@'%' IDENTIFIED BY '$MARIADB_USER_PSW';
GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO $MARIADB_USER_NAME@'%';

FLUSH PRIVILEGES;
