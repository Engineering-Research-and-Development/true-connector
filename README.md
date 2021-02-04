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
* **MULTIPART=mixed** DataAPP endpoint Content Type (choose *mixed* for Multipart/mixed or *form* for Multipart/form-data or *http-header* for Multipart/http-header) 
* Edit external ports if need (default values: **8086** for **web sockets IDSCP and WS over HTTPS**, **8090** for **http**, **8889** for **B endpoint**)

### Supported Identity Providers

The TRUE Connector is able to interact with the following Identity Providers:

* **AISECv1** put the certificate in the *cert* folder, edit related settings (i.e., *application.keyStoreName*, *application.keyStorePassword*) and set the *application.dapsVersion* (in the *resources/application-docker.properties*) to *v1*
* **AISECv2** put the certificate in the *cert* folder,edit related settings (i.e., *application.keyStoreName*, *application.keyStorePassword*) and set the *application.dapsVersion* (in the *resources/application-docker.properties*) to *v2*
* **ORBITER** put the certificate in the *cert* folder, edit related settings (i.e., *application.daps.orbiter.privateKey*, *application.daps.orbiter.password*) and set the *application.dapsVersion* (in the *resources/application-docker.properties*) to *orbiter*

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

*  **REST endpoints** enabled if *IDSCP=false* and *WS_OVER_HTTPS=false*
*  **IDSCP** enabled if *IDSCP=true* and *WS_OVER_HTTPS=false*
*  **Web Socket over HTTPS** enabled if *WS_OVER_HTTPS=true* and *IDSCP=false*

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

### WebSocket and IDSCP

On the following link, information regarding WebSocket Message Streamer implementation can be found here [WebSocket Message Streamer library](https://github.com/Engineering-Research-and-Development/market4.0-websocket_message_streamer).

#### IDSCP
Follow the REST endpoint examples, taking care to use *idscp://{RECEIVER_IP_ADDRESS}:{WS_PUBLIC_PORT}* in the Forward-To header.


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

In order to register to broker, following endpoint can be used to send register request. 

/selfRegistration/register

```
curl --location --request POST 'https://{IPADDRESS}:8888/selfRegistration/register' \
--header 'Forward-To: http://broker_url/infrastructure'
```

### Update registration request
In order to register update existing registration, following endpoint can be used to send update request. 

/selfRegistration/update

```
curl --location --request POST 'https://{IPADDRESS}:8888/selfRegistration/update' \
--header 'Forward-To: http://broker_url/infrastructure'
```
			
### Delete registration request
In order to delete broker registration, following endpoint can be used to send delete request. 

/selfRegistration/delete

```
curl --location --request POST 'https://{IPADDRESS}:8888/selfRegistration/delete' \
--header 'Forward-To: http://broker_url/infrastructure'
```
			
### Passivate broker registration
In order to passivate broker registration, following endpoint can be used to send passivate request. 

/selfRegistration/passivate

```
curl --location --request POST 'https://{IPADDRESS}:8888/selfRegistration/passivate' \
--header 'Forward-To: http://broker_url/infrastructure'
```
			
### Query broker
In order to query broker, following endpoint can be used to send register request. 

/selfRegistration/query

```
curl --location --request POST 'https://{IPADDRESS}:8888/selfRegistration/query' \
--header 'Forward-To: http://localhost:8080/infrastructure' \
--header 'Content-Type: text/plain' \
--data-raw 'PREFIX ids: <https://w3id.org/idsa/core/>
SELECT ?connectorUri WHERE { ?connectorUri a ids:BaseConnector . } '
```

{ At the moment, broker supports only multipart/mixed requests, this means that connector will have to be configured to mulitpar/mixed configuration. }

## Usage Control
The TRUE Connector integrates the [Fraunhofer MyData Framework](https://www.mydata-control.de/) for implementing the Usage Control. Details about the PMP and PEP components can be found [here](doc/USAGE_CONTROL_RULES.md). 

## License
The TRUE Connector components are released following different licenses:

* **Execution Core Container**, open-source distributed under the license AGPLv3
* **BE Data APP**, open-source distributed under the license AGPLv3
* **UC Data APP**, TBC

