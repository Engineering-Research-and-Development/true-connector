### Usage Control <a href="#usagecontrol" id="usagecontrol"></a>

Details about the PMP and PEP components and how to switch to PostgeSQL from the default H2 in-memory database you can find [here](../PLATOON\_USAGE\_CONTROL.md).

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