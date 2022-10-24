# TRUE CONNECTOR
**TRUE** (**TRU**sted **E**ngineering) **Connector** for the IDS (International Data Space) ecosystem

The TRUE Connector is composed of three components:

* [Execution Core Container (ECC)](https://github.com/Engineering-Research-and-Development/market4.0-execution_core_container_business_logic), open-source project designed by ENG. It is in charge of the data exchange through the IDS ecosystem representing data using the IDS Information Model and interacting with an external Identity Provider. It is also able to communicate with an IDS Broker for registering and querying information.
* [Back-End (BE) Data Application](https://github.com/Engineering-Research-and-Development/market4.0-data_app_test_BE), open-source project designed by ENG. It represents a trivial data application for generating and consuming data on top of the ECC component.
* [Usage-Control (UC) Data Application](https://github.com/Engineering-Research-and-Development/true-connector-uc_data_app_platoon), a customized version of the Platoon base application for integrating Usage Control functionality. This version of Usage control application requires persistence layer, and it this setup, it is H2 in memory database, with file persistence, but if required, it can be changed with PostgreSQL database.

![TRUE Connector Architecture](doc/TRUE_Connector_Architecture.png?raw=true "TRUE Connector Architecture")


## Table of Contents

* [Introduction](#introduction)
  * [System requirements](#systemrequirements)
  * [Default configuration](#defaultconfiguration)
  * [Starting and stopping containers](#startstop)
* [REST API](#restapi)
* [Connector reachability](#reachability)
* [Connector Id](#connectorId)
* [How to Exchange Data](#exchangedata)
* [Modifying configuration](#modifyconfiguration)
  * [Enable hostname validation](#hosnamevalidation)
  * [SSL/HTTPS](#ssl)
  * [Change message format](#messageformat)
  * [WebSocket configuration (WSS)](#wss)
  * [IDSCPv2](#idscpv2)
* [Advanced configuration](#advancedconfiguration)
  * [Supported Identity Providers](#identityproviders)
  * [Convert keystorage files](#convert_keystorage)
  * [Validate protocol](#validateprotocol)
  * [Clearing House](#clearinghouse)
  * [Broker](#broker)
  * [Usage Control](#usagecontrol)
  * [MyData Usage Control](#mydata)
* [Contract Negotiation](#contractnegotiation)
  * [Get offered resource](#get_offered_resource)
  * [Description Request Message](#description_request_message)
  * [Contract Request Message](#contract_request_message)
  * [Contract Agreement request](#contract_agreement_request)
  * [Get offered resource after access is granted](#get_offered_resource_granted)
* [Self Description API](#selfdescription)
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
 
### System requirements <a name="systemrequirements"></a>

In order to run TrueConnector following minimal system requirements are needed:


### Default configuration <a name="defaultconfiguration"></a>

TRUE Connector comes pre-configured with following:

* Secure https communication between all components (dataApp - ECC, ECC-ECC, and ECC-dataApp), using self-signed certificate
* multipart form format of the message between all components
* DapsInteraction disabled
* Disabled Usage control
* Disabled Clearing House
* Disabled validate protocol in Forward-To header
* Disabled hostname validation

If you wish to change this configuration, please check chapter [Modifying configuration](#modifyconfiguration)

### Starting and stopping containers <a name="startstop"></a>

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

At this point, you should be able to use TRUE Connector and send messages. How to send messages, check following link [Send multipart form request](#exchangedata):


## REST API <a name="restapi"></a>

Detailed description of API endpoints provided by TrueConnector can be found in [link](doc/rest_api/REST_API.md)

## Connector reachability <a name="reachability"></a>

Once docker containers are up and running, you can use following links to verify connectors are up and running, except checking log output.

*  **https://{IP_ADDRESS}:{HTTP_PUBLIC_PORT}/about/version**

Keeping the provided docker-compose, for Data Provider URL will be:

*  **https://localhost:8090/about/version**

For Data Consumer, with provided docker-compose file:

*  **https://localhost:8091/about/version**

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

### Connector Id <a name="connectorId"></a>

In .env file, you can find 2 properties, one for Provider and one for Consumer, called

```
PROVIDER_ISSUER_CONNECTOR_URI=http://w3id.org/engrd/connector/provider

CONSUMER_ISSUER_CONNECTOR_URI=http://w3id.org/engrd/connector/consumer

```

Those 2 properties can be modified to "label" connector with proper Id. This Id plays important role in Contract Negotiation sequence, since those 2 values will be used when creating Contract Agreement and when enforcing policy. Also, they are used in Basic Data App, in proxy functionality, to create request and response messages, to set correct value for issuerConnector. 


## How to Exchange Data <a name="exchangedata"></a>

With default configuration, you can use following curl command, to get data from Provider connector

<details>
  <summary>Multipart Form request</summary>

	curl --location --request POST 'https://localhost:8084/proxy' \
	--header 'Content-Type: text/plain' \
	--data-raw '{
	    "multipart": "form",
	    "Forward-To": "https://ecc-provider:8889/data",
	    "messageType": "ArtifactRequestMessage" ,
	    "requestedArtifact": "http://w3id.org/engrd/connector/artifact/1" ,
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
"Forward-To": "https://ecc-provider:8889/data",
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
TRUSTORE_NAME=truststoreEcc.jks
TRUSTORE_PASSWORD=allpassword
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

Since Identity provider is disabled by default, in order to enable it, set following application.property to true:

```
application.isEnabledDapsInteraction=true

```

The TRUE Connector is able to interact with the following Identity Providers:
For each of 3 supported identity providers, you need to obtain certificate, in order to be able to get JWToken from DAPS server. Certificate needs to be copied into *ecc_cert* folder and modify *DAPS_KEYSTORE_NAME*, *DAPS_KEYSTORE_PASSWORD* and
*DAPS_KEYSTORE_ALIAS* in *.env* file, for both Provider and Consumer section..

* **AISECv2** (default configuration)additional step: edit *application-docker.properties* and modify
	*application.dapsVersion=v2* and
	*application.dapsUrl* should point to DAPS v2 server
* **ORBITER** put the certificates (private and public key) in the *ecc_cert* folder,
edit related settings (i.e., *application.daps.orbiter.privateKey*, *application.daps.orbiter.password*) and set the *application.dapsVersion* (in the *application-docker.properties*) to *orbiter*
*application.dapsUrl* should point to Orbiter IDP server

DAPS related configuration can be achieved by modifying following (.env file). Following snippet is just an example:

```
PROVIDER_DAPS_KEYSTORE_NAME=daps-keystore-provider.p12
PROVIDER_DAPS_KEYSTORE_PASSWORD=password
PROVIDER_DAPS_KEYSTORE_ALIAS=1
```

and/or

```
CONSUMER_DAPS_KEYSTORE_NAME=daps-keystore-consumer.p12
CONSUMER_DAPS_KEYSTORE_PASSWORD=password
CONSUMER_DAPS_KEYSTORE_ALIAS=1
```

### Convert keystorage files <a name="convert_keystorage"></a>

Change values for keystore file name, password and alias that matches Your keystore file. Keystore can be in jks format or p12. If you have some other certificate format (like pem for example), you can convert it by executing following commands from terminal:

You should have 2 files, cert.pem, containing public key

```
-----BEGIN CERTIFICATE-----
MIIDHzCCAgcCCQD0p/3nqCMT5zANBgkqhkiG9w0BAQ0FADBUMQswCQYDVQQGEwJF
...
ACsqRifEx7DKolsGyRM/zZWZZNkXNMCR1GfZv6yUNSVXQ5w=
-----END CERTIFICATE-----

```

and privkey.key, containing private key

```
-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCzDmSOphiul2hh
...
RmSOiiYKXvxW1Z2VU3uKNVU=
-----END PRIVATE KEY-----

```

You can use following command, to convert cert and key file to p12 keystorage file:

```
openssl pkcs12 -export -in cert.pem -inkey privkey.key -out certificate.p12 -name "alias"

```

Provide passwords when prompted.</br>
Change alias to desired value.

Once you have p12 file, you can use it as is in TRUEConnector, or you can convert it to jks with:

```
keytool -importkeystore -srckeystore certificate.p12 -srcstoretype pkcs12 -destkeystore cert.jks

```

TRUE Connector supports p12 format of certificate file, but if for some reason connector does not read file correct, you can try to convert it to jks format using provided command.

### Validate protocol <a name="validateprotocol"></a>

Forward-To protocol validation can be enabled by setting the property **application.enableProtocolValidation** to true. If you have this enabled please refer to the following step.

Forward-To protocol validation can be changed by editing *application-docker.properties* and modify **application.validateProtocol**. Default value is *false* and Forward-To URL will not be validated. Forward-To URL can be set like http(https,wss)://example.com or just example.com and the protocol chosen (from application-docker.properties) will be automatically set (it will be overwritten!)</br>
Example: http://example.com will be wss://example if you chose wss in the properties).

If validateProtocol is true, then Forward-To header must contain full URL, including protocol.</br>
Forward-To=localhost:8890/data - this one will fail, since it lack of information is it http or https</br>
Forward-To=https://localhost:8890/data - this one will work, since it has protocol information in URL.

### Clearing House <a name="clearinghouse"></a>

The TRUE Connector supports is able to communicate with the ENG Clearing House for registering transactions.

Since Clearing house is disabled by default, in order to enable it, set following property to true:

```
application.isEnabledClearingHouse=true

```

### Broker <a name="broker"></a>

Information on how TRUE Connector can interact with Broker, can be found on following [link](https://github.com/Engineering-Research-and-Development/true-connector-execution_core_container/blob/master/doc/BROKER.md)

### Usage Control <a name="usagecontrol"></a>
Details about the PMP and PEP components and how to switch to PostgeSQL from the default H2 in-memory database you can find [here](doc/PLATOON_USAGE_CONTROL.md).

Since Usage Control is disabled by default, in order to enable it, set following property to true:

```
application.isEnabledUsageControl=true

```

### MyData Usage Control <a name="mydata"></a>

The TRUE Connector integrates both the [Platoon Usage Control Data App](https://github.com/Engineering-Research-and-Development/true-connector-uc_data_app_platoon) and [MyData Usage Control Data App](https://github.com/Engineering-Research-and-Development/true-connector-uc_data_app) for enforcing the Usage Control. 
True Connector is by default configured to use Platoon Usage Control, in order to use MyData follow the instructions in the [document](doc/MYDATA_USAGE_CONTROL.md).

## Contract Negotiation - simple flow <a name="contractnegotiation"></a>

Usage Control is disabled by default.
If you want to enable it (mandatory for contract negotiation), please check ["Enabling usage control"](#usagecontrol).

If mandatory, for other connectors, you can perform contract negotiation with other connector (not TRUE Connector) or with TRUE Connector. There is default contract offer that will be sent if ContractRequestMessage is received. It will allow consuming of resource in year 2022.

If you do not want to do contract negotiation, and you are using TRUE Connector "on both sides", there is "workaround", to upload Usage Control policy directly to Consumer Usage Control Data App. In order to achieve this, use following link:

```
http://localhost:9553/platoontec/PlatoonDataUsage/1.0/swagger-ui/index.html?configUrl=/platoontec/PlatoonDataUsage/1.0/v3/api-docs/swagger-config
```
In POST request, upload policy from [here](doc/policy_examples/time_constraint.json).

Assuming you are running docker instance on local machine. If not, please update hostname to match your scenario.

### Get offered resource <a name="get_offered_resource"></a>

In order to get resource that TrueConnector offers, you need to send ArtifactRequestMessage to B-endpoint.

We can query the resource with ArtifactRequestMessage:

<details>
  <summary>Multipart form - Artifact Request Message</summary>

	curl --location --request POST 'https://localhost:8084/proxy' \
	--header 'Content-Type: application/json' \
	--data-raw '{
		"multipart": "form",
		"Forward-To": "https://ecc-provider:8889/data",
		"messageType":"ArtifactRequestMessage",
		"requestedArtifact": "http://w3id.org/engrd/connector/artifact/1"
	}'

</details>

If Usage Control is active (in Docker scenario), our access to the resource will be denied. \
If you recieve other response than RejectionMessage:\
	1) Check if Usage Control is enabled.\
	2) Check if there is an old policy existing in /policies folder. You should delete previously presisted *.policy files in this folder and restart Docker.

### Description Request Message <a name="description_request_message"></a>

Before start of negotiation process, Description Request Message is sent to identify the actors and potentialy deny access if Dynamic Attribute Token (DAT) is not valid.
Initially, Description Request Message is sent by consumer without payload.

<details>
  <summary>Multipart form - Description Request Message</summary>

	curl --location --request POST 'https://localhost:8084/proxy' \
	--header 'Content-Type: application/json' \
	--data-raw '{
		"multipart": "form",
		"Forward-To": "https://ecc-provider:8889/data",
		"messageType":"DescriptionRequestMessage"
	}'

</details>

If DAT is invalid, Provider sents RejectionMessage with optional reason.
However, if DAT is valid, SelfDescriptionResponse is being sent to Consumer with similar content:

<details>
  <summary>Description Request Message - Response example</summary>

	--dd8poS2Z0x4yMG0zN4LBBbNn6lKINE192Dpsz
	Content-Disposition: form-data; name="header"
	Content-Length: 1157
	Content-Type: application/ld+json

	{
	  "@context" : {
		"ids" : "https://w3id.org/idsa/core/",
		"idsc" : "https://w3id.org/idsa/code/"
	  },
	  "@type" : "ids:DescriptionResponseMessage",
	  "@id" : "https://w3id.org/idsa/autogen/descriptionResponseMessage/0d6796c9-b4ca-4314-9641-96731d29471d",
	  "ids:securityToken" : {
		"@type" : "ids:DynamicAttributeToken",
		"@id" : "https://w3id.org/idsa/autogen/dynamicAttributeToken/43f60b53-cba1-4aeb-b308-8979950d256f",
		"ids:tokenValue" : "DummyTokenValue",
		"ids:tokenFormat" : {
		  "@id" : "https://w3id.org/idsa/code/JWT"
		}
	  },
	  "ids:senderAgent" : {
		"@id" : "https://w3id.org/engrd/connector/provider"
	  },
	  "ids:issuerConnector" : {
		"@id" : "https://w3id.org/engrd/connector/provider"
	  },
	  "ids:modelVersion" : "4.1.0",
	  "ids:issued" : {
		"@value" : "2021-12-09T13:50:03.883Z",
		"@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
	  },
	  "ids:correlationMessage" : {
		"@id" : "https://w3id.org/idsa/autogen/descriptionRequestMessage/8405b08f-4c93-4082-b22c-a07ba4e74753"
	  },
	  "ids:recipientConnector" : [ {
		"@id" : "http://w3id.org/engrd/connector/consumer"
	  } ],
	  "ids:recipientAgent" : [ ]
	}
	--dd8poS2Z0x4yMG0zN4LBBbNn6lKINE192Dpsz
	Content-Disposition: form-data; name="payload"
	Content-Length: 6068

	{
	  "@context" : {
		"ids" : "https://w3id.org/idsa/core/",
		"idsc" : "https://w3id.org/idsa/code/"
	  },
	  "@type" : "ids:BaseConnector",
	  "@id" : "https://w3id.org/engrd/connector/provider",
	  "ids:resourceCatalog" : [ {
		"@type" : "ids:ResourceCatalog",
		"@id" : "https://w3id.org/idsa/autogen/resourceCatalog/ba0987f6-f86e-4c9b-a6b1-020b3babf285",
		"ids:offeredResource" : [ {
		  "@type" : "ids:TextResource",
		  "@id" : "https://w3id.org/idsa/autogen/textResource/b8a9b5ae-2348-4b5d-b089-2dbeed833d52",
		  "ids:language" : [ {
			"@id" : "https://w3id.org/idsa/code/EN"
		  }, {
			"@id" : "https://w3id.org/idsa/code/IT"
		  } ],
		  "ids:version" : "1.0.0",
		  "ids:resourcePart" : [ ],
		  "ids:resourceEndpoint" : [ ],
		  "ids:contractOffer" : [ {
			"@type" : "ids:ContractOffer",
			"@id" : "https://w3id.org/idsa/autogen/contractOffer/0ae8d88e-0fc2-4065-b2f7-f53e3691114a",
			"ids:permission" : [ {
			  "@type" : "ids:Permission",
			  "@id" : "https://w3id.org/idsa/autogen/permission/d1fc81b0-6a4c-463f-a6f0-3d585b0cc2e2",
			  "ids:target" : {
				"@id" : "http://w3id.org/engrd/connector/artifact/1"
			  },
			  "ids:action" : [ {
				"@id" : "https://w3id.org/idsa/code/USE"
			  } ],
			  "ids:preDuty" : [ ],
			  "ids:postDuty" : [ ],
			  "ids:constraint" : [ {
				"@type" : "ids:Constraint",
				"@id" : "https://w3id.org/idsa/autogen/constraint/396733e0-7977-411a-8599-e96baecc5943",
				"ids:leftOperand" : {
				  "@id" : "https://w3id.org/idsa/code/POLICY_EVALUATION_TIME"
				},
				"ids:operator" : {
				  "@id" : "https://w3id.org/idsa/code/BEFORE"
				},
				"ids:rightOperand" : {
				  "@value" : "2022-12-31T13:48:40Z",
				  "@type" : "http://www.w3.org/2001/XMLSchema#datetime"
				}
			  }, {
				"@type" : "ids:Constraint",
				"@id" : "https://w3id.org/idsa/autogen/constraint/7d544cd2-27b2-4119-b12a-19fc0ec924ce",
				"ids:leftOperand" : {
				  "@id" : "https://w3id.org/idsa/code/POLICY_EVALUATION_TIME"
				},
				"ids:operator" : {
				  "@id" : "https://w3id.org/idsa/code/AFTER"
				},
				"ids:rightOperand" : {
				  "@value" : "2022-01-01T13:48:40Z",
				  "@type" : "http://www.w3.org/2001/XMLSchema#datetime"
				}
			  } ],
			  "ids:description" : [ ],
			  "ids:title" : [ ]
			} ],
			"ids:provider" : {
			  "@id" : "https://w3id.org/engrd/connector/provider"
			},
			"ids:contractDate" : {
			  "@value" : "2022-06-27T13:48:41.493Z",
			  "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
			},
			"ids:contractStart" : {
           "@value" : "2022-06-27T09:42:41.996Z",
           "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
          },
			"ids:prohibition" : [ ],
			"ids:obligation" : [ ]
		  } ],
		  "ids:paymentModality" : [ ],
		  "ids:sample" : [ ],
		  "ids:contentPart" : [ ],
		  "ids:representation" : [ {
			"@type" : "ids:TextRepresentation",
			"@id" : "https://w3id.org/idsa/autogen/textRepresentation/2d00b3ae-c276-4ba5-932f-35aabcdf3dd8",
			"ids:instance" : [ {
			  "@type" : "ids:Artifact",
			  "@id" : "http://w3id.org/engrd/connector/artifact/1",
			  "ids:creationDate" : {
				"@value" : "2021-12-09T13:48:39.458Z",
				"@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
			  }
			} ],
			"ids:language" : {
			  "@id" : "https://w3id.org/idsa/code/EN"
			},
			"ids:created" : {
			  "@value" : "2021-12-09T13:48:41.871Z",
			  "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
			}
		  } ],
		  "ids:defaultRepresentation" : [ ],
		  "ids:theme" : [ ],
		  "ids:keyword" : [ {
			"@value" : "Engineering Ingegneria Informatica SpA",
			"@type" : "http://www.w3.org/2001/XMLSchema#string"
		  }, {
			"@value" : "TRUEConnector",
			"@type" : "http://www.w3.org/2001/XMLSchema#string"
		  } ],
		  "ids:temporalCoverage" : [ ],
		  "ids:spatialCoverage" : [ ],
		  "ids:modified" : {
			"@value" : "2021-12-09T13:48:40.964Z",
			"@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
		  },
		  "ids:description" : [ {
			"@value" : "Default resource description",
			"@type" : "http://www.w3.org/2001/XMLSchema#string"
		  } ],
		  "ids:title" : [ {
			"@value" : "Default resource",
			"@type" : "http://www.w3.org/2001/XMLSchema#string"
		  } ],
		  "ids:created" : {
			"@value" : "2021-12-09T13:48:40.964Z",
			"@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
		  },
		  "ids:contentType" : {
			"@id" : "https://w3id.org/idsa/code/SCHEMA_DEFINITION"
		  }
		} ],
		"ids:requestedResource" : [ ]
	  } ],
	  "ids:description" : [ {
		"@value" : "Data Provider Connector description",
		"@type" : "http://www.w3.org/2001/XMLSchema#string"
	  } ],
	  "ids:title" : [ {
		"@value" : "Data Provider Connector title",
		"@type" : "http://www.w3.org/2001/XMLSchema#string"
	  } ],
	  "ids:maintainer" : {
		"@id" : "http://provider.maintainerURI.com"
	  },
	  "ids:curator" : {
		"@id" : "http://provider.curatorURI.com"
	  },
	  "ids:inboundModelVersion" : [ "4.1.0" ],
	  "ids:outboundModelVersion" : "4.1.0",
	  "ids:hasEndpoint" : [ ],
	  "ids:hasDefaultEndpoint" : {
		"@type" : "ids:ConnectorEndpoint",
		"@id" : "https://178.148.148.139:8090/",
		"ids:accessURL" : {
		  "@id" : "https://178.148.148.139:8090/"
		},
		"ids:endpointInformation" : [ ],
		"ids:endpointDocumentation" : [ ]
	  },
	  "ids:extendedGuarantee" : [ ],
	  "ids:hasAgent" : [ ],
	  "ids:securityProfile" : {
		"@id" : "https://w3id.org/idsa/code/BASE_SECURITY_PROFILE"
	  }
	}
	--dd8poS2Z0x4yMG0zN4LBBbNn6lKINE192Dpsz--

</details>

If the incoming message is assumed trustworthy, the Provider answers with an IDS SelfDescriptionResponse. 
During the establishment phase of the negotiation, this message contains the currently valid SelfDescription of Provider in JSON-LD, including its provided IDS Resources and respective ContractOffers. 
Note that the connector is not obliged to provide ContractOffers for any/all resources but can also only announce their existence. 
The usage conditions might be sensitive too and do not need to be supplied. 
However, the provisioning of ContractOffers eases their usage and therefore should be in the interest of a Data Provider.

### Contract Request Message <a name="contract_request_message"></a>

Contract Request Message is initial message sent in Contract Negotiation flow. It can contain requestedElement, if we know what artifact we are requesting, or without it, if we need to get whole self description document, and then analyze it and get element we are looking for.

<details>
  <summary>Multipart form - Contract Request Message</summary>

	curl --location --request POST 'https://localhost:8084/proxy' \
	--header 'Content-Type: application/json' \
	--data-raw '{
	"multipart": "form",
	"Forward-To": "https://ecc-provider:8889/data",
	"messageType": "ContractRequestMessage",
	"requestedElement": "http://w3id.org/engrd/connector/artifact/1",
	"payload" : xxxxxx
	}'

</details>

For payload part you need to pass Contract Request from prevoius request or you can use following snippet, but be sure to modify following fields:
Permission - @id and target

<details>
  <summary>Contract Request Payload part</summary>

	{
		"@context": {
			"ids": "https://w3id.org/idsa/core/",
			"idsc": "https://w3id.org/idsa/code/"
		},
		"@type": "ids:ContractRequest",
		"@id": "https://w3id.org/idsa/autogen/contractRequest/46863e9c-e7ce-4041-959c-11b317a10c5c",
		"ids:permission": [
			{
				"@type": "ids:Permission",
				"@id": "https://w3id.org/idsa/autogen/permission/57c1728b-788d-4b80-ae1d-02a7d46eb1a0",
				"ids:target": {
					"@id": "http://w3id.org/engrd/connector/artifact/1"
				},
				"ids:assignee": [],
				"ids:assigner": [],
				"ids:action": [
					{
						"@id": "https://w3id.org/idsa/code/USE"
					}
				],
				"ids:preDuty": [],
				"ids:postDuty": [],
				"ids:constraint": [
					{
						"@type": "ids:Constraint",
						"@id": "https://w3id.org/idsa/autogen/constraint/07f7dd8b-0b47-46e9-8d25-7205ea243de9",
						"ids:leftOperand": {
							"@id": "https://w3id.org/idsa/code/POLICY_EVALUATION_TIME"
						},
						"ids:operator": {
							"@id": "https://w3id.org/idsa/code/AFTER"
						},
						"ids:rightOperand": {
							"@value": "2022-06-20T09:43:49Z",
							"@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
						},
						"ids:pipEndpoint": {
							"@id": "http://pip.endpoint.after"
						}
					},
					{
						"@type": "ids:Constraint",
						"@id": "https://w3id.org/idsa/autogen/constraint/5832a389-9af1-4e2f-9ab4-038ac5db0091",
						"ids:leftOperand": {
							"@id": "https://w3id.org/idsa/code/POLICY_EVALUATION_TIME"
						},
						"ids:operator": {
							"@id": "https://w3id.org/idsa/code/BEFORE"
						},
						"ids:rightOperand": {
							"@value": "2022-07-27T09:43:49Z",
							"@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
						},
						"ids:pipEndpoint": {
							"@id": "http://pip.endpoint.before"
						}
					}
				],
				"ids:description": [],
				"ids:title": []
			}
		],
		"ids:provider": {
			"@id": "http://w3id.org/engrd/connector/provider"
		},
		"ids:obligation": [],
		"ids:prohibition": [],
		"ids:consumer": {
			"@id": "http://w3id.org/engrd/connector/consumer"
		}
	}

</details>


If everything goes well, you will get response with body containing "@type" : "ids:ContractAgreementMessage" and payload containing "@type": "ids:ContractAgreement", as shown in example response.

<details>
  <summary>Contract Request Message - Response example</summary>

	--P4P0K6voLPRtGGaDtazTYLsuN7E7OXJ
	Content-Disposition: form-data; name="header"
	Content-Length: 2599
	Content-Type: application/ld+json
	
	{
	  "@context" : {
	    "ids" : "https://w3id.org/idsa/core/",
	    "idsc" : "https://w3id.org/idsa/code/"
	  },
	  "@type" : "ids:ContractAgreementMessage",
	  "@id" : "https://w3id.org/idsa/autogen/contractAgreementMessage/c669ffe6-7716-4c43-8930-fa4ac5b9abde",
	  "ids:issuerConnector" : {
	    "@id" : "http://w3id.org/engrd/connector/provider"
	  },
	  "ids:senderAgent" : {
	    "@id" : "http://w3id.org/engrd/connector/provider"
	  },
	  "ids:securityToken" : {
	    "@type" : "ids:DynamicAttributeToken",
	    "@id" : "https://w3id.org/idsa/autogen/dynamicAttributeToken/ee2b22ee-31c3-433b-8ed6-3c53c0d8d9db",
	    "ids:tokenValue" : "DUMMY_TOKEN_VALUE",
	    "ids:tokenFormat" : {
	      "@id" : "https://w3id.org/idsa/code/JWT"
	    }
	  },
	  "ids:modelVersion" : "4.1.0",
	  "ids:issued" : {
	    "@value" : "2022-06-27T10:09:40.985Z",
	    "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
	  },
	  "ids:correlationMessage" : {
	    "@id" : "https://w3id.org/idsa/autogen/contractRequestMessage/f9bd01c6-dd10-4cd5-9c1f-7854bcb06ef5"
	  },
	  "ids:recipientConnector" : [ {
	    "@id" : "http://w3id.org/engrd/connector/consumer"
	  } ],
	  "ids:recipientAgent" : [ ]
	}
	--P4P0K6voLPRtGGaDtazTYLsuN7E7OXJ
	Content-Disposition: form-data; name="payload"
	Content-Length: 2351
	
	{
	  "@context" : {
	    "ids" : "https://w3id.org/idsa/core/",
	    "idsc" : "https://w3id.org/idsa/code/"
	  },
	  "@type" : "ids:ContractAgreement",
	  "@id" : "https://w3id.org/idsa/autogen/contractAgreement/7dacb032-ed43-4492-b76f-ff637fb2d417",
	  "ids:permission" : [ {
	    "@type" : "ids:Permission",
	    "@id" : "https://w3id.org/idsa/autogen/permission/57c1728b-788d-4b80-ae1d-02a7d46eb1a0",
	    "ids:target" : {
	      "@id" : "http://w3id.org/engrd/connector/artifact/1"
	    },
	    "ids:assignee" : [ ],
	    "ids:assigner" : [ ],
	    "ids:action" : [ {
	      "@id" : "https://w3id.org/idsa/code/USE"
	    } ],
	    "ids:preDuty" : [ ],
	    "ids:postDuty" : [ ],
	    "ids:constraint" : [ {
	      "@type" : "ids:Constraint",
	      "@id" : "https://w3id.org/idsa/autogen/constraint/07f7dd8b-0b47-46e9-8d25-7205ea243de9",
	      "ids:leftOperand" : {
	        "@id" : "https://w3id.org/idsa/code/POLICY_EVALUATION_TIME"
	      },
	      "ids:operator" : {
	        "@id" : "https://w3id.org/idsa/code/AFTER"
	      },
	      "ids:rightOperand" : {
	        "@value" : "2022-06-20T09:43:49Z",
	        "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
	      },
	      "ids:pipEndpoint" : {
	        "@id" : "http://pip.endpoint.after"
	      }
	    }, {
	      "@type" : "ids:Constraint",
	      "@id" : "https://w3id.org/idsa/autogen/constraint/5832a389-9af1-4e2f-9ab4-038ac5db0091",
	      "ids:leftOperand" : {
	        "@id" : "https://w3id.org/idsa/code/POLICY_EVALUATION_TIME"
	      },
	      "ids:operator" : {
	        "@id" : "https://w3id.org/idsa/code/BEFORE"
	      },
	      "ids:rightOperand" : {
	        "@value" : "2022-07-27T09:43:49Z",
	        "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
	      },
	      "ids:pipEndpoint" : {
	        "@id" : "http://pip.endpoint.before"
	      }
	    } ],
	    "ids:description" : [ ],
	    "ids:title" : [ ]
	  } ],
	  "ids:provider" : {
	    "@id" : "http://w3id.org/engrd/connector/provider"
	  },
	  "ids:contractStart" : {
	    "@value" : "2022-06-27T09:42:41.996Z",
	    "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
	  },
	  "ids:contractDate" : {
	    "@value" : "2022-06-27T09:43:49.320Z",
	    "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
	  },
	  "ids:consumer" : {
	    "@id" : "http://w3id.org/engrd/connector/consumer"
	  },
	  "ids:prohibition" : [ ],
	  "ids:obligation" : [ ]
	}
	--P4P0K6voLPRtGGaDtazTYLsuN7E7OXJ--

</details>

### Contract Agreement request <a name="contract_agreement_request"></a>

**NOTE**: Payload part must be replaced with value you have received from previous response.
**NOTE**: Be sure to check the end date. 

<details>
  <summary>Multipart form - Contract Agreement request</summary>

	curl --location --request POST 'https://localhost:8084/proxy' \
	--header 'Content-Type: application/json' \
	--data-raw '{
		"multipart": "form",
		"Forward-To": "https://ecc-provider:8889/data",
		"messageType": "ContractAgreementMessage",
		"requestedArtifact": "http://w3id.org/engrd/connector/artifact/1",
		"payload" : xxxxxx
	}'

</details>

When following request is sent, response will be MessageProcessedNotificationMessage, without payload. This meands that contracts have exchanged and have been uploaded to Usage Control DataApp.\
You can also check the Usage Control logs that the policy has been updated.

<details>
  <summary>Contract Request Message - Response example</summary>

	--folW-L7KK2Sr0wN8b-ayPRgRB3QIh6-NC
	Content-Disposition: form-data; name="header"
	Content-Length: 1174
	Content-Type: application/ld+json

	{
	  "@context" : {
		"ids" : "https://w3id.org/idsa/core/",
		"idsc" : "https://w3id.org/idsa/code/"
	  },
	  "@type" : "ids:MessageProcessedNotificationMessage",
	  "@id" : "https://w3id.org/idsa/autogen/messageProcessedNotificationMessage/0fdd95e5-5c40-445c-8a51-96a618efa4a9",
	  "ids:securityToken" : {
		"@type" : "ids:DynamicAttributeToken",
		"@id" : "https://w3id.org/idsa/autogen/dynamicAttributeToken/277438fb-995c-43b0-96c5-84051b4c8150",
		"ids:tokenValue" : "DummyTokenValue",
		"ids:tokenFormat" : {
		  "@id" : "https://w3id.org/idsa/code/JWT"
		}
	  },
	  "ids:issuerConnector" : {
		"@id" : "https://w3id.org/engrd/connector/provider"
	  },
	  "ids:senderAgent" : {
		"@id" : "https://w3id.org/engrd/connector/provider"
	  },
	  "ids:modelVersion" : "4.1.0",
	  "ids:issued" : {
		"@value" : "2021-12-03T16:40:27.269Z",
		"@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
	  },
	  "ids:recipientConnector" : [ {
		"@id" : "http://w3id.org/engrd/connector"
	  } ],
	  "ids:recipientAgent" : [ ],
	  "ids:correlationMessage" : {
		"@id" : "https://w3id.org/idsa/autogen/contractAgreementMessage/501a66cb-3f63-46f6-be43-61cbde077c8a"
	  }
	}
	--folW-L7KK2Sr0wN8b-ayPRgRB3QIh6-NC--

</details>

### Get offered resource after access is granted <a name="get_offered_resource_granted"></a>

When you have finished negotiation, you can query for resource again to see if we get artifact data.

**NOTE**: Be sure to replace value for transferContract with correct value - it should be contractAgreement id. You can get it from the step Contract Agreement request, the one that is set in payload. (like following: https://w3id.org/idsa/autogen/contractAgreement/7dacb032-ed43-4492-b76f-ff637fb2d417). This value is important, since it it will be used in contract negotiation, to validate against that contract agreement, if consumer can consume artifact.


<details>
  <summary>Multipart Form - Artifact Request Message</summary>

	curl --location --request POST 'http://localhost:8084/proxy' \
	--header 'Content-Type: application/json' \
	--data-raw '{
	    "multipart": "form",
	    "Forward-To": "http://ecc-provider:8889/data",
	    "messageType":"ArtifactRequestMessage",
	    "requestedArtifact": "http://w3id.org/engrd/connector/artifact/1",
	    "transferContract" : "xxxxxx"
	}'

</details>

If you have done everything correctly, you should get response with requested artifact, like in our example.
Expected response is ArtifactResponseMessage, as header, and in payload - json document containing information about requested resource.

<details>
  <summary>Artifact Request Message - Example response</summary>

	--Jg43iZd4C8H3mA96jSHQsSVP_HdzROIqTkFz
	Content-Disposition: form-data; name="header"
	Content-Length: 2730
	Content-Type: application/ld+json
	
	{
	  "@context" : {
	    "ids" : "https://w3id.org/idsa/core/",
	    "idsc" : "https://w3id.org/idsa/code/"
	  },
	  "@type" : "ids:ArtifactResponseMessage",
	  "@id" : "https://w3id.org/idsa/autogen/artifactResponseMessage/d3f76bea-85ea-4e44-bf71-57bdbe8f6234",
	  "ids:issuerConnector" : {
	    "@id" : "http://w3id.org/engrd/connector/provider"
	  },
	  "ids:senderAgent" : {
	    "@id" : "http://w3id.org/engrd/connector/provider"
	  },
	  "ids:securityToken" : {
	    "@type" : "ids:DynamicAttributeToken",
	    "@id" : "https://w3id.org/idsa/autogen/dynamicAttributeToken/e9d90738-7ecf-46a9-83f5-ad5e3752a74b",
	    "ids:tokenValue" : "DummyTokenValue",
	    "ids:tokenFormat" : {
	      "@id" : "https://w3id.org/idsa/code/JWT"
	    }
	  },
	  "ids:modelVersion" : "4.1.0",
	  "ids:issued" : {
	    "@value" : "2022-06-27T10:17:25.025Z",
	    "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
	  },
	  "ids:correlationMessage" : {
	    "@id" : "https://w3id.org/idsa/autogen/artifactRequestMessage/e62e0c02-319b-4aa8-8685-1be59276e596"
	  },
	  "ids:recipientConnector" : [ {
	    "@id" : "http://w3id.org/engrd/connector/consumer"
	  } ],
	  "ids:recipientAgent" : [ ],
	  "ids:transferContract" : {
	    "@id" : "https://w3id.org/idsa/autogen/contractAgreement/7dacb032-ed43-4492-b76f-ff637fb2d417"
	  }
	}
	--Jg43iZd4C8H3mA96jSHQsSVP_HdzROIqTkFz
	Content-Disposition: form-data; name="payload"
	Content-Length: 160
	
	{"firstName":"John","lastName":"Doe","address":"591  Franklin Street, Pennsylvania","checksum":"ABC123 2022/06/27 12:17:25","dateOfBirth":"2022/06/27 12:17:25"}
	--Jg43iZd4C8H3mA96jSHQsSVP_HdzROIqTkFz--

</details>

The appeariance of "John Doe" signifies the successful exchange with this contract.

## Self Description API <a name="selfdescription"></a>

To manage your Self Description Document please check following [link](https://github.com/Engineering-Research-and-Development/true-connector-execution_core_container/blob/master/doc/SELF_DESCRIPTION.md)

You can copy existing valid self-description.json document to following location
**/ecc_resources_consumer** or **/ecc_resources_provider** folders, for consumer or provider</br>

There is also possibility to change location of self_description.json document, which can be done by changing following property:

```
application.selfdescription.filelocation=

```
Be careful when changing this property, since it needs to be reflected inside docker container.

When connector is starting up, it will look for file named *self_description.json* file, and if such file exists, it will load Self Description document from file, otherwise it will create default Self Description document, from properties:

```
application.selfdescription.description=
application.selfdescription.title=
application.selfdescription.curator=
application.selfdescription.maintainer=
```

With single offered resource, artifact and contract offer.

## License <a name="license"></a>
The TRUE Connector components are released following different licenses:

* **Execution Core Container**, open-source distributed under the license AGPLv3
* **BE Data APP**, open-source distributed under the license AGPLv3
* **UC Data APP**, TBC
