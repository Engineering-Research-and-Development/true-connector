## Connector ID 

In .env file, you can find 2 properties, one for Provider and one for Consumer, called

```
PROVIDER_ISSUER_CONNECTOR_URI=http://w3id.org/engrd/connector/provider

CONSUMER_ISSUER_CONNECTOR_URI=http://w3id.org/engrd/connector/consumer

```

Those 2 properties can be modified to "label" connector with proper Id. This Id plays important role in Contract Negotiation sequence, since those 2 values will be used when creating Contract Agreement and when enforcing policy. Also, they are used in Basic Data App, in proxy functionality, to create request and response messages, to set correct value for issuerConnector.
