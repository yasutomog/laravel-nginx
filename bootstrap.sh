#!/usr/bin/env bash

#yum -y update

rpm -ivh https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
sed -i -e "s/enabled *= *1/enabled=0/g" /etc/yum.repos.d/epel.repo
rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
sed -i -e "s/enabled *= *1/enabled=0/g" /etc/yum.repos.d/remi.repo

yum -y install php --enablerepo=epel --enablerepo=remi --enablerepo=remi-php55

cp /vagrant/setup/php.ini /etc/php.ini

yum -y install php-mcrypt --enablerepo=epel --enablerepo=remi --enablerepo=remi-php55

yum -y install php-mysql --enablerepo=epel --enablerepo=remi --enablerepo=remi-php55

yum -y install php-opcache --enablerepo=epel --enablerepo=remi --enablerepo=remi-php55

cp /vagrant/setup/opcache.ini /etc/php.d/opcache.ini

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

yum -y install php-fpm --enablerepo=epel --enablerepo=remi --enablerepo=remi-php55

cp /vagrant/setup/php-fpm.conf /etc/php-fpm.conf
cp /vagrant/setup/www.conf /etc/php-fpm.d/www.conf



/usr/local/bin/composer create-project laravel/laravel laravel-prj --prefer-dist

cd laravel-prj

cp /vagrant/setup/app.php app/config/app.php

rpm -ivh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
yum install -y nginx

chown -R nginx app/storage

cp /vagrant/setup/nginx.conf /etc/nginx/nginx.conf
cp /vagrant/setup/laravel.conf /etc/nginx/conf.d/laravel.conf


service nginx start
chkconfig nginx on

/etc/init.d/php-fpm start
chkconfig php-fpm on

service iptables stop

