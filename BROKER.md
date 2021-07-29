# Broker interaction

Here are sample requests, which can be used as starting point to make request towards Broker.

### Registration request
In order to register to broker, proxy endpoint can be used to send register request. 

<i>Forward-To</i> needs to be BrokerURL.</br>
<i>message</i> part or proxy request, ConnectorUpdateMessage as json must be created and set as value.</br>
<i>payload</i> object of proxy request set self description json string of connector that we wish to register.

Example of ConnectorUpdateMessage:

```
{
  "@context" : {
    "ids" : "https://w3id.org/idsa/core/",
    "idsc" : "https://w3id.org/idsa/code/"
  },
  "@type" : "ids:ConnectorUpdateMessage",
  "@id" : "https://w3id.org/idsa/autogen/connectorUpdateMessage/6d875403-cfea-4aad-979c-3515c2e71967",
  "ids:modelVersion" : "4.0.0",
  "ids:issued" : {
    "@value" : "2021-03-09T12:59:36.780+01:00",
    "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
  },
  "ids:senderAgent" : {
    "@id" : "http://example.org"
  },
  "ids:issuerConnector" : {
    "@id" : "https://eng.true-connector.com/"
  },
  "ids:affectedConnector" : {
    "@id" : "https://eng.true-connector.com/"
  }
}

```

### Update registration request
In order to register update existing registration, proxy endpoint can be used to send update request.</br>

<i>Forward-To</i> needs to be BrokerURL.</br>
<i>message</i> part or proxy request, ConnectorUpdateMessage as json must be created and set as value.</br>
<i>payload</i> object of proxy request set self description json string of connector that we wish to register.

			
### Delete registration request
In order to delete broker registration, proxy endpoint can be used to send delete request. 

<i>Forward-To</i> needs to be BrokerURL.</br>
<i>message</i> part or proxy request, ConnectorUnavailableMessage as json must be created and set as value.</br>
<i>payload</i> object of proxy request set self description json string of connector that we wish to register.

Example of ConnectorUnavailableMessage:

```
{
  "@context" : {
    "ids" : "https://w3id.org/idsa/core/",
    "idsc" : "https://w3id.org/idsa/code/"
  },
  "@type" : "ids:ConnectorUnavailableMessage",
  "@id" : "http://industrialdataspace.org/connectorUnavailableMessage/911c7676-d5f2-4ae6-874c-73a26f865e12",
  "ids:issued" : {
    "@value" : "2021-03-09T13:00:36.045+01:00",
    "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
  },
  "ids:senderAgent" : {
    "@id" : "http://example.org"
  },
  "ids:modelVersion" : "4.0.0",
  "ids:issuerConnector" : {
    "@id" : "https://eng.true-connector.com/"
  },
  "ids:affectedConnector" : {
    "@id" : "https://eng.true-connector.com/"
  }
}
```
			
### Passivate broker registration
In order to passivate broker registration, proxy endpoint can be used to send passivate request. 

<i>Forward-To</i> needs to be BrokerURL.</br>
<i>message</i> part or proxy request, ConnectorInactiveMessage as json must be created and set as value.</br>
<i>payload</i> object of proxy request set self description json string of connector that we wish to register.

Example of ConnectorInactiveMessage:

```
{
  "@context" : {
    "ids" : "https://w3id.org/idsa/core/",
    "idsc" : "https://w3id.org/idsa/code/"
  },
  "@type" : "ids:ConnectorUnavailableMessage",
  "@id" : "https://w3id.org/idsa/autogen/connectorInactiveMessage/8ea20fa1-7258-41c9-abc2-82c787d50ec3",
  "ids:affectedConnector" : {
    "@id" : "https://eng.true-connector.com/"
  },
  "ids:senderAgent" : {
    "@id" : "http://example.org"
  },
  "ids:issued" : {
    "@value" : "2021-03-09T13:01:55.255+01:00",
    "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
  },
  "ids:modelVersion" : "4.0.0",
  "ids:issuerConnector" : {
    "@id" : "https://eng.true-connector.com/"
  }
}
```
			
### Query broker
In order to query broker, proxy endpoint can be used to send register request. 

<i>Forward-To</i> needs to be BrokerURL.</br>
<i>message</i> part or proxy request, QueryMessage as json must be created and set as value.</br>
<i>payload</i> object of proxy request set query we wish to sent to Broker.

Example of QueryMessage:

```
{
  "@context" : {
    "ids" : "https://w3id.org/idsa/core/",
    "idsc" : "https://w3id.org/idsa/code/"
  },
  "@type" : "ids:QueryMessage",
  "@id" : "https://w3id.org/idsa/autogen/queryMessage/1242e627-ef26-48ce-8deb-772e86750f9d",
  "ids:queryScope" : {
    "@id" : "idsc:ALL"
  },
  "ids:queryLanguage" : {
    "@id" : "idsc:SPARQL"
  },
  "ids:issued" : {
    "@value" : "2021-03-09T13:22:05.209+01:00",
    "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
  },
  "ids:modelVersion" : "4.0.0",
  "ids:issuerConnector" : {
    "@id" : "http://connectorURI"
  }
}
```

Payload can be like following:

```
SELECT ?connectorUri WHERE { ?connectorUri a ids:BaseConnector . } '
```

{ At the moment, broker supports only multipart/mixed requests, this means that connector will have to be configured to mulitpar/mixed configuration. }