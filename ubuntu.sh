#!/bin/bash
#Author:show
#自动搭建php开发环境shell

apt-get install build-essential
apt-get install libpcre3 libpcre3-dev zlib1g-dev
#安装mysql
echo '===========安装mysql========'
apt-get install mysql-server mysql-client
echo '===========安装nginx========'
#配置nginx
function nginx()
{
	#下载nginx
	wget http://nginx.org/download/nginx-1.10.3.tar.gz
	tar zxvf nginx-1.10.3.tar.gz
	mv nginx-1.10.3 nginx
	cd nginx
	./configure --prefix=/usr --sbin-path=/usr/sbin \
	--conf-path=/webwww/nginx/nginx.conf --pid-path=/webwww/run/nginx.pid --lock-path=/webwww/lock/nginx.lock \
	--error-log-path=/webwww/log/nginx/main_error.log  \
	--http-client-body-temp-path=/webwww/tmp/nginx/client_body/ --http-proxy-temp-path=/webwww/tmp/nginx/proxy/ --http-fastcgi-temp-path=/webwww/tmp/nginx/fcgi/ \
	--with-http_stub_status_module
	make
	make install
	cd ../
}
nginx;
#ls
#自动下载配置文件并替换
echo '==========安装php7========='
#libiconv等包最好自行编译安装
#http://www.gnu.org/software/libiconv/ https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz
#libevent
#http://libevent.org/ https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz
#http://www.gnu.org/software/libtool/
function php7()
{
	wget http://cn2.php.net/distributions/php-7.1.1.tar.bz2
	#tar jxvf php-7.1.1.tar.bz2
	mv php-7.1.1 php7
	cd php7
	#配置php
	#  ac_default_prefix=/usr/local --prefix=/webwww/php/local 放php的路径
	#--with-mysql=mysqlnd 一般要干掉的了
	./configure --prefix=/usr/local --with-config-file-path=/webwww/php --with-config-file-scan-dir=/webwww/php \
	--sysconfdir=/webwww/php --enable-fpm \
	--with-fpm-user=www-data --with-fpm-group=www-data \
	--enable-mbstring --enable-sockets --enable-pcntl --with-curl \
	--enable-pdo --enable-mysqlnd --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd \
	--enable-sysvshm --enable-shmop  \
	--with-jpeg-dir=/usr --with-freetype-dir=/usr --with-png-dir=/usr --with-zlib-dir=/usr --with-iconv=/usr/local/lib \
	--with-gd --with-openssl --enable-opcache=no --enable-zip --enable-bcmath --enable-ftp
	make
	make install
	#从指定服务器下载指定php配置文件
}
#要兼容旧程序的办法
#https://git.php.net/repository/pecl/database/mysql.git
php7;

#todo 增加版本的切换




