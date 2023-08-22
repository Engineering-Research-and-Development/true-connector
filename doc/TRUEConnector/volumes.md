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

Volume `be_dataapp_provider_data` is an external volume which was created following the [start-stop.md](start-stop.md) .

Following the instructions, all files present on the host in the folder `be-dataapp_data_provder` will be present in the volume, so if you need to have some files present in volume, please put them in this folder before running the script and all of them will be present in `DataApp Provider` application.
