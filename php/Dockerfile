FROM phpearth/php:${phpver:-7.4}-apache

RUN apk add --no-cache php${phpver:-7.4}-swoole php${phpver:-7.4}-mongodb php${phpver:-7.4}-fpm php${phpver:-7.4}-intl php${phpver:-7.4}-opcache php${phpver:-7.4}-sodium

RUN apk add --no-cache php${phpver:-7.4}-pdo php${phpver:-7.4}-pgsql php${phpver:-7.4}-pdo_pgsql php${phpver:-7.4}-mysqlnd php${phpver:-7.4}-pdo_mysql composer

RUN sed -i 's/memory_limit = .*/memory_limit = 512M/' "/etc/php/${phpver:-7.4}/php.ini"
RUN sed -i 's/listen = .*/listen = 9000/' "/etc/php/${phpver:-7.4}/php-fpm.d/www.conf"
RUN sed -i 's/user = www-data/user = 33/' "/etc/php/${phpver:-7.4}/php-fpm.d/www.conf"
RUN sed -i 's/group = www-data/group = 33/' "/etc/php/${phpver:-7.4}/php-fpm.d/www.conf"
RUN sed -i 's/;daemonize = yes/daemonize = no/' "/etc/php/${phpver:-7.4}/php-fpm.conf"
