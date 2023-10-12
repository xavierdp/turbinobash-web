# turbinobash-web

**turbinobash-web** is a small commandline PLESK like

Normaly comptatible with debian 11 (debian 12 not tested) et ubuntu 22.04

## turbinobash 

**turbinobash** is a bash framewok i made to manage bash script and script completion

**turbinobash-web** is a combination of 4 modules
* module : to manage modules
* app : to manage applications
* mysql : to manage mysq databases things
* template : to manage templates used with app

There is **4 scripts** in the scripts directory to isntall 4 ways of web use :
* nginx : pure nginx usage + php fpm + mariadb
* apache : pure apache usage + php fpm + mariadb
* hybrid : nginx proxying towards apache + php fpm + mariadb
* proxy : nginx only use for proxying


```bash
cd /var/lib

git clone https://github.com/xavierdp/turbinobash-web.git

cd turbinobash-web/scripts
```


```bash
# johndoe@domain.tld is the email to use with letsencrypt
# sub.mydomain.tld is the sub domain pluged with the container's IP

# NGINX
bash nginx.sh johndoe@domain.tld sub.mydomain.tld

# APACHE2
bash apache.sh johndoe@domain.tld sub.mydomain.tld

# NGINX proxying APACHE2
bash hybrid.sh johndoe@domain.tld sub.mydomain.tld

# Just NGINX proxying
bash proxy.sh johndoe@domain.tld sub.mydomain.tld
``` ![image](https://github.com/xavierdp/turbinobash-web/assets/38561912/0678f6d5-b19c-406f-a229-cf4078583749)



if you start lauch nginx.sh and after apache.sh, the nginx things are purged

if you start lauch apache.sh and after nginx.sh, the apache things are purged

if you start lauch apache.sh or nginx.sh and after proxy.sh, the apache and mariadb things are purged


```bash
# create test-v1.sub.mydomain.tld with SSL
tb app sudo/create test-v1 --certbot

# create sub.myotherdomain.tld with SSL
tb app sudo/create test-v1 --certbot --webdomain sub.myotherdomain.tld

# create sub.myotherdomain.tld and www.sub.myotherdomain.tld with SSL
tb app sudo/create test-v1 --certbot --webdomain sub.myotherdomain.tld --www

# create a proxy towards a destination
tb app sudo/way/proxy/create test-v1 https://127.0.0.1/ --certbot
```

# Structure of an app

## Directory scructure
Alls apps are in /apps

```console
root@test0:/apps/test-v1# tree
.
|-- app
|   `-- webroot
|       `-- index.php
|-- etc
|   |-- mysql
|   |   `-- localhost
|   |       `-- passwd
|   |-- php
|   |   `-- version
|   `-- ssh
|       `-- passwd
|-- log
|-- sav
`-- tmp
    `-- sessions

11 directories, 4 files
```
## test-v1 every where

- The app name is **test-v1**
- The sytem user is **test-v1**
- The db name is **test-v1**
- The db user is **test-v1**


```php
// wordperss wp-config usage 
define( 'DB_NAME', $_SERVER["USER"]);
define( 'DB_USER', $_SERVER["USER"]);
define( 'DB_PASSWORD', trim(file_get_contents("/apps/$_SERVER[USER]/etc/mysql/localhost/passwd")));
define( 'DB_HOST', 'localhost' );
```

### So each app is movable !!

you make a test-v2

```bash
# copy files app from test-v1 to test-v2
cd /apps/test-v2
cp /apps/test-v1/app . -rf
```

```bash
# copy database from test-v1 to test-v2
mysqldump test-v1 | mysql test-v2
```

```bash
# Imagine it's a Wordpress : you have to replace the domain into the database
wp search-replace 'test-v1.sub.domain.tld' 'test-v2.sub.domain.tld'
```
https://developer.wordpress.org/cli/commands/search-replace/

Pif paf hopla and the test-v2 is ready !!

#### Apply the good rights to the files and directory

```bash
tb app sudo/bulldozer test-v1
```
#### Change PHP version
```bash
tb app sudo/change/php test-v1 8.1
```

#### Install php version
```bash
tb app sudo/install/php 8.2
```

#### Install wp-cli
```bash
tb app sudo/install/wp-cli
```

#### Install wp-composer
```bash
tb app sudo/install/wp-composer
```

#### Remove an app
```bash
tb app sudo/remove test-v1
```

#### Remove an app without asking

```bash
tb app sudo/remove test-v1 --force
```

#### backup an app (manual mode or specific mode)

```bash
tb app sudo/backup test-v1 
```

```console
############## MANUAL test-v1 APP /var/sav1/test0/manual/test-v1/23-09-25-21H47/test-v1.tar.bz2
############## MANUAL test-v1 DB /var/sav1/test0/manual/test-v1/23-09-25-21H47/test-v1.sql.bz2
############## Done
```

#### backup an app only db

```bash
tb app sudo/backup test-v1 db
```

#### backup an app only file

```bash
tb app sudo/backup test-v1 app
```

#### Crontab to backup All (crontab mode or all mode)

```bash
# m h  dom mon dow   command
30 3 * * * /bin/tb app sudo/backup All
```

##### /etc, /root and all apps are backuped so all could be restored

```console
root@test0:/var/sav1/test0# tree -sh
.
|-- [4.0K]  auto
|   `-- [4.0K]  23-09-25-22H15
|       `-- [4.0K]  test-v1
|           |-- [ 532]  test-v1.sql.bz2
|           `-- [2.6K]  test-v1.tar.bz2
`-- [4.0K]  system
    `-- [4.0K]  23-09-25-22H15
        |-- [497K]  etc.tar.bz2
        `-- [6.5K]  root.tar.bz2
```

#### Crontab to update SSL certificates
nginx version
```bash
# m h  dom mon dow   command
30 4,20 * * * /usr/bin/certbot --nginx renew --quiet;/usr/sbin/service nginx restart
```

#### Crontab diskalert 

Send a email if a partition is more filled tha 85%

```bash
# m h  dom mon dow   command
*/1 * * * * /bin/tb app sudo/diskalert name@domain.tld
```

## [TODO]
How templates are working

```bash
tb app sudo/create pma-v1 --certbot --template=pma
```

Add a an install mode to use à container which remote a proxy one

Backup crontab

