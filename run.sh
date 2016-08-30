#!/bin/bash

service mysql start

#Read SQL files 
for SQLFILE in `find /backup -name \*.sql`
do
	echo "=> File ${SQLFILE}"
	arSQLFILE=(${SQLFILE//.sql/ })
	arDUMP=(${arSQLFILE[0]//dump_/ })
	DBNAME=${arDUMP[1]}

	echo "=> Check database ${DBNAME}"
	DB_EXIST=false
	mysqlshow ${DBNAME} > /dev/null 2>&1 && DB_EXIST=true
	echo ${DB_EXIST}

	if [ ${DB_EXIST} = false ]; then
		echo "=> Creating database & user"
		mysql -e "CREATE DATABASE ${DBNAME} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
		mysql -e "CREATE USER ${DBNAME}@'%' IDENTIFIED BY '';"
    		mysql -e "GRANT ALL PRIVILEGES ON ${DBNAME}.* TO '${DBNAME}'@'%';"
    		mysql -e "FLUSH PRIVILEGES;"

		echo "=> Import dump file"
		mysql -uroot ${DBNAME} < ${SQLFILE}
	fi	
done

tail -f /var/log/mariadb.log
