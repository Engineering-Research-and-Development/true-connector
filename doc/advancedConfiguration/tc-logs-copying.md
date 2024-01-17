## TC logs copying from docker volumes to read-only folder <a href="#tc-logs-copy" id="tcLogsCopy"></a>


If there is a need to create an additional user with SSH access to view TC logs, this can be achieved using the tc-logs-copying.sh script provided below. 

```
#!/bin/bash

# Directory where logs will be copied on the filesystem
DEST_DIR="/home/mare/tc_logs"
mkdir -p "$DEST_DIR"

# Yesterday's date in yyyy-MM-dd format
YESTERDAY=$(date -d "yesterday" +%Y-%m-%d)
echo "Searching for logs from $YESTERDAY"

# Array of container names and name of their folder where logs are stored
declare -A containers
containers=(
    ["uc-dataapp-consumer"]="ucapp"
    ["uc-dataapp-provider"]="ucapp"
    ["ecc-consumer"]="ecc"
    ["ecc-provider"]="ecc"
    ["be-dataapp-consumer"]="dataapp"
    ["be-dataapp-provider"]="dataapp"
)

# Loop through each container
for container in "${!containers[@]}"; do

    # Get name of subfolder from array of containers
    subfolder=${containers[$container]}
    
    # Directory where logs are stored in docker volumes
    SRC_DIR="/home/nobody/data/log/$subfolder"

    # Patern for searching any file with yesterday's date
    FILE_PATTERN="*${YESTERDAY}*.gz"

    # Find .gz files with yesterday's date and any index in the name
    FILE_LIST=$(docker exec "$container" find "$SRC_DIR" -name "$FILE_PATTERN")

    # Check if files were found
    if [ -z "$FILE_LIST" ]; then
        echo "No log files found for $container on $YESTERDAY"
    else
        echo "Copying log files for $container from $YESTERDAY"
        for file in $FILE_LIST; do
            # Get the basename of the file
            base_filename="$(basename "$file")"

            if [[ "$container" == "be-dataapp-consumer" || "$container" == "be-dataapp-provider" ]]; then
                base_filename="${base_filename/dataapp/$container}"
            fi

            # Construct the destination file path
            dest_file="$DEST_DIR/$base_filename"

            # Copy the file to the host
            docker cp "$container":"$file" "$dest_file"

            # Set the copied file to read-only
            chmod a-w "$dest_file"
        done
    fi
done
```
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
