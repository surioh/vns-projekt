#!/bin/bash
source local/config.txt || exit 1
container=$1
echo "Container: $container"
echo "Database: $dbname"
echo "DB User: $dbuser"
echo "DB Pass: $dbpassword"

docker exec -ti "$container" mariadb -D "$dbname" -u "$dbuser" -p"$dbpassword" \
				-e 'SELECT * FROM demo ORDER BY id DESC LIMIT 1;'
