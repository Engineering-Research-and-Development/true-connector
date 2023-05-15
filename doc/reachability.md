## Connector reachability

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

### Connector ID {#connectorid}

In .env file, you can find 2 properties, one for Provider and one for Consumer, called

```
PROVIDER_ISSUER_CONNECTOR_URI=http://w3id.org/engrd/connector/provider

CONSUMER_ISSUER_CONNECTOR_URI=http://w3id.org/engrd/connector/consumer

```

Those 2 properties can be modified to "label" connector with proper Id. This Id plays important role in Contract Negotiation sequence, since those 2 values will be used when creating Contract Agreement and when enforcing policy. Also, they are used in Basic Data App, in proxy functionality, to create request and response messages, to set correct value for issuerConnector.

