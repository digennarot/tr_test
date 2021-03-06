#!/usr/bin/env bash

#misc
yum -y install wget sudo epel-release

#disable selinux
sed -i.bak  s/SELINUX=enforcing/SELINUX=disabled/ /etc/selinux/config
setenforce 0

#install PHP 7.1
cd cd ~
wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
rpm -Uvh remi-release-7.rpm
yum-config-manager --enable remi                
yum-config-manager --enable remi-php71

#app dependencies
yum -y install httpd mod_ssl php php-fpm php-opcache php-common php-cli php-bcmath php-mbstring php-pdo php-process php-xml php-soap php-redis

#create TR user
adduser tr

mkdir -p /etc/php_extra
#download new browscap
wget http://browscap.org/stream?q=PHP_BrowsCapINI -O /etc/php_extra/browscap.ini

#fpm config
TRFPMFILE=/etc/php-fpm.d/fpm-tr.conf
echo '[tr]' > $TRFPMFILE
echo 'user = tr' >> $TRFPMFILE
echo 'group = tr' >> $TRFPMFILE
echo 'listen = 0.0.0.0:9001' >> $TRFPMFILE
echo ';because of memory leak' >> $TRFPMFILE
echo 'pm.max_requests = 100' >> $TRFPMFILE
echo 'pm = dynamic' >> $TRFPMFILE
echo 'pm.max_children = 50' >> $TRFPMFILE
echo 'pm.start_servers = 5' >> $TRFPMFILE
echo 'pm.min_spare_servers = 5' >> $TRFPMFILE
echo 'pm.max_spare_servers = 35' >> $TRFPMFILE
echo 'php_admin_value[error_log] = /var/log/php-fpm/tr-error.log' >> $TRFPMFILE

#PHPINI
TRPHPINIDILE=/etc/php.d/php-tr.ini
echo '[PHP]' > $TRPHPINIDILE
echo 'realpath_cache_size=4096K' >> $TRPHPINIDILE
echo 'realpath_cache_ttl=600' >> $TRPHPINIDILE
echo 'upload_max_filesize = 20M' >> $TRPHPINIDILE
echo 'post_max_size = 20M' >> $TRPHPINIDILE
echo 'max_file_uploads = 50' >> $TRPHPINIDILE
echo 'session.save_handler = redis' >> $TRPHPINIDILE
echo 'session.save_path = "tcp://redis:6379"' >> $TRPHPINIDILE
echo 'error_reporting = E_ALL & ~E_NOTICE' >> $TRPHPINIDILE
echo 'display_errors = Off' >> $TRPHPINIDILE
echo '' >> $TRPHPINIDILE
echo '[Date]' >> $TRPHPINIDILE
echo 'date.timezone = "Europe/Prague"' >> $TRPHPINIDILE
echo '' >> $TRPHPINIDILE
echo '[opcache]' >> $TRPHPINIDILE
echo 'opcache.max_accelerated_files = 20000' >> $TRPHPINIDILE
echo '[browscap]' >> $TRPHPINIDILE
echo 'browscap = /etc/php_extra/browscap.ini' >> $TRPHPINIDILE

 

