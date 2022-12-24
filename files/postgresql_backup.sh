#!/bin/bash
backup_dir="/var/tmp/backup"
#String to append to the name of the backup files
backup_date=`date +%d-%m-%Y`
LOGFILE=/opt/scripts/backup.log

databases=`sudo -u postgres psql -l -t | cut -d'|' -f1 | sed -e 's/ //g' -e '/^$/d'`
for i in $databases; do  if [ "$i" != "postgres" ] && [ "$i" != "template0" ] && [ "$i" != "template1" ] && [ "$i" != "template_postgis" ]; then    
    echo Dumping $i to $backup_dir/"$i"_$backup_date.bak 
    sudo -u postgres pg_dump -F c $i > $backup_dir/"$i"_$backup_date.bak
    echo "$(date +"%Y.%m.%d %H:%M:%S") backup_db INFO: "$i". Резервная копия создана успешно" >> $LOGFILE
  else
    echo "$(date +"%Y.%m.%d %H:%M:%S") backup_db ERROR: "$i". Ошибка на этапе создания резервной копии средствами pg_dump" >> $LOGFILE
    exit 1
  fi
done