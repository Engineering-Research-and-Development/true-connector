#!/bin/bash

echo "Starting backup script..."
echo "________________________________________________________"
# Directory where the backup will be copied on the filesystem
DEST_DIR="/path/to/backup/folder"
mkdir -p "$DEST_DIR"

# Today's date in yyyy-MM-dd format
TODAY=$(date +%F)

# Array of container names
containers=(
    "uc-dataapp-consumer"
    "uc-dataapp-provider"
    "ecc-consumer"
    "ecc-provider"
    "be-dataapp-consumer"
    "be-dataapp-provider"
)

# Loop through each container
for container in "${containers[@]}"; do
    echo "Backing up $container for date: $TODAY..."

    # Create backup inside the container
    docker exec "$container" tar cvf /tmp/"$container-$TODAY-backup.tar" /home/nobody/data

    # Copy backup from the container to the host
    docker cp "$container":/tmp/"$container-$TODAY-backup.tar" "$DEST_DIR"

    if [ $? -eq 0 ]; then
        # If copy is successful, delete the temporary backup file inside the container
        docker exec "$container" rm /tmp/"$container-$TODAY-backup.tar"
        echo "Backup done for $container"
    else
        echo "Backup failed for $container"
    fi
    echo "________________________________________________________"
done
