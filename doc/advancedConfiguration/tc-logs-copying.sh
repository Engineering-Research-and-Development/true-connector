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