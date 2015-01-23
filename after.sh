#!/usr/bin/env bash

composer create-project laravel/laravel laravel-prj --prefer-dist

cd laravel-prj

cp /vagrant/setup/app.php app/config/app.php

sudo chown -R nginx app/storage


sudo service nginx start
sudo chkconfig nginx on

sudo /etc/init.d/php-fpm start
sudo chkconfig php-fpm on

sudo service iptables stop
