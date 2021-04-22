# TRUE CONNECTOR
**TRUE** (**TRU**sted **E**ngineering) **Connector** for the IDS (International Data Space) ecosystem

The TRUE Connector is composed of three components:

* **Execution Core Container (ECC)**, open-source project designed by ENG. It is in charge of the data exchange through the IDS ecosystem representing data using the IDS Information Model and interacting with an external Identity Provider. It is also able to communicate with an IDS Broker for registering and querying information.
* **Back-End (BE) Data Application**, open-source project designed by ENG. It represents a trivial data application for generating and consuming data on top of the ECC component.
* **Usage-Control (UC) Data Application**, a customized version of the Fraunhofer IESE base application for integrating the MyData Framework (a Usage Control Framework designed and implemented by Fraunhofer IESE) in a connector.

![TRUE Connector Architecture](doc/TRUE_Connector_Architecture.png?raw=true "TRUE Connector Architecture")

## How to Configurate and Run

The configuration should be performed customizing the following variables in the **.env** file:

* **DATA_APP_ENDPOINT=192.168.56.1:8084/data** DataAPP endpoint for receiveing data (F endpoint in the above picture)
* **MULTIPART_EDGE=mixed** DataAPP A-endpoint Content Type (choose *mixed* for Multipart/mixed or *form* for Multipart/form-data or *http-header* for Multipart/http-header) 
* **MULTIPART_ECC=mixed** Execution Core Container B-endpoint Content Type (choose *mixed* for Multipart/mixed or *form* for Multipart/form-data or *http-header* for Multipart/http-header) 
* Edit external ports if need (default values: **8086** for **WS over HTTPS**, **8090** for **http**, **8889** for **B endpoint**, **29292** for **IDSCP2**)

### Supported Identity Providers

The TRUE Connector is able to interact with the following Identity Providers:

* **AISECv1** put the certificate in the *cert* folder, edit related settings (i.e., *application.keyStoreName*, *application.keyStorePassword*) (in the *.env*) and set the *application.dapsVersion* (in the *resources/application-docker.properties*) to *v1*
* **AISECv2** put the certificate in the *cert* folder,edit related settings (i.e., *application.keyStoreName*, *application.keyStorePassword*) (in the *.env*) and set the *application.dapsVersion* (in the *resources/application-docker.properties*) to *v2*
* **ORBITER** put the certificate in the *cert* folder, edit related settings (i.e., *application.daps.orbiter.privateKey*, *application.daps.orbiter.password*) (in the *.env*) and set the *application.dapsVersion* (in the *resources/application-docker.properties*) to *orbiter*


The *application.dapsUrl* (in the *resources/application-docker.properties*) property must be set properly in order to address the right DAPS server.

Finally, run the application:

*  Execute `docker-compose up &`

## Endpoints
The TRUE Connector will use two protocols (http and https) as described by the Docker Compose File.
It will expose the following endpoints:

```
/proxy 
```
to receive data incomming request, and based on received request, forward request to Execution Core Connector (the P endpoint in the above picture)

``` 
/data 
```
to receive data (IDS Message) from a sender connector (the B endpoint in the above picture)
Furthermore, just for testing it will expose (http and https):

```
/about/version 
```
returns business logic version 

## Configuration
The ECC supports three different way to exchange data:

*  **REST endpoints** enabled if *WS_EDGE=false* and *WS_ECC=false*
*  **IDSCP2** enabled if *IDSCP2=true* and WS_ECC = false </br>For *WS_EDGE=true* (use websocket on the edge, false for REST on the edge) 
*  **Web Socket over HTTPS** enabled if *WS_EDGE=true* and *WS_ECC=true* and *IDSCP2=false* for configuration which uses web socket on the edge and between connectors.

For trusted data exchange define in *.env* the SSL settings:

*  KEYSTORE-NAME=changeit(JKS format)
*  KEY-PASSWORD=changeit
*  KEYSTORE-PASSWORD=changeit
*  ALIAS=changeit

## How to Test
The reachability could be verified using the following endpoints:

*  **http://{IP_ADDRESS}:{HTTP_PUBLIC_PORT}/about/version**

Keeping the provided docker-compose, for Data Provider URL will be:

*  **http://{IP_ADDRESS}:8090/about/version**

For Data Consumer, with provided docker-compose file:

*  **http://{IP_ADDRESS}:8091/about/version**


## How to Exchange Data

For details on request samples please check following link [Backend DataApp Usage](https://github.com/Engineering-Research-and-Development/market4.0-data_app_test_BE/blob/master/README.md)

Be sure to use correct configuration/ports for sender and receiver Data App and Execution Core Container (check .env file).

Default values:

```
DataApp URL: https://{IPADDRESS}:8084/proxy 
"Forward-To": "https://{RECEIVER_IP_ADDRESS}:8889/data",
```

For WSS flow:

```
DataApp URL: https://{IPADDRESS}:8084/proxy
"multipart": "wss",
"Forward-To": "wss://ecc-provider:8086/data",
"Forward-To-Internal": "wss://ecc-consumer:8887",
```

### WebSocket 

On the following link, information regarding WebSocket Message Streamer implementation can be found here [WebSocket Message Streamer library](https://github.com/Engineering-Research-and-Development/market4.0-websocket_message_streamer).

#### IDSCP2
Follow the REST endpoint or WS examples, put the server hostname/ip address in the Forward-To header (*wss/https://{RECEIVER_IP_ADDRESS/Hostname}:{WS_PUBLIC_PORT}*).
* **AISECv2** put the certificates (keyStore and trustStore) in the *cert* folder,edit related settings (*IDSCP2 AISEC DAPS settings* section in env file)


## Clearing House

The TRUE Connector supports is able to communicate with the ENG Clearing House for registering transactions. 

## Broker

The TRUE Connector integrates some endpoints for interacting with an IDS Broker:

### SelfDescription

Self Description document, in json format, for connector, can be found at following URL - GET request

```
https://{IPADDRESS}:8091/
```
or 

```
http://{IPADDRESS}:8091/
```
depending on 

```
REST_ENABLE_HTTPS=true
```
configured in .env file.

In order to set different values for connector, based on connector role (Data Consumer/Data Provider), follwoing file and properties needs to be modified:

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

## Usage Control
The TRUE Connector integrates the [Fraunhofer MyData Framework](https://www.mydata-control.de/) for implementing the Usage Control. Details about the PMP and PEP components can be found [here](doc/USAGE_CONTROL_RULES.md). 

## Contract Negotiation - simple flow

For simple contract negotiation flow, with ContractAgreement read from file, please check following link
[Data App Contract Negotiation](https://github.com/Engineering-Research-and-Development/market4.0-data_app_test_BE/blob/master/README.md#markdown-header-Contract-Negotiation-simple-flow) 


## License
The TRUE Connector components are released following different licenses:

* **Execution Core Container**, open-source distributed under the license AGPLv3
* **BE Data APP**, open-source distributed under the license AGPLv3
* **UC Data APP**, TBC

