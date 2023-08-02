# Backup & restore data

To backup and restore data we will be using the official Docker documentation as a reference, found [here](https://docs.docker.com/storage/volumes/#back-up-restore-or-migrate-data-volumes).

## Backup

In order to backup your data you can use the following code snippet:

```
docker run --rm --volumes-from ecc-consumer -v %cd%:/backup ubuntu tar cvf /backup/backup.tar /home/nobody/data/log
```

Let me explain the options:

 - ecc-consumer - container with the data that you want to backup
 - %cd% - current directory in the command prompt ( same as $(pwd) on Linux); the directory where you want the backup to be located
 - /backup.tar - name of the backup archive
 - /home/nobody/data/log - directory or file from the container that you wish to backup
 
After the process finishes you will find a .tar file with the data.

## Restore

Restoring the data is done in a similar way:

```
docker run --rm --volumes-from ecc-consumer -v %cd%:/backup ubuntu bash -c "cd /home && tar xvf /backup/backup.tar --strip 1"
```
 
 The options are:
 
 - ecc-consumer - container where you want to restore the data
 - %cd% - current directory in the command prompt ( same as $(pwd) on Linux); the directory where the backup is located
 - /home - directory where the data will be restored
 - /backup.tar - name of the backup archive
 
 **NOTE**
 
 If the backup hierarchy looks like this */home/nobody/data/log* and you wish to keep it when restoring then you have to point the root folder in the command */home*, as it was done in the commands from above.