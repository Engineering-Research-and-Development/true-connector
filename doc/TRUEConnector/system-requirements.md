### System requirements <a href="doc/#systemrequirements" id="systemrequirements"></a>

In order to run TRUE Connector following minimal system requirements are needed:

* CPU: newer 4 core (8 threads)
* Memory: at least 2GB dedicated to TRUE Connector (1024MB - for ECC services, 512MB for DataApp and 512MB for Usage Control services)

This values can be considered as initial values, and if required, they can be increased or reduced, keeping the functionality of TRUE Connector unchanged.

Default resources, provided to docker containers are following (defined in docker-compose.yml):

```
 ecc-*:
    deploy:
      resources:
        limits:
          cpus: "1"
          memory: 1024M
    logging:
      options:
        max-size: "200M"
...

 uc-dataapp-*:
    deploy:
      resources:
        limits:
          cpus: "1"
          memory: 512M
    logging:
      options:
        max-size: "100M"
...

 uc-dataapp-pip-*:
    deploy:
      resources:
        limits:
          cpus: "1"
          memory: 512M
    logging:
      options:
        max-size: "100M"
...

  be-dataapp-*:
    deploy:
      resources:
        limits:
          cpus: "1"
          memory: 512M
    logging:
      options:
        max-size: "100M"
...

```

In case that you need to assign more memory to some specific service, this can be done by increasing memory amount in deploy section for specific service.
In case of *java.lang.OutOfMemoryError: Java heap space* be sure to pass following environment variable to "problematic" service:


- "JDK_JAVA_OPTIONS=-Xmx1024m"

Variables defined in deploy resource part and this passed to JVM needs to be correlated, meaning that you first need to delegate memory to docker service and then to assign memory JVM from that amount.
