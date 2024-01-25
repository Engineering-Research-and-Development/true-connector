#!/bin/bash

echo "Starting restore script..."
echo "____________________________________________________________________"

# Path to the directory containing the Docker Compose file
DOCKER_COMPOSE_PATH="/path/to/folder/where/compose/is"

# Directory where the backups are stored on the filesystem
BCKP_DIR="/path/to/backup/folder"

# Date of desired backup for restore
DATE="YYYY-MM-DD"

# Array of container names and their associated volumes
declare -A containers
containers=(
    ["uc-dataapp-consumer"]="trueconnector_uc_consumer_data"
    ["uc-dataapp-provider"]="trueconnector_uc_provider_data"
    ["ecc-consumer"]="trueconnector_ecc_consumer_data"
    ["ecc-provider"]="trueconnector_ecc_provider_data"
    ["be-dataapp-consumer"]="trueconnector_be_dataapp_consumer_data"
    ["be-dataapp-provider"]="trueconnector_be_dataapp_provider_data"
)

# Go to the Docker Compose directory
cd "$DOCKER_COMPOSE_PATH" || { echo "Failed to navigate to DOCKER_COMPOSE_PATH"; exit 1; }

# Stop all containers managed by Docker Compose
echo "Stopping all Docker Compose containers..."
docker-compose down || { echo "Failed to stop containers"; exit 1; }

# Polling for containers to be completely stopped
echo "Waiting for all containers to stop..."
while docker-compose ps | grep -E "(Up|Starting|Exiting)" > /dev/null; do
    sleep 5
    echo "Waiting for all containers to stop..."
done

echo "All containers are stopped."
echo "____________________________________________________________________"

# Flag to track overall success
all_success=true

# Loop through each container
for container in "${!containers[@]}"; do
    volume=${containers[$container]}
    backup_file="$BCKP_DIR/$container-$DATE-backup.tar"

    # Check if the backup file exists
    if [ ! -f "$backup_file" ]; then
        echo "Backup file $backup_file not found for $container"
        all_success=false
        continue
    fi

    echo "Restoring $container for date: $DATE..."
    echo "____________________________________________________________________"
    
    # Clear the target directory
    docker run --rm -v "$volume":/home ubuntu bash -c "rm -rf /home/*"

    # Change ownership of the backup files on the host
    sudo chown -R nobody:nogroup "$backup_file"

    # Extracting the backup
    docker run --rm -v "$volume":/home -v "$BCKP_DIR":/backup ubuntu bash -c "cd /home && tar xvf /backup/$(basename "$backup_file") --strip 3"
    TAR_EXIT_STATUS=$?

    # Change ownership of the files to nobody:nogroup
    docker run --rm -v "$volume":/home ubuntu chown -R nobody:nogroup /home

    # Check for tar command success
    if [ $TAR_EXIT_STATUS -ne 0 ]; then
        echo "Restore failed for $container"
        echo "____________________________________________________________________"
        all_success=false
        continue
    fi

    echo "Restore done for $container"
    echo "____________________________________________________________________"
done

# Start Docker Compose if all restores were successful
if [ "$all_success" = true ]; then
    echo "All restores were successful, starting Docker Compose..."
    echo "____________________________________________________________________"
    docker-compose up -d
else
    echo "Some restores failed, not starting Docker Compose."
    echo "____________________________________________________________________"
fi
