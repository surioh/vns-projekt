#!/bin/bash
mariadb -D dbdemo -e 'drop table if exists products;'

mariadb -D dbdemo -e 'create table products (id INT primary key, product_name VARCHAR(255), product_origin VARCHAR(255), price_per_kilo DECIMAL(10,2));'

mariadb -D dbdemo -e 'set global local_infile=1;'

mariadb -D dbdemo -e "load data local infile '/startup/products.csv' into table products fields terminated by ',' enclosed by '\"' lines terminated by '\n' ignore 1 rows (id, product_name, product_origin, @price) set price_per_kilo = replace(@price, '\$', ''); "

mariadb -D dbdemo -e 'set global local_infile=0;'

mariadb -D dbdemo -e 'select * from products limit 5;'

#mariadb -D dbdemo -e 'drop table if exists products;'
