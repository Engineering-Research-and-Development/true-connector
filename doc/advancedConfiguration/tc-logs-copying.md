## TC logs copying from docker volumes to read-only folder <a href="#tc-logs-copy" id="tcLogsCopy"></a>

***IMPORTANT:*** Operation described in this document can be only be done by **administrator (root)** user.

If there is a need to create an additional user with SSH access to view TC logs, this can be achieved using the [tc-logs-copying.sh](./tc-logs-copying.sh) script provided. Once script is downloaded, before running, be sure to check if script is executable.

Make sure to replace value of `DEST_DIR=` from `/path/to/acutal/folder/tc_logs"` with the actual path where you want to copy TC logs.

This script is designed to copy logs from Docker volumes to a designated folder on the filesystem and make it read-only. 


### Setting Up a Cron Job

To automate the log copying process, a cron job that will run the tc-logs-copying.sh script at a specified time daily can be configured. Here's how to create a cron job to run the script at 00:00:10 every day, and copy the logs from previous day:

1. Open your terminal and edit the crontab configuration for your user by running:

```
crontab -e
```

2. Add the following line to the crontab file to schedule the script to run at 00:00:10 daily:

```
10 0 * * * /bin/bash /path/to/tc-logs-copying.sh
```

Make sure to replace `/path/to/tc-logs-copying.sh` with the actual path to your `tc-logs-copying.sh` script.

3. Save the crontab file and exit the text editor.

Now, the `tc-logs-copying.sh` script will be executed automatically every day at 00:00:10, copying the TC logs to the specified destination folder on a filesystem.
