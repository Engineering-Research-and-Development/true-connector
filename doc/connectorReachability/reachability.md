# Connector reachability

Once docker containers are up and running, you can use following links to verify connectors are up and running, except checking log output.

* **https://{IP\_ADDRESS}:{HTTP\_PUBLIC\_PORT}/about/version**

Keeping the provided docker-compose, for Data Provider URL will be:

* **https://localhost:8090/about/version**

For Data Consumer, with provided docker-compose file:

* **https://localhost:8091/about/version**

Self Description document, in json format, for connector, can be found at following URL - GET request

https://localhost:8091/

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