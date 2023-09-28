# params
# 1 : email for LetsEncrypt
# 2 : hostname use for base url

if [ -z "$1" ]; then
  echo "email for Letsencrypt TOS is missing"

  exit
fi

email=$1

if [ -z "$2" ]; then
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
tb app sudo/install/web --hybrid
tb app sudo/install/ssl $hostname --hybrid
tb app sudo/way/init hybrid $email $hostname $php_default_version
tb app sudo/install/files
service apache2 restart
service nginx restart
service php7.4-fpm restart
service php8.1-fpm restart
service mariadb restart

echo "# quit shell and comeback to enable tb completion"

echo "# MARIADB"
echo "# /root/.my.cnf"
cat /root/.my.cnf

echo "# Install phpMyAdmin"
echo "tb app sudo/create pma-v1 --certbot --template_install=pma"
