#!/bin/bash

# nuke project directory

rm -rf /var/www/html

# install New Relic PHP Agent

wget -O - https://download.newrelic.com/548C16BF.gpg | apt-key add -
sh -c 'echo "deb http://apt.newrelic.com/debian/ newrelic non-free" > /etc/apt/sources.list.d/newrelic.list'

apt-get update

export DEBIAN_FRONTEND=noninteractive

echo newrelic-php5 newrelic-php5/application-name string "PSFBlinkyDev" | debconf-set-selections
echo newrelic-php5 newrelic-php5/license-key string "c95a78f30e72e6aff47919b6a2f9b440f1c3ead1" | debconf-set-selections

rm /etc/php/7.0/cli/conf.d/20-newrelic.ini

apt-get -y --reinstall install newrelic-php5

sed -i -e 's/^newrelic.appname.*/newrelic.appname = \"PSFCoreDev\"/g' /etc/php/7.0/cli/conf.d/20-newrelic.ini

/etc/init.d/newrelic-daemon restart

# restart PHP-FPM and Apache

service php7.0-fpm restart
service apache2 restart

#DEBIAN_FRONTEND=noninteractive
#NR_INSTALL_SILENT=1
#NR_INSTALL_KEY=c95a78f30e72e6aff47919b6a2f9b440f1c3ead1
#NR_INSTALL_SHELL=/bin/bash NR_INSTALL_USE_CP_NOT_LN=1
#newrelic-install install
#sed -i -e 's/newrelic.appname = \"PHP Application\"/newrelic.appname = \"PSFBlinkyDev\"/g' /etc/php/7.0/cli/conf.d/newrelic.ini

# install New Relic plugins (still need to figure out how to automate)

#LICENSE_KEY=c95a78f30e72e6aff47919b6a2f9b440f1c3ead1 bash -c "$(curl -sSL https://download.newrelic.com/npi/release/install-npi-linux-debian-x64.sh)"
#npi install com.bluemedora.mysql

# set PHP date.timezone

sed -i -e 's/;date\.timezone =/date\.timezone = \"America\/New_York\"/g' /etc/php/7.0/apache2/php.ini
sed -i -e 's/;date\.timezone =/date\.timezone = \"America\/New_York\"/g' /etc/php/7.0/fpm/php.ini

# remove conf file(s) AWS CodeDeploy doesn't want to overwrite

rm -f /etc/apache2/sites-available/000-default.conf
rm -f /etc/php/7.0/fpm/pool.d/www.conf

# install Apache 2.4 virtual host conf file

cat > /etc/apache2/sites-available/000-default.conf <<EOL
<VirtualHost *:80>

        ServerName blinky.dev.frinkiac.io
        ServerAdmin numberone@wbdcorp.com
        DocumentRoot /var/www/html/web/

        <Directory /var/www/html/web>
                AllowOverride All
                Require all granted
        </Directory>

        ErrorLog /var/log/apache2/blinky_error.log
        CustomLog /var/log/apache2/blinky_access.log combined

        ProxyPassMatch ^/(.*\.php(/.*)?)$ fcgi://127.0.0.1:9000/var/www/html/web/\$1

</VirtualHost>
EOL

# install PHP-FPM default pool conf file

cat > /etc/php/7.0/fpm/pool.d/www.conf <<EOL
[www]

user = www-data
group = www-data

listen = 127.0.0.1:9000

listen.owner = www-data
listen.group = www-data

pm = dynamic
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3

security.limit_extensions = .php .php3 .php4 .php5 .php7
EOL

# restart PHP-FPM and Apache

service php7.0-fpm restart
