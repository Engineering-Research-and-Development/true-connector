
# Remove the existing Docker volume (ignoring errors if it doesn't exist)
docker volume rm be_dataapp_provider_data || true

# Replace 'be-be_dataapp_provider_data' with the actual volume name you want to create
docker volume create be_dataapp_provider_data

# Create the 'datalake' directory inside the 'be_dataapp_provider_data' volume with the desired ownership
docker run --rm -v "be_dataapp_provider_data:/target_data" alpine sh -c "mkdir -p /target_data/datalake && chown -R nobody:nogroup /target_data/datalake"

# Copy data from the 'be-dataapp_data_provider' folder to the 'target_data/datalake' directory inside the Docker volume
docker run --rm -v "FULL_PATH/be-dataapp_data_provider:/source_data" -v "be_dataapp_provider_data:/target_data" alpine sh -c "cp -r /source_data/* /target_data/datalake/"

# Create the 'log' directory inside the 'be_dataapp_provider_data' volume with the desired ownership
docker run --rm -v "be_dataapp_provider_data:/target_data" alpine sh -c "mkdir -p /target_data/log/dataapp && chown -R nobody:nogroup /target_data/log/dataapp"

# Change the ownership of the Docker volume contents to 'nobody:nogroup'
docker run --rm -v "be_dataapp_provider_data:/target_data" alpine sh -c "chown -R nobody:nogroup /target_data"