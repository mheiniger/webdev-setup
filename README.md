webdev-setup
============

A simple script to setup ubuntu for php-web-development.

Its no magic, it just uses all install commands from DaRaffs gist: https://gist.github.com/3995789

This setup includes:
* git and gitg
* memcached
* apache2 OR nginx
* mysql and sqlite3
* graphicsmagick with gmagick for php
* curl
* php5 with pear, xdebug, phing, codesniffer, phpunit, phpunit-skeletonGenerator
* java7 (for major IDE's for PHP like PHPStorm or Netbeans)
* vim
* mc

During the script it will stop from time to time to ask you for settings.
After running the script, look at the gist and configure the services you just installed.

There are two flavours of the script:
* installDevEnvironmentApache.sh does the setup with Apache
* installDevEnvironmentNginx.sh does the setup with Nginx

## Things you have to do configure manually (look in gist for more detailed description):

```
git config --global user.email "name@email.tld"
git config --global user.name "full name"

#edit listen port in /etc/php5/fpm/pool.d/www.conf
listen = 127.0.0.1:9009
#comment in /etc/php5/conf.d/sqlite.ini
extension=sqlite.so

#add line to /etc/sysctl.conf
fs.inotify.max_user_watches = 524288

#apply changes
sudo sysctl -p


#restart services:
# for nginx:
sudo service php5-fpm restart
sudo service nginx restart
# for apache
sudo service apache2 restart
```

##PHP Settings
* Change this settings in /etc/php5/cli/php.ini for for *all webservers*
* Change this settings in /etc/php5/apache2/php.ini if you have installed *apache2*
* Change this settings in /etc/php5/fpm/php.ini if you have installed *nginx and fpm*

```shell
memory_limit = 512m
display_errors = On
html_errors = On
post_max_size = 32m
upload_max_filesize = 32m
default_charset = utf8
date.timezone = "Europe/Zurich" # (or whatever it is in your country)
```

```
#Create file /etc/php5/conf.d/gmagick.ini and add a line
extension=gmagick.so
```

* Edit /etc/php5/cli/conf.d/xdebug.ini

```shell
xdebug.max_nesting_level = 1000
xdebug.remote_enable=On
xdebug.remote_host=localhost
xdebug.remote_port=9002
xdebug.remote_handler=dbgp
```

```
#Add to ~/.bashrc
export XDEBUG_CONFIG="PHPSTORM";

#reload bash settings
source ~/.bashrc
```