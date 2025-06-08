#!/bin/bash
lines_ignored=$1
limit=$2
mariadb -D dbdemo -e 'drop table if exists products;'

mariadb -D dbdemo -e 'create table products (id INT primary key, product_name VARCHAR(255), product_origin VARCHAR(255), price_per_kilo DECIMAL(10,2));'

mariadb -D dbdemo -e 'set global local_infile=1;'

shard_csv="/startup/shard_$(hostname).csv"
tail -n +$((lines_ignored + 1)) /startup/products.csv | head -n $limit > "$shard_csv"

mariadb -D dbdemo -e "load data local infile '$shard_csv' into table products fields terminated by ',' enclosed by '\"' lines terminated by '\n' ignore 0 rows (id, product_name, product_origin, @price) set price_per_kilo = replace(@price, '\$', ''); "

mariadb -D dbdemo -e 'set global local_infile=0;'

mariadb -D dbdemo -e 'select * from products limit 5;'

