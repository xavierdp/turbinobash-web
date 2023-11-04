
export DEBIAN_FRONTEND=noninteractive

if [ -z "$1" ]; then
  php=7.4
else
  php=$2
fi



mkdir -p /conf
mkdir -p /apps

echo "noweb" >/conf/mode
echo $php >/conf/php

apt update -y
apt dist-upgrade -y
apt install -y bash-completion curl nano

bash ../modules/module/wrappers/install

tb app sudo/install/base
tb app sudo/install/mariadb
tb app sudo/install/php 7.4
tb app sudo/install/php 8.1
tb app sudo/install/web --noweb
tb app sudo/install/files

tb app sudo/install/mail $hostname

echo "# quit shell and comeback to enable tb completion"

echo "# MARIADB"
echo "# /root/.my.cnf"
cat /root/.my.cnf
