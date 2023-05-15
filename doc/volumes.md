### Volumes <a href="#volumes" id="volumes"></a>

Following docker volumes will be created

```
ecc_provider_log
ecc_provider_sd
uc_provider_data
be_dataapp_data_provider

ecc_consumer_log
ecc_consumer_sd
uc_consumer_data
be_dataapp_data_consumer
```

Those volumes will store data needed for corresponding service, like log files, self description file, Usage Control H2 database (default configuration) and dataApp resource storage.

If you need to have some files present in volume, for example provider dataApp shares some file, you can either

* create volume, mount it to some "dummy" docker container, copy file into volume, stop "dummy" container and you will have file present in volume, and when you start TRUEConnector, it will load already populated dataApp resource volume, or
* you can change using volume and mount folder instead.
