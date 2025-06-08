#!/bin/bash
pw=$(grep "^dbpassword=" /startup/config.txt | cut -d'=' -f2)
sudo -u mysql mariadb -e "drop database if exists dbdemo;
drop user if exists dbuser@'localhost';
drop user if exists dbuser@'%';
create database dbdemo;
create user dbuser@'%' identified by '$pw';
grant all privileges on dbdemo.* TO dbuser@'%';
flush privileges;"

#mariadb -e 'create database dbdemo'
#mariadb -e 'create user dbuser'
#mariadb -e "grant all privileges on *.* to dbuser@'%' identified by '$pw'"
#mariadb -e 'flush privileges'
mariadb -D dbdemo -e 'create table demo (id integer auto_increment primary key, name text)'
mariadb -D dbdemo -e 'insert into demo (id, name) values (1,"Aldi")'
