# params 
# 1 : email for LetsEncrypt
# 2 : hostname use for base url


if [ -z "$1" ];then 
  echo "email for Letsencrypt TOS is missing"

  exit
fi

email=$1

if [ -z "$2" ];then 
  hostname=$(hostname)
else
  hostname=$2
fi


php_default_version=7.4

export DEBIAN_FRONTEND=noninteractive

apt update -y
apt dist-upgrade -y
apt install -y bash-completion curl nano

bash ../modules/module/wrappers/install

tb app sudo/install/base
tb app sudo/install/mariadb
tb app sudo/install/php 7.4
tb app sudo/install/php 8.1
tb app sudo/install/web --apache
tb app sudo/install/ssl $hostname --apache
tb app sudo/way/init apache $email $hostname $php_default_version
tb app sudo/install/files
service apache2 restart
service php7.4-fpm restart
service php8.1-fpm restart
service mariadb restart
tb app sudo/install/mail $hostname

echoc -y2 "# quit shell and comeback to enable tb completion"

echoc -y2 "# MARIADB"
echoc -y2 "# /root/.my.cnf"
cat /root/.my.cnf

echoc -g2 "# Install phpMyAdmin"
echoc -g2 "tb app sudo/create pma-v1 --certbot --template_install=pma"

