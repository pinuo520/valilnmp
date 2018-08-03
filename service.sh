#!/usr/bin/env bash
#lnmp启动和结束

case $1 in
    all)
        echo "运行所有服务"
        systemctl nginx restart
        systemctl mysql restart
        systemctl php-fpm restart
    ;;
    php)
        php_version="726"
        pkill php-fpm
        if [[ $2 ]];
            php_version=$2;
        then
            echo $1;
        fi
        #/bin/
        #pear
        #peardev
        #pecl
        #phar -> phar.phar*
        #phar.phar
        #php
        #php-cgi
        #php-config
        #phpdbg
        #phpize
        #
        #/sbin/
        #php-fpm

        php_bin=("pear" "peardev" "pecl" "pha" "phar.phpar" "php" "php-cgi" "php-config" "phpdbg" "phpize");
        php_sbin=("php-fpm");

        #软链或者copy的方式
        for data_file in ${php_bin[@]};
        do
            #echo "$data_file";
        rm -rf "/usr/bin/$data_file";
            #rm -rf "/usr/bin/$data_file";
            ln -s "/webwww/php/$php_version/bin/$data_file" "/usr/bin/$data_file";
        done

        for data_file in ${php_sbin[@]};
        do
            echo "$data_file";
            rm -rf "/usr/sbin/$data_file";
            #rm -rf "/usr/sbin/$data_file";
            ln -s "/webwww/php/$php_version/sbin/$data_file" "/usr/sbin/$data_file";
        done

        echo "切换版本成功";
    ;;
    lsync)
        echo "启动lsync服务";
        lsync_conf=/etc/lsyncd.conf
        /usr/local/bin/lsyncd $lsync_conf
    ;;
    rsync)
        echo "rsync服务启动";
        service rsyncd restart
    ;;
    zagent)
        echo "zabbix-agent启动";
        systemctl restart zabbix-agent
    ;;
    zserver)
        echo "zabbix-server启动";
        systemctl restart zabbix-server
    ;;
    *)
        echo "没有指示";
    ;;
esac
