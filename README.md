# TRUE CONNECTOR
**TRUE** (**TRU**sted **E**ngineering) **Connector** for the IDS (International Data Space) ecosystem

The TRUE Connector is composed of three components:

* [Execution Core Container (ECC)](https://github.com/Engineering-Research-and-Development/market4.0-execution_core_container_business_logic), open-source project designed by ENG. It is in charge of the data exchange through the IDS ecosystem representing data using the IDS Information Model and interacting with an external Identity Provider. It is also able to communicate with an IDS Broker for registering and querying information.
* [Back-End (BE) Data Application](https://github.com/Engineering-Research-and-Development/market4.0-data_app_test_BE), open-source project designed by ENG. It represents a trivial data application for generating and consuming data on top of the ECC component.
* [Usage-Control (UC) Data Application](https://github.com/Engineering-Research-and-Development/market4.0-uc_data_app), a customized version of the Fraunhofer IESE base application for integrating the MyData Framework (a Usage Control Framework designed and implemented by Fraunhofer IESE) in a connector.

![TRUE Connector Architecture](doc/TRUE_Connector_Architecture.png?raw=true "TRUE Connector Architecture")


## Table of Contents

* [Introduction](#introduction)
  * [Default configuration](#defaultconfiguration)
  * [Starting and stopping containers](#startstop)
* [Endpoints](#endpoints)
* [Connector reachability](#reachability)
* [How to Exchange Data](#exchangedata) 
* [Modifying configuration](#modifyconfiguration) 
  * [Enable hostname validation](#hosnamevalidation)
  * [SSL/HTTPS](#ssl)
  * [DAPS](#daps)
  * [Change message format](#messageformat)
  * [WebSocket configuration (WSS)](#wss)
  * [IDSCPv2](#idscpv2)
* [Advanced configuration](#advancedconfiguration)
  * [Supported Identity Providers](#identityproviders)
  * [Validate protocol](#validateprotocol)
* [Clearing House](#clearinghouse)
* [Broker](#broker)
* [Usage Control](#usagecontrol)
* [Contract Negotiation](#contractnegotiation)
* [License](#license)

## Introduction  <a name="introduction"></a>

Once you clone or download repository, you will have following directory structure, with following directories:

```
be-dataapp_data_receiver - containing data needed for receiver/provider dataApp, files to share...
be-dataapp_data_sender
be-dataapp_resources - directory containing property file used for advanced configuration for both dataApps
ecc_cert - directory used to store certificate files (DAPS certificate, HTTPS certificate, truststore...)
ecc_resources_consumer - directory containing property file for consumer ECC advanced configuration 
ecc_resources_provider - directory containing property file for provider ECC advanced configuration 

```

### Default configuration <a name="defaultconfiguration"></a>

TRUE Connector comes pre-configured with following:

* hostname validation disabled
* secure https communication between all components (dataApp - ECC, ECC-ECC, and ECC-dataApp), using self-signed certificate
* multipart mixed format of the message between all components
* DapsInteraction disabled
* disagled validate protocol in Forward-To header
* Usage control disabled

If you wish to change this configuration, please check chapter [Modifying configuration](#modifyconfiguration) 

### Starting and stopping containers <a name="startstop"></a>

To start docker container, open terminal and execute following command:

```
docker-compose up &

```
If you are running docker on linux, you might need administrative rights (sudo)

To check logs, execute following command:

```
docker-compose logs -f

```

Ctrl+C is used to exit from log inspection (you will be returned to the terminal).
 
To stop containers, execute following:

```
docker-compose down -v
```
At this point, you should be able to use TRUE Connector and send messages. How to send messages, check following link [Send multipart mix request]():

## Endpoints <a name="enpoints"></a>
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


## Connector reachability <a name="reachability"></a>

Once docker containers are up and running, you can use following links to verify connectors are up and running, except checking log output.

*  **https://{IP_ADDRESS}:{HTTP_PUBLIC_PORT}/about/version**

Keeping the provided docker-compose, for Data Provider URL will be:

*  **https://localhost:8090/about/version**

For Data Consumer, with provided docker-compose file:

*  **https://localhost:8091/about/version**

Self Description document, in json format, for connector, can be found at following URL - GET request

https://localhost:8091/


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

## How to Exchange Data <a name="exchangedata"></a>

With default configuration, you can use following curl command, to get data from Provider connector

<details>
  <summary>Multipart Mixed request</summary>

	curl --location --request POST 'https://localhost:8084/proxy' \
	--header 'fizz: buzz' \
	--header 'Content-Type: text/plain' \
	--data-raw '{
	    "multipart": "mixed",
	    "Forward-To": "https://ecc-provider:8889/data",
	     "message": {
	      "@context" : {
	        "ids" : "https://w3id.org/idsa/core/"
	      },
	      "@type" : "ids:ArtifactRequestMessage",
	      "@id" : "https://w3id.org/idsa/autogen/artifactRequestMessage/76481a41-8117-4c79-bdf4-9903ef8f825a",
	      "ids:issued" : {
	        "@value" : "2020-11-25T16:43:27.051+01:00",
	        "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
	      },
	      "ids:modelVersion" : "4.0.0",
	      "ids:issuerConnector" : {
	        "@id" : "http://w3id.org/engrd/connector/"
	      },
	      "ids:requestedArtifact" : {
	       "@id" : "http://w3id.org/engrd/connector/artifact/1"
	      }
	    },
	    "payload" : {
	        "catalog.offers.0.resourceEndpoints.path":"/pet2"
	        }
	}'

</details>

*NOTE*: even that this curl command is exported from Postman, it is noticed several times, that when you try to import it back in Postman, there are some problems during this process, which results in omitting request body, and then request fill fail - cannot find body to create request.</br>
If this happens, please check body of the request in Postman, and if body is empty, simply copy everything enclosed between</br>
*--data-raw '* and *'*

For more details on request samples, please check following link [Backend DataApp Usage](https://github.com/Engineering-Research-and-Development/market4.0-data_app_test_BE/blob/master/README.md)

Be sure to use correct configuration/ports for sender and receiver Data App and Execution Core Container (check .env file).

Default values:

```
DataApp URL: https://localhost:8084/proxy 
"Forward-To": "https://ecc-porvider:8889/data",
```

For WSS flow:

```
DataApp URL: https://localhost:8084/proxy
"multipart": "wss",
"Forward-To": "wss://ecc-provider:8086/data",
"Forward-To-Internal": "wss://ecc-consumer:8887",
```

For IDSCPv2: 

Follow the REST endpoint or WS examples, put the server hostname/ip address in the Forward-To header (*wss/https://{RECEIVER_IP_ADDRESS/Hostname}:{WS_PUBLIC_PORT}*).
* **AISECv2** put the certificates (keyStore and trustStore) in the *cert* folder,edit related settings (*IDSCP2 AISEC DAPS settings* section in env file)


## Modifying configuration <a name="modifyconfiguration"></a>

If you wish to change some configuration parameters for TRUE Connector, it can be done by editing **.env** file.

### Enable hostname validation <a name="hosnamevalidation"></a>

To enable hostname validation, set following property to false:

```
DISABLE_SSL_VALIDATION=false
```
By changing this property to false and enabling hostname validation, you will have to have valid truststore, with public keys from external systems (towards which you are making https calls) imported into truststore.
Set truststore and its password by modifying following properties

```
TRUSTORE_NAME=truststore.p12
TRUSTORE_PASSWORD=password
```

### SSL/HTTPS <a name="ssl"></a>

If you have your own certificate that you wish to use for SSL configuration, you can apply it by changing:

```
#SSL settings
KEYSTORE_NAME={your_certificate}
KEY_PASSWORD={your_certificate_key}
KEYSTORE_PASSWORD={your_certificate_password}
ALIAS={your_certificate_alias}
```

If you want to use http and not https, simply disable following property

```
SERVER_SSL_ENABLED=false
```

### DAPS <a name="daps"></a>

DAPS related configuration can be achieved by modifying following:

```
DAPS_KEYSTORE_NAME=daps-keystore.p12
DAPS_KEYSTORE_PASSWORD=password
DAPS_KEYSTORE_ALIAS=1
```

Change values for keystore file name, password and alias that matches Your keystore file. Keystore can be in jks format or p12. If you have some other certificate format (like pem for example), you can convert it by executing following commands from terminal:

CONVERT PEM TO JKS OR p12

### Change message format - Multipart/Mixed, Multipart/Form, Http-headers <a name="messageformat"></a>

TRUE Connector can have different message formats between each component, and it can be modified by editing following properties:

```
# REST Communication type between ECC - mixed | form | http-header
MULTIPART_ECC=mixed

# mixed | form | http-header
PROVIDER_MULTIPART_EDGE=mixed

# mixed | form | http-header
CONSUMER_MULTIPART_EDGE=mixed

```
There is only one property to configure communication between ECC, since Consumer ECC and Provider ECC must have same configuration in order to be able to exchange and interprete message in correct way.

Message format between consumer DataApp and Consumer ECC (also called EDGE connection) can be independent from other configurations. Same is applied for EDGE connection between Provider ECC and Provider DataApp

### WebSocket configuration (WSS) <a name="wss"></a>

TRUE Connector can be configured to use WebSocket over HTTPS, for exchanging large files. WSS communication can be configured (independently of each other):

```
# Mandatory for WSS communication
MULTIPART_ECC=mixed
PROVIDER_MULTIPART_EDGE=mixed
CONSUMER_MULTIPART_EDGE=mixed
```

* between Consumer DataApp and Consumer ECC

```
# For EDGE communication between Consumer ECC and Consumer DataApp
CONSUMER_WS_EDGE=true

```
* between Consumer ECC and Provider ECC

```
# For WebSocket communication between ECC's
WS_ECC=true
```

* between Provider DataApp and Provider ECC

```
# For EDGE communication between Provider DataApp and Provider ECC
PROVIDER_WS_EDGE=true
# In case of WSS configuration
#PROVIDER_DATA_APP_ENDPOINT=https://be-dataapp-provider:9000/incoming-data-app/routerBodyBinary
```

To configure connector for WebSocket configuration, modify following:

*be-dataapp-resources\config.properties*

```
server.ssl.key-password=changeit
server.ssl.key-store=/cert/ssl-server.jks
```

With custom certificate or leave default one.
*Note:* if using custom certificate, same certificate must be used in ECC and DataApp, in order to be able to do handshake between ECC and DataApp. Check [SSL/HTTPS](#ssl)


On the following link, information regarding WebSocket Message Streamer implementation can be found here [WebSocket Message Streamer library](https://github.com/Engineering-Research-and-Development/market4.0-websocket_message_streamer).

### IDSCPv2 configuration <a name="idscpv2"></a>

TRUE Connector can exchange data using IDSCPv2 protocol, currently only between ECC's, not between DataApp and ECC. To do this, modify following properties:

```
# Enable WSS between ECC
WS_ECC=false

# Enable IDSCPv2 between ECC - set WS_ECC=false
IDSCP2=true

```

## Advanced configuration <a name="advancedconfiguration"></a>

If you did not find which property to change by editing **.env** file, there is an option, to modify property file directly, by editing one of the **application-docker.properties** files located in **ecc_resources_consumer** or **ecc_resources_provider** directories. There are comments present in property files, which describes impact and usage of some of the properties.


### Supported Identity Providers <a name="identityproviders"></a>

Since Identity provider is disabled by default, in order to enable it, set following property to true:

```
application.isEnabledDapsInteraction=true

```

The TRUE Connector is able to interact with the following Identity Providers:
For each of 3 supported identity providers, you need to obtain certificate, in order to be able to get JWToken from DAPS server. Certificate needs to be copied into *ecc_cert* folder and modify *DAPS_KEYSTORE_NAME*, *DAPS_KEYSTORE_PASSWORD* and
*DAPS_KEYSTORE_ALIAS* in *.env* file.

* **AISECv1** additional step: edit *application-docker.properties* and modify 
	*application.dapsVersion=v1* and 
	*application.dapsUrl* should point to DAPS v1 server
* **AISECv2** (default configuration)additional step: edit *application-docker.properties* and modify 
	*application.dapsVersion=v2* and 
	*application.dapsUrl* should point to DAPS v2 server
* **ORBITER** put the certificates (private and public key) in the *ecc_cert* folder, 
edit related settings (i.e., *application.daps.orbiter.privateKey*, *application.daps.orbiter.password*) and set the *application.dapsVersion* (in the *application-docker.properties*) to *orbiter*
*application.dapsUrl* should point to Orbiter IDP server



### Validate protocol <a name="validateprotocol"></a>

Forward-To protocol validation can be changed by editing *application-docker.properties* and modify **application.validateProtocol**. Default value is *false* and Forward-To URL will not be validated.
Forward-To URL can be set like http(https,wss)://example.com or just example.com and the protocol chosen (from application.properties) will be automatically set (it will be overwritten!)</br>
Example: http://example.com will be wss://example if you chose wss in the properties).

If validateProtocol is true, then Forward-To header must contain full URL, including protocol.</br>
Forward-To=localhost:8890/data - this one will fail, since it lack of information is it http or https</br>
Forward-To=https://localhost:8890/data - this one will work, since it has protocol information in URL.


## Clearing House <a name="clearinghouse"></a>

The TRUE Connector supports is able to communicate with the ENG Clearing House for registering transactions.

Since Clearing house is disabled by default, in order to enable it, set following property to true:

```
application.isEnabledClearingHouse=true

```


## Broker <a name="broker"></a>

Information on how TRUE Connector can interact with Broker, can be found on following link [Broker](BROKER.md)


## Usage Control <a name="usagecontrol"></a>
The TRUE Connector integrates the [Fraunhofer MyData Framework](https://www.mydata-control.de/) for implementing the Usage Control. Details about the PMP and PEP components can be found [here](doc/USAGE_CONTROL_RULES.md). 

Since Usage Control is disabled by default, in order to enable it, set following property to true:

```
application.isEnabledUsageControl=true

```

## Contract Negotiation - simple flow <a name="contractnegotiation"></a>

For simple contract negotiation flow, with ContractAgreement read from file, please check following link
[Data App Contract Negotiation](https://github.com/Engineering-Research-and-Development/market4.0-data_app_test_BE/blob/master/README.md#markdown-header-Contract-Negotiation-simple-flow) 


## License <a name="license"></a>
The TRUE Connector components are released following different licenses:

* **Execution Core Container**, open-source distributed under the license AGPLv3
* **BE Data APP**, open-source distributed under the license AGPLv3
* **UC Data APP**, TBC

