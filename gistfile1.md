#Introduction
If you're a php developer on ubuntu, there comes the time where you have to install/reinstall your system.
I did it already a few times and i decided to write down the steps for a typical web developer stack with php.

I hope it's a help also for you!

#Installation stack
* [PHP Storm](#phpstorm)
* [Git / Github](#git)

#Installation General Environment
<a name="phpstorm"></a>
##PHP Storm
* Download and install PHP Storm - http://www.jetbrains.com/phpstorm/
* Install Sun JDK - http://www.webupd8.org/2012/01/install-oracle-java-jdk-7-in-ubuntu-via.html
* increase file watching limit (http://confluence.jetbrains.net/display/IDEADEV/Inotify+Watches+Limit)
    * add `fs.inotify.max_user_watches = 524288` to `/etc/sysctl.conf`
    * apply change `sudo sysctl -p`

<a name="git"></a>
##git
* `sudo apt-get install git`
* `git config --global color.branch auto`
* `git config --global color.diff auto`
* `git config --global color.status auto`
* Manual on how to install ssh keys on github http://help.github.com/linux-set-up-git/

##memcache
* `sudo apt-get install memcached`
* `sudo apt-get install php5-memcache`

###apache2
* `sudo apt-get install apache2`
* `sudo a2enmod rewrite`
* `sudo apt-get install libapache2-mod-php5`

###mysql
* `sudo apt-get install mysql-server`
* `sudo apt-get install php5-mysql`


##Installation PHP Environment
###PHP
sudo apt-get install php5-cli php5-common php-apc php-pear php5-xdebug php5-curl php5

###PHP XSL
sudo apt-get install php5-xsl

###PHP SQLite (to profile backend app)
sudo apt-get install php5-sqlite
comment out extension=sqlite.so in /etc/php5/conf.d/sqlite.ini

###PHP Internationalisierung
sudo apt-get install php5-intl

###Update PEAR
sudo pear channel-update PEAR
sudo pear upgrade PEAR

##Installation of QA Environment
###CodeSniffer
sudo pear install PHP_CodeSniffer

###Coding Standards Symfony
Follow this README - https://github.com/nzzdev/Symfony2-coding-standard/blob/master/README.md

###PHPUnit
sudo pear channel-discover pear.phpunit.de
sudo pear channel-discover components.ez.no
sudo pear channel-discover pear.symfony-project.com
sudo apt-get install phpunit
sudo pear install phpunit/PHPUnit

# PHING
sudo pear channel-discover pear.phing.info
sudo pear install phing/phing

# gmagick
sudo apt-get install graphicsmagick libgraphicsmagick1-dev
sudo pecl install gmagick-beta
Create file /etc/php5/conf.d/gmagick.ini and add a line "extension=gmagick.so"
 

#Configuration

##Apache2
Assume you want to have your projects in /home/username/eos

###Change user/group of Apache2
edit /etc/apache2/apache2.conf
User username
Group usergroup

##PHP
Edit /etc/php5/cli/php.ini and /etc/php5/apache2/php.ini
memory_limit = 512m
display_errors = On
html_errors = On
post_max_size = 32m
upload_max_filesize = 32m
default_charset = utf8
allow_url_fopen = On
date.timezone = “Europe/Zurich”
intl.default_locale = de_CH

Edit /etc/php5/cli/conf.d/xdebug.ini
xdebug.max_nesting_level = 1000

##Debugging with Browser and Command line
Edit /etc/php5/cli/conf.d/xdebug.ini
xdebug.remote_enable=On
xdebug.remote_host=localhost
xdebug.remote_port=9002
xdebug.remote_handler=dbgp

Restart Apache2
sudo service apache2 restart

Add to /home/<usernmae>/.bashrc
export XDEBUG_CONFIG="PHPSTORM";

execute on console (to reload bash settings)
source ~/.bashrc


Edit Settings in PHPStorm
Go to File->Settings->PHP->Debug
Change XDebug Debug Port to 9002

Install Easy XDebug Plugin for Firefox
https://addons.mozilla.org/de/firefox/addon/easy-xdebug/

###Debugging via Firefox
Firefox: Click on ‘StartXDebug Session’ Symbol on bottom right
PHPStorm: Click on Run->Start Listen PHP Debug Connections
Set a breakpoint and do call via firefox browser

###Debugging via Console
PHPStorm: Click on Run->Start Listen PHP Debug Connections
Set a breakpoint and run a console command

##PHPStorm Config
for PHPUnit Code Completion add PHPUnit path under file->settings-directories
Usually it’s stored in /usr/share/php/PHPUnit








#Install www project

Assume you want to have your project in /home/username/eos/www

cd /home/<username>/eos
git clone git@github.com:nzzdev/www
cd www
bin/install.sh --env=dev from the project root directory
#Config www project with Apache2

Edit /etc/hosts
Add 127.0.0.1 www.sql.nzz.lo

Create file /etc/apache2/sites-available/nzz.lo
and add config

<VirtualHost *:80>
    ServerName  www.sql.nzz.lo
    DocumentRoot /home/username/eos/www-sql/web
    ErrorLog ${APACHE_LOG_DIR}/www.sql.error.log
    CustomLog ${APACHE_LOG_DIR}/www.sql.access.log common
</VirtualHost>

create symbolic link to enable a site:
sudo ln -s /etc/apache2/sites-available/nzz.lo /etc/apache2/sites-enabled/nzz.lo
restart apache2:
sudo /etc/init.d/apache2 restart






Install Backend


sudo apt-get install rabbitmq-server