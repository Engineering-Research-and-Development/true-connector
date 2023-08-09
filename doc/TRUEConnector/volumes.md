### Volumes <a href="#volumes" id="volumes"></a>

Following docker volumes will be created

```
ecc_provider_data
uc_provider_data
be_dataapp_provider_data

ecc_consumer_data
uc_consumer_data
be_dataapp_consumer_data
```

Those volumes will store data needed for corresponding service, like log files, self description file, Usage Control H2 database (default configuration) and dataApp resource storage.

Volume `be_dataapp_provider_data` is external volume. In order to create it, please execute the script `prepopulate_be_dataapp_data_provider.sh` running next command:

```
sudo ./prepopulate_be_dataapp_data_provider.sh 

```

***NOTE:*** If you're using Linux, check if script is executable, if not, run the next command:

```
chmod +x prepopulate_be_dataapp_data_provider.sh 

```

Running this script, all files present on the host in folder `be-dataapp_data_provder` will be present in volume, so if you need to have some files present in volume, please put them in this folder before running script, and all of them will be present in `DataApp Provider` application.
