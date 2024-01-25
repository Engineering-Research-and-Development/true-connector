#!/bin/bash

# Check if the Docker volume 'trueconnector_be_dataapp_provider_data' exists
if docker volume inspect trueconnector_be_dataapp_provider_data &> /dev/null; then
  # If it exists, remove it
  echo "Removing existing Docker volume 'trueconnector_be_dataapp_provider_data'..."
  docker volume rm trueconnector_be_dataapp_provider_data
else
  # If it doesn't exist, print a message
  echo "Docker volume 'trueconnector_be_dataapp_provider_data' does not exist, skipping removal..."
fi

echo "Creating trueconnector_be_dataapp_provider_data volume..."
# Replace 'trueconnector_be_dataapp_provider_data' with the actual volume name you want to create
docker volume create trueconnector_be_dataapp_provider_data
echo "trueconnector_be_dataapp_provider_data volume created"

# Change the ownership of the local folder 'be-dataapp_data_provider' to nobody:nogroup
chown -R nobody:nogroup "$(pwd)/be-dataapp_data_provider"

# Create the 'datalake' directory inside the 'trueconnector_be_dataapp_provider_data' volume with the desired ownership
docker run --rm -v "trueconnector_be_dataapp_provider_data:/target_data" alpine sh -c "mkdir -p /target_data/datalake && chown -R nobody:nogroup /target_data/datalake"

# Copy data from the 'trueconnector_be-dataapp_data_provider' folder to the 'target_data/datalake' directory inside the Docker volume
docker run --rm -v "$(pwd)/be-dataapp_data_provider:/source_data" -v "trueconnector_be_dataapp_provider_data:/target_data" alpine sh -c "cp -r /source_data/* /target_data/datalake/"

# Create the 'log' directory inside the 'trueconnector_be_dataapp_provider_data' volume with the desired ownership
docker run --rm -v "trueconnector_be_dataapp_provider_data:/target_data" alpine sh -c "mkdir -p /target_data/log/dataapp && chown -R nobody:nogroup /target_data/log/dataapp"

# Change the ownership of the Docker volume contents to 'nobody:nogroup'
docker run --rm -v "trueconnector_be_dataapp_provider_data:/target_data" alpine sh -c "chown -R nobody:nogroup /target_data"
