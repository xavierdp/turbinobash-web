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

export DEBIAN_FRONTEND=noninteractive

apt update -y
apt dist-upgrade -y
apt install -y bash-completion curl nano

bash ../modules/module/wrappers/install

tb app sudo/install/base
tb app sudo/install/web --proxy
tb app sudo/install/ssl $hostname --proxy
tb app sudo/way/init nginx $email $hostname
tb app sudo/install/files
service nginx restart
service php7.4-fpm restart
service php8.1-fpm restart
service mariadb restart

echoc -g2 "# tb app sudo/way/proxy/create test-v1 http://127.0.0.1/ --certbot"

echoc -y2 "# quit shell and comeback to enable tb completion"
