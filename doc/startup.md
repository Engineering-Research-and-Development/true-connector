# Starting up the connector

Once you clone or download repository, you will have following directory structure, with following directories:

```
be-dataapp_data_receiver - containing data needed for receiver/provider dataApp, files to share...
be-dataapp_data_sender
be-dataapp_resources - directory containing property file used for advanced configuration for both dataApps
ecc_cert - directory used to store certificate files (DAPS certificate, HTTPS certificate, truststore...)
ecc_resources_consumer - directory containing property file for consumer ECC advanced configuration
ecc_resources_provider - directory containing property file for provider ECC advanced configuration

Platoon Usage control related (contains property file for usage control data app):
uc-dataapp_resources_consumer
uc-dataapp_resources_provider
```

TrueConnector comes as dockerized application, which consists of few docker containers:

 - provider execution core container
 - provider data application (sample data application)
 - provider usage control application
 - consumer execution core container
 - consumer data application (sample data application)
 - consumer usage control application
 
## System requirements <a name="systemrequirements"></a>

In order to run TrueConnector following minimal system requirements are needed:


## Default configuration <a name="defaultconfiguration"></a>

TRUE Connector comes pre-configured with following:

* Secure https communication between all components (dataApp - ECC, ECC-ECC, and ECC-dataApp), using self-signed certificate
* multipart form format of the message between all components
* DapsInteraction disabled
* Disabled Usage control
* Disabled Clearing House
* Disabled validate protocol in Forward-To header
* Disabled hostname validation

