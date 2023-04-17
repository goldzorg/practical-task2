#!/bin/bash
#скрипт создает бекап директории /home, а также директории /var/log. 
#бекап конфигурационных файлов основных утилит удалённого доступа (SSH, RDP, FTP)
#определяем временную папку для бекапа
dir=/tmp/bckp
#определяем папку куда перемещаем созданные бекап файлы
dest=/mnt/archive/
#создаем временную папку и переходим в нее
mkdir $dir | chmod 700 $dir
cd $dir
tar -cpf full-backup-home_`date '+%Y-%m-%d'`.tar /home
tar -cpf backup-ftp-conf_`date '+%Y-%m-%d'`.tar /etc/vsftpd.conf
tar -cpf backup-ssh-conf_`date '+%Y-%m-%d'`.tar /etc/ssh/sshd_config
tar -cpf backup-xrdp-starwm_`date '+%Y-%m-%d'`.tar /etc/xrdp/startwm.sh
tar -cpf backup-xrdp-ini_`date '+%Y-%m-%d'`.tar /etc/xrdp/xrdp.ini
tar -cpf full-backup-var-log_`date '+%Y-%m-%d'`.tar /var/log
#Проверяем доступна ли папка archive, куда нужно переместить бекап файлы
#Если папка доступна, то перемещаем файлы. Если нет, то создаем папку и перемещаем бекап файлы
if [ -d $dest ]
then
mv $dir/*.tar $dest 2>/dev/nul || echo "no files"
else 
mkdir $dest | chmod 700 $dest | mv $dir/*.tar $dest 2>/dev/nul || echo "no files"
fi

