### Usage Control <a href="#usagecontrol" id="usagecontrol"></a>

Details about the PMP and PEP components and examples of policies compatible with Platoon UC app, please check [README](https://github.com/Engineering-Research-and-Development/true-connector-uc_data_app_platoon/blob/1.7.9/README.md)

Since Usage Control is disabled by default, in order to enable it, set following property to true:

```
application.isEnabledUsageControl=true

```

Default Usage Control app is configured by passing env variable through docker-compose.yml file:

```
UC_DATAAPP_URI=http://uc-dataapp-provider:8080/platoontec/PlatoonDataUsage/1.0/
```

or

```
UC_DATAAPP_URI=http://uc-dataapp-consumer:8080/platoontec/PlatoonDataUsage/1.0/
```

Usage Control by default uses H2 database with default configuration it is possible to replace with PostgreSQL, more information can be found [here](../postgreConfiguration.md)).