sudo yum install -y update
sudo yum install -y upgrade
sudo yum install -y git
sudo yum install -y apache2

# Enable Apache Mods
a2enmod rewrite

#Add Onrej PPA Repo
sudo yum-add-repository ppa:ondrej/php
sudo yum install -y update
sudo yum install -y php7.2
sudo yum install -y libapache2-mod-php7.2

sudo service apache2 restart

# PHP Mods
sudo yum install -y php7.2-common
sudo yum install -y php7.2-mcrypt
sudo yum install -y php7.2-zip

# Set MySQL Pass
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo yum install -y mysql-server
sudo yum install -y php7.2-mysql
sudo service apache2 restart
