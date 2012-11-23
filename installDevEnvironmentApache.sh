# Script tried on Ubuntu 12.10, should also work in 12.04

sudo apt-get install git
git config --global color.branch auto
git config --global color.diff auto
git config --global color.status auto
sudo apt-get install memcached
sudo apt-get install php5-memcache
sudo apt-get install apache2
sudo a2enmod rewrite
sudo apt-get install libapache2-mod-php5
sudo apt-get install mysql-server
sudo apt-get install php5-mysql
sudo apt-get install sqlite3 php5-sqlite
sudo apt-get install graphicsmagick libgraphicsmagick1-dev
sudo pecl install gmagick-beta
sudo apt-get install curl
sudo apt-get install php5-cli php5-common php-apc php-pear php5-xdebug php5-curl php5
sudo apt-get install php5-xsl
sudo apt-get install php5-intl
sudo pear channel-update PEAR
sudo pear upgrade PEAR
sudo pear channel-discover pear.phing.info
sudo pear install phing/phing
sudo pear install PHP_CodeSniffer
sudo apt-get remove phpunit
#install newest version of phpunit
sudo pear channel-discover pear.phpunit.de
sudo pear channel-discover pear.symfony-project.com
sudo pear channel-discover components.ez.no
sudo pear update-channels
sudo pear upgrade-all
sudo pear install --alldeps phpunit/PHPUnit
sudo pear install --force --alldeps phpunit/PHPUnit
#phpunit Skeleton Generator
sudo pear config-set auto_discover 1
sudo pear install pear.phpunit.de/PHPUnit_SkeletonGenerator
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java7-installer
sudo apt-get install vim
sudo apt-get install mc
sudo apt-get install gitg
sudo apt-get install g++
