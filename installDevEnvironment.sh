#!/bin/bash

# params: question, function to execute
install_question(){
    read -p `echo "$1"` yn
    case $yn in
        [Yy]* ) eval "$2";
    esac
}

install_nginx(){
    # Nginx and related
    sudo apt-get install nginx php5-fpm
}

install_apache(){
    # Apache and related
    sudo apt-get install apache2
    sudo a2enmod rewrite
    sudo apt-get install libapache2-mod-php5
}

install_iconizr(){
    basedir=`pwd`
    # PNG Tools for Iconizr
    sudo apt-get install pngcrush pngquant optipng
    sudo apt-get install checkinstall
    cd /tmp
    wget http://downloads.sourceforge.net/project/optipng/OptiPNG/optipng-0.7.4/optipng-0.7.4.tar.gz
    tar xvf optipng-0.7.4.tar.gz
    cd optipng-0.7.4
    ./configure
    make
    sudo checkinstall
    cd $basedir
}

install_frontend_tools(){
    # Frontend tools
    # nodejs
    sudo apt-get install python-software-properties
    sudo apt-add-repository ppa:chris-lea/node.js
    sudo apt-get update
    sudo apt-get install nodejs
    #grunt
    sudo npm install -g grunt-cli
    #bower
    sudo npm install -g bower
    #iconizr
    install_iconizr
}

install_java8(){
    #java8 for phpstorm
    sudo add-apt-repository ppa:webupd8team/java
    sudo apt-get update
    sudo apt-get install oracle-java8-installer
}

install_git(){
    # git + related
    sudo apt-get install git
    git config --global color.branch auto
    git config --global color.diff auto
    git config --global color.status auto
    sudo apt-get install gitg
}

install_database(){
    # Database (mysql|mysql-workbench|redis|sqlite3)
    sudo apt-get install mysql-server
    sudo apt-get install php5-mysql
    sudo apt-get install sqlite3 php5-sqlite
    sudo apt-get install redis-server
    if [[ -z `which mysql-workbench` ]]; then
        sudo apt-get install mysql-workbench
    fi
}

install_php(){
    # php
    sudo apt-get install php5-cli php5-common php-apc php-pear php5-xdebug php5-curl php5 php5-dev
    sudo apt-get install memcached
    sudo apt-get install php5-memcache
    sudo apt-get install graphicsmagick libgraphicsmagick1-dev
    sudo pecl install gmagick-beta
    sudo apt-get install php5-xsl
    sudo apt-get install php5-intl php5-mcrypt
}

install_phpunit(){
    #install newest version of phpunit
    sudo apt-get remove phpunit
    sudo pear channel-discover pear.phpunit.de
    sudo pear channel-discover pear.symfony-project.com
    sudo pear channel-discover components.ez.no
    sudo pear update-channels
    sudo pear upgrade-all
    sudo pear install --alldeps phpunit/PHPUnit
    sudo pear install --force --alldeps phpunit/PHPUnit
}

install_php_qa_tools(){
    #php-cs-fixer
    sudo wget http://cs.sensiolabs.org/get/php-cs-fixer.phar -O /usr/local/bin/php-cs-fixer
    sudo chmod a+x /usr/local/bin/php-cs-fixer

    #PHP Code Sniffer
    sudo pear channel-update PEAR
    sudo pear upgrade PEAR
    sudo pear channel-discover pear.phing.info
    sudo pear install phing/phing
    sudo pear install PHP_CodeSniffer

    #phpunit Skeleton Generator
    sudo pear config-set auto_discover 1
    sudo pear install pear.phpunit.de/PHPUnit_SkeletonGenerator
}

install_tools(){
    sudo apt-get install vim
    sudo apt-get install mc
    sudo apt-get install g++
    sudo apt-get install filezilla
    sudo apt-get install curl
}


install_question "Install-frontend-tools->(y|n)" "install_frontend_tools"
install_question "Install-php->(y|n)" "install_php"
install_question "Install-phpunit->(y|n)" "install_phpunit"
install_question "Install-php-qa-tools->(y|n)" "install_php_qa_tools"
install_question "Install-java8-for-PHPStorm->(y|n)" "install_java8"
install_question "Install-tools-like-vim-curl-and-so-on>(y|n)" "install_tools"
install_question "Install-git->(y|n)" "install_git"
install_question "Install-apache->(y|n)" "install_apache"
install_question "Install-nginx->(y|n)" "install_nginx"
install_question "Install-mysql-sqlite-redis->(y|n)" "install_database"