If you wish to change this configuration, please check chapter [Modifying configuration](#modifyconfiguration)

## Starting and stopping containers <a name="startstop"></a>

To start docker container, open terminal and execute following command:

```
docker-compose up &

```
If you are running docker on Linux, you might need administrative rights (sudo)

To check logs, execute following command:

```
docker-compose logs -f

```

You should see log lines from all 6 docker containers, something like following:

```
uc-dataapp-consumer  | 2022-09-16 16:01:50.496  INFO 1 --- [           main] o.s.b.a.e.w.EndpointLinksResolver        : Exposing 0 endpoint(s) beneath base path '/actuator'
uc-dataapp-provider  | 2022-09-16 16:01:50.690  INFO 1 --- [           main] o.s.b.a.e.w.EndpointLinksResolver        : Exposing 0 endpoint(s) beneath base path '/actuator'
uc-dataapp-consumer  | 2022-09-16 16:01:51.062  INFO 1 --- [           main] o.s.b.w.e.t.TomcatWebServer              : Tomcat started on port(s): 8080 (http) with context path '/platoontec/PlatoonDataUsage/1.0'
uc-dataapp-provider  | 2022-09-16 16:01:51.128  INFO 1 --- [           main] o.s.b.w.e.t.TomcatWebServer              : Tomcat started on port(s): 8080 (http) with context path '/platoontec/PlatoonDataUsage/1.0'
uc-dataapp-consumer  | 2022-09-16 16:01:51.155  INFO 1 --- [           main] c.t.d.Swagger2SpringBoot                 : Started Swagger2SpringBoot in 53.078 seconds (JVM running for 60.067)
uc-dataapp-provider  | 2022-09-16 16:01:51.203  INFO 1 --- [           main] c.t.d.Swagger2SpringBoot                 : Started Swagger2SpringBoot in 53.952 seconds (JVM running for 60.42)
be-dataapp-consumer  | Sep 16, 2022 4:01:51 PM org.apache.catalina.core.ApplicationContext log
be-dataapp-consumer  | INFO: Initializing Spring DispatcherServlet 'dispatcherServlet'
be-dataapp-provider  | Sep 16, 2022 4:01:52 PM org.apache.catalina.core.ApplicationContext log
be-dataapp-provider  | INFO: Initializing Spring DispatcherServlet 'dispatcherServlet'
ecc-provider         | Sep 16, 2022 4:02:00 PM org.apache.coyote.AbstractProtocol start
ecc-provider         | INFO: Starting ProtocolHandler ["https-jsse-nio-8449"]
ecc-provider         | Sep 16, 2022 4:02:00 PM org.apache.coyote.AbstractProtocol start
ecc-provider         | INFO: Starting ProtocolHandler ["http-nio-8081"]
ecc-provider         | 16-09-2022 16:02:00.776 [restartedMain] INFO  it.eng.idsa.businesslogic.Application.logStarted - Started Application in 66.089 seconds (JVM running for 69.121)
ecc-consumer         | Sep 16, 2022 4:02:00 PM org.apache.coyote.AbstractProtocol start
ecc-consumer         | INFO: Starting ProtocolHandler ["https-jsse-nio-8449"]
ecc-provider         | Sep 16, 2022 4:02:01 PM org.apache.catalina.core.ApplicationContext log
ecc-provider         | INFO: Initializing Spring DispatcherServlet 'dispatcherServlet'
ecc-consumer         | Sep 16, 2022 4:02:01 PM org.apache.coyote.AbstractProtocol start
ecc-consumer         | INFO: Starting ProtocolHandler ["http-nio-8081"]
ecc-consumer         | 16-09-2022 16:02:01.131 [restartedMain] INFO  it.eng.idsa.businesslogic.Application.logStarted - Started Application in 65.977 seconds (JVM running for 69.317)
ecc-consumer         | Sep 16, 2022 4:02:01 PM org.apache.catalina.core.ApplicationContext log
ecc-consumer         | INFO: Initializing Spring DispatcherServlet 'dispatcherServlet'
```

You can also check using *docker ps* command to verify that containers are up and running:

```
CONTAINER ID   IMAGE                                             COMMAND                  CREATED         STATUS                   PORTS                                                                    NAMES
bea5310f232a   rdlabengpa/ids_be_data_app:v0.2.1                 "/bin/sh -c 'java -j…"   4 minutes ago   Up 4 minutes (healthy)   0.0.0.0:8084->8083/tcp, 0.0.0.0:9001->9000/tcp                           be-dataapp-consumer
7fd1986331af   rdlabengpa/ids_execution_core_container:v1.10.1   "/bin/sh -c 'java -j…"   4 minutes ago   Up 4 minutes (healthy)   0.0.0.0:8086->8086/tcp, 0.0.0.0:8889->8889/tcp, 0.0.0.0:8090->8449/tcp   ecc-provider
c08ebef5bcab   rdlabengpa/ids_execution_core_container:v1.10.1   "/bin/sh -c 'java -j…"   4 minutes ago   Up 4 minutes (healthy)   0.0.0.0:8087->8086/tcp, 0.0.0.0:8091->8449/tcp, 0.0.0.0:8890->8889/tcp   ecc-consumer
89acdc2ed631   rdlabengpa/ids_uc_data_app_platoon:v1.2           "java -jar datausage…"   4 minutes ago   Up 4 minutes             0.0.0.0:9552->8080/tcp                                                   uc-dataapp-provider
6f6a83e671c3   rdlabengpa/ids_be_data_app:v0.2.1                 "/bin/sh -c 'java -j…"   4 minutes ago   Up 4 minutes (healthy)   0.0.0.0:8083->8083/tcp, 0.0.0.0:9000->9000/tcp                           be-dataapp-provider
2af9279ea145   rdlabengpa/ids_uc_data_app_platoon:v1.2           "java -jar datausage…"   4 minutes ago   Up 4 minutes             0.0.0.0:9553->8080/tcp                                                   uc-dataapp-consumer

```

Once all containers are up and running, TrueConnector is ready to be used.

This can be also verified with issuing following GET commands:

Provider connector:

*https://localhost:8090/about/version* 

or self description document:</br>
*https://localhost:8090/* 

Consumer connector:

*https://localhost:8091/about/version*

or self description document:</br>
*https://localhost:8090/* 

Ctrl+C is used to exit from log inspection (you will be returned to the terminal).

To stop containers, execute following:

```
docker-compose down -v
```

At this point, you should be able to use TRUE Connector and send messages.


## Connector property files

In order to set different values for connector, based on connector role (Data Consumer/Data Provider), following file and properties needs to be modified:

```
ecc_resources_consumer/application-docker.properties
or
ecc_resources_provider/application-docker.properties
```

and following properties:

```
application.selfdescription.description=Data Connector description
application.selfdescription.title=Data Connector title
application.selfdescription.curator=http://curatorURI.com
application.selfdescription.maintainer=http://maintainerURI.com
```

## Connector Id <a name="connectorId"></a>

In .env file, you can find 2 properties, one for Provider and one for Consumer, called

```
PROVIDER_ISSUER_CONNECTOR_URI=http://w3id.org/engrd/connector/provider

CONSUMER_ISSUER_CONNECTOR_URI=http://w3id.org/engrd/connector/consumer

```

Those 2 properties can be modified to "label" connector with proper Id. This Id plays important role in Contract Negotiation sequence, since those 2 values will be used when creating Contract Agreement and when enforcing policy. Also, they are used in Basic Data App, in proxy functionality, to create request and response messages, to set correct value for issuerConnector. 
