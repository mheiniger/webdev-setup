#Introduction
If you're a php developer on ubuntu, there comes the time where you have to install/reinstall your system.
I did it already a few times and i decided to write down the steps for a typical web developer stack with php.
This is for a developer machine and not for live environment!

I hope it's a help also for you!

#Installation stack
* General Environment
    * [git / github](#git)
    * [memcache](#memcache)
    * [apache2](#apache2)
    * [nginx](#nginx)
    * [mysql](#mysql)
    * [sqlite](#sqlite)
    * [gmagick](#gmagick)
    * [curl](#curl)
* PHP Environment
    * [PHP5](#php)
    * [PEAR](#pear)
    * [Phing](#phing)
* PHP QA Environment
    * [PHP Codesniffer](#php-codesniffer)
    * [PHPUnit](#phpunit)
    * [PHPStorm IDE](#phpstorm)
* Other
    * [php.ini settings](#php-ini)
    * [How to debug with XDebug and PHPStorm on Firefox and command line](#debugging-with-phpstorm)
    * [Apache2 config example](#apache2-config-example)

#Install General Environment
<a name="git"></a>
##git
```shell
sudo apt-get install git
git config --global color.branch auto
git config --global color.diff auto
git config --global color.status auto

#Manual on how to install ssh keys on github http://help.github.com/linux-set-up-git/
```
<a name="memcache"></a>
##memcache
```shell
sudo apt-get install memcached
sudo apt-get install php5-memcache
```

<a name="apache2"></a>
##apache2
```shell
sudo apt-get install apache2
sudo a2enmod rewrite
sudo apt-get install libapache2-mod-php5
```

<a name="nginx"></a>
##nginx
```shell
sudo apt-get install nginx php5-fpm

#edit listen port in /etc/php5/fpm/pool.d/www.conf
listen = 127.0.0.1:9009

sudo /etc/init.d/php5-fpm restart
sudo service nginx restart
```

<a name="mysql"></a>
##mysql
```shell
sudo apt-get install mysql-server
sudo apt-get install php5-mysql
```

<a name="sqlite"></a>
##SQLite
```shell
sudo apt-get install sqlite3 php5-sqlite

#comment in /etc/php5/conf.d/sqlite.ini
extension=sqlite.so
```

<a name="gmagick"></a>
##gmagick
```shell
sudo apt-get install graphicsmagick libgraphicsmagick1-dev
sudo pecl install gmagick-beta

#Create file /etc/php5/conf.d/gmagick.ini and add a line 
extension=gmagick.so
```

<a name="curl"></a>
##curl
```shell
sudo apt-get install curl
```

#Installation PHP Environment
<a name="php"></a>
##PHP5
```shell
sudo apt-get install php5-cli php5-common php-apc php-pear php5-xdebug php5-curl php5
sudo apt-get install php5-xsl
sudo apt-get install php5-intl
```

<a name="pear"></a>
##PEAR
```shell
sudo pear channel-update PEAR
sudo pear upgrade PEAR
```

<a name="phing"></a>
##PHING
```shell
sudo pear channel-discover pear.phing.info
sudo pear install phing/phing
```

#Installation PHP QA Environment
<a name="php-codesniffer"></a>
##CodeSniffer
```shell
sudo pear install PHP_CodeSniffer
```

* README Symfony2 Coding Standard
    * [public](https://github.com/opensky/Symfony2-coding-standard)
    * [private](https://github.com/nzzdev/Symfony2-coding-standard/blob/master/README.md)

<a name="phpunit"></a>
##PHPUnit
```shell
#necessary if you already have installed phpunit via apt-get
sudo apt-get remove phpunit

#install newest version of phpunit
sudo pear channel-discover pear.phpunit.de
sudo pear channel-discover pear.symfony-project.com
sudo pear channel-discover components.ez.no
sudo pear update-channels
sudo pear upgrade-all
sudo pear install --alldeps phpunit/PHPUnit
sudo pear install --force --alldeps phpunit/PHPUnit
``` 

<a name="phpstorm"></a>
##PHP Storm IDE
* Download and install PHP Storm - http://www.jetbrains.com/phpstorm/
* Install Sun JDK - http://www.webupd8.org/2012/01/install-oracle-java-jdk-7-in-ubuntu-via.html
* increase file watching limit (http://confluence.jetbrains.net/display/IDEADEV/Inotify+Watches+Limit)

```shell
#add line to /etc/sysctl.conf
fs.inotify.max_user_watches = 524288

#apply changes
sudo sysctl -p
```

#Configuration

<a name="php-ini"></a>
##PHP
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
```

* Edit /etc/php5/cli/conf.d/xdebug.ini

```shell
xdebug.max_nesting_level = 1000
```

<a name="debugging-with-phpstorm"></a>
#Debugging with XDebug on Browser and Command line

The example is made for PHPStorm IDE with Apache2 webserver. But other IDE's or webservers should work in a similar way.
##Configuration
```shell
#Edit /etc/php5/cli/conf.d/xdebug.ini
xdebug.remote_enable=On
xdebug.remote_host=localhost
xdebug.remote_port=9002
xdebug.remote_handler=dbgp

sudo service apache2 restart

#Add to /home/<your_username>/.bashrc
export XDEBUG_CONFIG="PHPSTORM";

#reload bash settings
source ~/.bashrc
```
* Edit Settings in PHPStorm
    * Go to File->Settings->PHP->Debug
    * Change XDebug Debug Port to 9002
* Install Easy XDebug Plugin for Firefox
    * https://addons.mozilla.org/de/firefox/addon/easy-xdebug/

##Debugging via Firefox
* Firefox: Click on ‘StartXDebug Session’ Symbol on bottom right
* PHPStorm: Click on Run->Start Listen PHP Debug Connections
* PHPStorm: Set a breakpoint and do call via firefox browser

##Debugging via Console
* PHPStorm: Click on Run->Start Listen PHP Debug Connections
* Set a breakpoint and run a console command

##PHPStorm Config
* for PHPUnit Code Completion add PHPUnit path under file->settings-directories
* Usually it’s stored in `/usr/share/php/PHPUnit`






<a name="apache2-config-example"></a>
#Apache2 config example
Assume you want to have your project in `/home/username/my_webside`

```shell
# Change user/group of Apache2
# edit /etc/apache2/apache2.conf
User <username>
Group <usergroup>

#Add entry to /etc/hosts
127.0.0.1 www.my_webside.lo

#Create file 
/etc/apache2/sites-available/www.my_webside.lo

#edit file (with example config)
<VirtualHost *:80>
    ServerName  www.my_webside.lo
    DocumentRoot /home/username/my_webside/web
    ErrorLog ${APACHE_LOG_DIR}/www.my_webside.lo.error.log
    CustomLog ${APACHE_LOG_DIR}/www.my_webside.lo.access.log common
</VirtualHost>

#create symbolic link to enable a site
sudo ln -s /etc/apache2/sites-available/www.my_webside.lo /etc/apache2/sites-enabled/www.my_webside.lo

#restart apache
sudo /etc/init.d/apache2 restart
```