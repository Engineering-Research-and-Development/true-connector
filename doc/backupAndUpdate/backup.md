# Backup & restore data

To backup and restore data TRUE Connector offers two scripts: [`backup_script.sh`](./backup_script.sh) for creating backups and [`restore_script.sh`](./restore_script.sh) for restoring from backups.

Before using these scripts, please ensure that they are executable. If they are not executable, you can make them executable using the following terminal command:

```bash
chmod +x backup_script.sh restore_script.sh
```

## `backup_script.sh`

### Description

`backup_script.sh` is a script for creating backups of TRUE Connector docker containers. To use it, follow these steps:

1. **Specify Destination Directory**: Open the script and change the `DEST_DIR` variable to specify the destination directory where backup files will be stored on the filesystem.

2. **Run the Script**: Execute the script, and it will perform the following steps:
   - Iterate through an array with the names of all containers.
   - Create backup files for each container.
   - Copy the backup files to the specified destination directory.
   - Delete the temporary backup files on the Docker volume.


## `restore_script.sh`

### Description

`restore_script.sh` is a script for restoring TRUE Connector Docker containers from backups. To use it, follow these steps:

1. **Specify Docker Compose Path**: Open the script and change the `DOCKER_COMPOSE_PATH` variable to specify the path to your Docker Compose file.

2. **Specify Backup Folder**: Change the `BCKP_DIR` variable to specify the folder where backup files are located.

3. **Specify Desired Date for backup**: Set the `DATE` variable to the date of the backup you want to restore in format `YYYY-MM-DD`

4. **Run the Script**: Execute the script, and it will perform the following steps:
   - Stop all containers defined in your Docker Compose file.
   - Iterate through an array of containers, checking if backup files exist for the specified date.
   - If backup files exist, it will delete the previous content in each container's volume.
   - Copy the data from the backup files into the respective container volumes.
   - Start all containers again.

## Setting Up a Cron Job for Daily Backups

To automate the backup process and run the `backup_script.sh` daily at 00:00:02, you can set up a cron job. Here's how to do it:

1. Open your terminal.

2. Edit your crontab file by running:

   ```bash
   crontab -e
   ```

3. Add the following line to schedule the backup script to run daily at 00:00:02:

   ```bash
   2 0 * * * /path/to/backup_script.sh
   ```

   Replace `/path/to/backup_script.sh` with the actual path to your `backup_script.sh` file.

4. Save and exit the crontab editor.

This cron job will execute the backup script daily at 00:00:02, ensuring that your Docker container backups are automatically created at the specified time.
