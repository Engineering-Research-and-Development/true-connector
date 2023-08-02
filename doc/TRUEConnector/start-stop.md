### Starting and stopping containers <a href="#startstop" id="startstop"></a>

To setup the TRUE connector for starting container, execute the following command:

```
sudo ./prepopulate_be_dataapp_data_provider.sh 

```
With this command, you will create external `be_dataapp_data_provider` volume.

***NOTE:*** If you're using Linux, check if script is executable, if not, run the next command:

```
chmod +x prepopulate_be_dataapp_data_provider.sh 

```

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

You can also check using _docker ps_ command to verify that containers are up and running:

```
CONTAINER ID   IMAGE                                             COMMAND                  CREATED              STATUS                          PORTS                                                                    NAMES
5c7bd4b70295   rdlabengpa/ids_execution_core_container:v1.13.1   "/bin/sh -c 'java -j…"   About a minute ago   Up About a minute (healthy)     0.0.0.0:8087->8086/tcp, 0.0.0.0:8091->8449/tcp, 0.0.0.0:8890->8889/tcp   ecc-consumer
8883c669e3ed   rdlabengpa/ids_execution_core_container:v1.13.1   "/bin/sh -c 'java -j…"   About a minute ago   Up About a minute (healthy)     0.0.0.0:8086->8086/tcp, 0.0.0.0:8889->8889/tcp, 0.0.0.0:8090->8449/tcp   ecc-provider
752af4b94096   rdlabengpa/ids_uc_data_app_platoon_pip:v1.0.0     "java -jar pip.jar"      About a minute ago   Up About a minute               0/tcp                                                                    uc-dataapp-pip-provider
095bf6919593   rdlabengpa/ids_uc_data_app_platoon:v1.7.1         "/bin/sh -c 'java -j…"   About a minute ago   Up About a minute               8080/tcp                                                                 uc-dataapp-provider
59c3b560d8b6   rdlabengpa/ids_be_data_app:v0.2.7                 "/bin/sh -c 'java -j…"   About a minute ago   Up About a minute (unhealthy)   0.0.0.0:8184->8183/tcp, 0.0.0.0:9001->9000/tcp                           be-dataapp-consumer
3f8979a433cf   rdlabengpa/ids_uc_data_app_platoon:v1.7.1         "/bin/sh -c 'java -j…"   About a minute ago   Up About a minute               8080/tcp                                                                 uc-dataapp-consumer
49d5c7e81cff   rdlabengpa/ids_uc_data_app_platoon_pip:v1.0.0     "java -jar pip.jar"      About a minute ago   Up About a minute               0/tcp                                                                    uc-dataapp-pip-consumer
f8de175d72f0   rdlabengpa/ids_be_data_app:v0.2.7                 "/bin/sh -c 'java -j…"   About a minute ago   Up About a minute (unhealthy)   0.0.0.0:8183->8183/tcp, 0.0.0.0:9000->9000/tcp                           be-dataapp-provider

```

NOTE: version of docker images might differ.

Once all containers are up and running, TRUE Connector is ready to be used.

This can be also verified with issuing following GET commands:

Provider connector:

_https://localhost:8090/about/version_

or self description document:\
_https://localhost:8090/_

Consumer connector:

_https://localhost:8091/about/version_

or self description document:\
_https://localhost:8090/_

Ctrl+C is used to exit from log inspection (you will be returned to the terminal).

To stop containers, execute following:

```
docker-compose down -v
```

There is also short video, that shows how to use TRUE Connector. Files are located in [tutorial](../tutorial) folder.

At this point, you should be able to use TRUE Connector and send messages. How to send messages, check following link [Send multipart form request](../exchange-data.md)
