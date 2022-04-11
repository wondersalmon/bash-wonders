#/bin/bash
#Указываем откуда и куда делать бэкапы \ #Specify the path from where to get the files, and the path where you want to make a backup
from="Путь к папке из которой будем копировать" #We will archive this folder
archive="Путь к папке с Я.Диском" #We will archive in this folder

#Создаем переменную указывающую на скрипт, отвечающий за отправку в телеграм \ #Create a variable pointing to the script responsible for sending to telegram
tg='./telegram.sh'

#Указываем папки для бэкапа, если нужна не вся \ # Specify folders for backup if not all are needed
which_dir="перечислить имена папок через пробел" #We list the folders with a space "folder 1 folder 2 etc"

#Создание папки с бэкапами по дате \ #Create backup folders with current date
mkdir -p $archive/$(date +"%Y-%m-%d")

#Создание папки с датой бэкапа \ #Set a variable for the folder with the current date
backup_dir="$archive/$(date +"%Y-%m-%d")"

# Начинаем цикл for, где для каждого значения переменной (списка в ней) делаем (do) набор действий \ #We start the for loop, where for each value of the variable (the list in it) we do (do) a set of actions
for dir in $which_dir; do
echo "Копируем $from в $backup_dir" #Оповещение о процессе создания \#Creation Progress Alert

# Рекурсивное копирование (-a), с выводом процесса (-v) и форматированием (-h) \ #Recursive copy (-a), with process output (-v) and formatting (-h)
rsync -avh  $from$dir $backup_dir
done

# Архивируем всю папку, в которой лежит бекап со сжатием gzip (-z) \ #We archive the entire folder in which the backup is located with gzip compression (-z)
# c – создает новый файл .tar; \#creates a new .tar file;
# v – выводит подробное описание процесса сжатия; \ #v - displays a detailed description of the compression process;
# f – имя файла. \ #sets the file name
# z - сжатие gzip, чтобы уменьшить размер архива. \#gzip compression to reduce archive size
tar -cvzf $archive/backup_$(date +"%Y-%m-%d").tar.gz $backup_dir

# освобождаем место \ #Clean up to free up disk space
rm -rf $backup_dir

#Перезапуск яд \ #Restarting the Yandex disk service (or insert a service from another file cloud here)
yandex-disk stop
yandex-disk start

#Отправляем сообщение с названием бэкапа в телеграм. Если не хотим в тг - меняем $tg на echo \ #We send a message with the name of the backup in telegram. If we don't want it in tg - change $tg to echo
$tg "backup_$(date +"%Y-%m-%d").tar.gz готов" >> /dev/null

# Получаем список бекапов из папки, в которой они хранятся. \ #We get a list of backups from the folder in which they are stored.
backup_list=$(ls $archive/ | grep backup)

# Создаем переменную с текущим месяцем \ #Create a variable with the current month
month=$(date +"%m")

# Задаем дату, когда бекап будет считаться устаревшим. \ #Set the date when the backup will be considered obsolete.
expire_date=$(date +"%d" -d '-3 day')
echo "Удаляем бекапы, старше $(date +"%d.%m.%Y" -d '-3 day')" #Notification about deleting obsolete backups
for file in $backup_list; do

# Получаем дату бекапа \ #Get backup date
backup_date=$(echo $file | awk -F"-" '{print $2}')

echo "backup_2022-$backup_date-$month.tar.gz"

done
# Удаляет бэкап, если переменная $backup_date меньше чем $expire_date \ #Deletes a backup if $backup_date is less than $expire_date
if [[ $backup_date < $expire_date ]]
then
	echo "Удаляем файл  backup_2022-$backup_date-$month.tar.gz" #Notification about deleting obsolete backups
	rm -f $archive/backup_2021-$backup_date-$month.tar.gz
fi

# Уведомляет о том, что новые бэкапы сделаны, а старые удалены. Если не хотим в тг - меняем $tg на echo 
#Notifies that new backups have been made and old ones have been deleted. If we don't want it in tg - change $tg to echo
$tg "Бэкапы актуализированы" >> /dev/null