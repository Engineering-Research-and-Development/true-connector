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

```

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

Ctrl+C is used to exit from log inspection (you will be returned to the terminal).

To stop containers, execute following:

```
docker-compose down -v
```

At this point, you should be able to use TRUE Connector and send messages. How to send messages, check following link [Send multipart form request](#exchangedata):

## Endpoints <a name="endpoints"></a>
The TRUE Connector will use two protocols (http and https) as described by the Docker Compose File.
It will expose the following endpoints:

```
/proxy
```

to receive data incoming request, and based on received request, forward request to Execution Core Connector (the P endpoint in the above picture)

```
/data
```

to receive data (IDS Message) from a sender connector (the B endpoint in the above picture)
Furthermore, just for testing it will expose (http and https):

```
/about/version
```

returns business logic version .

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

DAPS related configuration can be achieved by modifying following (.env file):

```
DAPS_KEYSTORE_NAME=daps-keystore.p12
DAPS_KEYSTORE_PASSWORD=password
DAPS_KEYSTORE_ALIAS=1
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

Forward-To protocol validation can be changed by editing *application-docker.properties* and modify **application.validateProtocol**. Default value is *false* and Forward-To URL will not be validated.
Forward-To URL can be set like http(https,wss)://example.com or just example.com and the protocol chosen (from application-docker.properties) will be automatically set (it will be overwritten!)</br>
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
The TRUE Connector integrates the [Fraunhofer MyData Framework](https://www.mydata-control.de/) for implementing the Usage Control. Details about the PMP and PEP components can be found [here](doc/USAGE_CONTROL_RULES.md).

Since Usage Control is disabled by default, in order to enable it, set following property to true:

```
application.isEnabledUsageControl=true

```

## Contract Negotiation - simple flow <a name="contractnegotiation"></a>

Usage Control is disabled by default.
If you want to enable it (mandatory for contract negotiation), please check ["Enabling usage control"](#usagecontrol).

If mandatory, for other connectors, you can perform contract negotiation with other connector (not TRUE Connector) or with TRUE Connector. There is default contract offer that will be sent if ContractRequestMessage is received. It will allow consuming of resource in year 2021.

If you do not want to do contract negotiation, and you are using TRUE Connector "on both sides", there is "workaround", to upload Usage Control policy directly to Consumer Usage Control Data App. In order to achieve this, use following link:

```
http://localhost:9553/swagger-ui.html#/odrl-policy-controller
```
In POST request, upload policy from [here](https://github.com/Engineering-Research-and-Development/true-connector-uc_data_app/blob/master/src/main/resources/policy-examples/0.0.3/1%20restrict-access-interval.json).

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
		"@id" : "http://w3id.org/engrd/connector"
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
	  "@id" : "https://w3id.org/engrd/connector/",
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
			  "ids:assignee" : [ {
				"@id" : "https://assignee.com"
			  } ],
			  "ids:assigner" : [ {
				"@id" : "https://assigner.com"
			  } ],
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
				  "@value" : "2022-01-09T13:48:40Z",
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
				  "@value" : "2021-12-02T13:48:40Z",
				  "@type" : "http://www.w3.org/2001/XMLSchema#datetime"
				}
			  } ],
			  "ids:description" : [ ],
			  "ids:title" : [ ]
			} ],
			"ids:provider" : {
			  "@id" : "https://provider.com"
			},
			"ids:contractDate" : {
			  "@value" : "2021-12-09T13:48:41.493Z",
			  "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
			},
			"ids:consumer" : {
			  "@id" : "https://consumer.com"
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
	"requestedElement": "http://w3id.org/engrd/connector/artifact/1"
	}'

</details>

If everything goes well, you will get response with body containing "@type" : "ids:ContractAgreementMessage" and payload containing "@type": "ids:ContractAgreement", as shown in example response.

<details>
  <summary>Contract Request Message - Response example</summary>

	--NfiM38lAW4pGKxK4NRAqufpJFM40wz
	Content-Disposition: form-data; name="header"
	Content-Length: 1150
	Content-Type: application/ld+json

	{
	  "@context" : {
		"ids" : "https://w3id.org/idsa/core/",
		"idsc" : "https://w3id.org/idsa/code/"
	  },
	  "@type" : "ids:ContractAgreementMessage",
	  "@id" : "https://w3id.org/idsa/autogen/contractAgreementMessage/090de85d-455a-493f-b15c-1cab0d7df098",
	  "ids:securityToken" : {
		"@type" : "ids:DynamicAttributeToken",
		"@id" : "https://w3id.org/idsa/autogen/dynamicAttributeToken/dbbca5d5-2d75-464f-9311-6aee63e18299",
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
		"@value" : "2021-12-03T16:37:54.102Z",
		"@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
	  },
	  "ids:recipientConnector" : [ {
		"@id" : "http://w3id.org/engrd/connector"
	  } ],
	  "ids:recipientAgent" : [ ],
	  "ids:correlationMessage" : {
		"@id" : "https://w3id.org/idsa/autogen/contractRequestMessage/b780699f-9e79-4e31-812a-d957b0b5d645"
	  }
	}
	--NfiM38lAW4pGKxK4NRAqufpJFM40wz
	Content-Disposition: form-data; name="payload"
	Content-Length: 1244

	{
	   "@context": {
		  "ids":"https://w3id.org/idsa/core/",
		  "idsc" : "https://w3id.org/idsa/code/"
	   },
	  "@type": "ids:ContractAgreement",
	  "@id": "https://w3id.org/idsa/autogen/contract/restrict-access-interval",
	  "profile": "http://example.com/ids-profile",
	  "ids:provider": "ecc-provider",
	  "ids:consumer": "ecc-consumer",
	  "ids:permission": [{
		  "ids:target": {
			  "@id":"http://w3id.org/engrd/connector/artifact/1"
		   },
		  "ids:action": [{
			"@id":"idsc:USE"
		  }],
		  "ids:constraint": [{
			"@type":"ids:Constraint",
			"ids:leftOperand": { "@id": "idsc:POLICY_EVALUATION_TIME"},
			"ids:operator": { "@id": "idsc:TEMPORAL_EQUALS"},
			"ids:rightOperand": {
			 "@type": "ids:interval",
			 "@value": {
				 "ids:begin": {
				   "@value": "2021-06-15T00:00:00Z",
				   "@type": "xsd:datetimeStamp"
				},
				"ids:end": {
				   "@value": "2021-12-31T00:00:00Z",
				   "@type": "xsd:datetimeStamp"
				}
			 }
			},
			"ids:pipEndpoint": { "@id": "https//example.com/pip/policy_evaluation_time" }
		  }
	]
	  }]
	}
	--NfiM38lAW4pGKxK4NRAqufpJFM40wz--

</details>

### Contract Agreement request <a name="contract_agreement_request"></a>

**NOTE**: Payload part is taken as example. Be sure to replace with value you have recieved.
In the following step of negotiation, we create Contract Agreement Message: in Payload of new message we put (copy & paste) payload (ContractAgreement) obtained from previous response from ContractRequestMessage.\
**NOTE**: Be sure to check the end date. In current example it is valid until 2021-12-31.

<details>
  <summary>Multipart form - Contract Agreement request</summary>

	curl --location --request POST 'https://localhost:8084/proxy' \
	--header 'Content-Type: application/json' \
	--data-raw '{
		"multipart": "form",
		"Forward-To": "https://ecc-provider:8889/data",
		"messageType": "ContractAgreementMessage",
		"requestedArtifact": "http://w3id.org/engrd/connector/artifact/1",
		"payload" : {
			"@context": {
				"ids":"https://w3id.org/idsa/core/",
				"idsc" : "https://w3id.org/idsa/code/"
			},
			"@type": "ids:ContractAgreement",
			"@id": "https://w3id.org/idsa/autogen/contract/restrict-access-interval",
			"profile": "http://example.com/ids-profile",
			"ids:provider": "ecc-provider",
			"ids:consumer": "ecc-consumer",
			"ids:permission": [{
				"ids:target": {
					"@id":"http://w3id.org/engrd/connector/artifact/1"
				},
				"ids:action": [{
					"@id":"idsc:USE"
				}],
				"ids:constraint": [{
					"@type":"ids:Constraint",
					"ids:leftOperand": {
						"@id": "idsc:POLICY_EVALUATION_TIME"
					},
					"ids:operator": {
						"@id": "idsc:TEMPORAL_EQUALS"
					},
					"ids:rightOperand": {
						"@type": "ids:interval",
						"@value": {
							 "ids:begin": {
								"@value": "2021-06-15T00:00:00Z",
								"@type": "xsd:datetimeStamp"
							},
							"ids:end": {
								"@value": "2021-12-31T00:00:00Z",
								"@type": "xsd:datetimeStamp"
							}
						}
					},
					"ids:pipEndpoint": {
						"@id": "https//example.com/pip/policy_evaluation_time"
					}
				}]
			}]
		}
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

<details>
  <summary>Multipart Form - Artifact Request Message</summary>

	curl --location --request POST 'http://localhost:8084/proxy' \
	--header 'Content-Type: application/json' \
	--data-raw '{
	    "multipart": "form",
	    "Forward-To": "http://ecc-provider:8889/data",
	    "messageType":"ArtifactRequestMessage",
	    "requestedArtifact": "http://w3id.org/engrd/connector/artifact/1"
	}'

</details>

If you have done everything correctly, you should get response with requested artifact, like in our example.
Expected response is ArtifactResponseMessage, as header, and in payload - json document containing information about requested resource.

<details>
  <summary>Artifact Request Message - Example response</summary>

	--aDbue-EGZyC4BcMi99dnOgN5AEfBsGOQrcT
	Content-Disposition: form-data; name="header"
	Content-Length: 1148
	Content-Type: application/ld+json

	{
	  "@context" : {
		"ids" : "https://w3id.org/idsa/core/",
		"idsc" : "https://w3id.org/idsa/code/"
	  },
	  "@type" : "ids:ArtifactResponseMessage",
	  "@id" : "https://w3id.org/idsa/autogen/artifactResponseMessage/05f486c7-c1d3-4073-ae64-adef0de0257b",
	  "ids:securityToken" : {
		"@type" : "ids:DynamicAttributeToken",
		"@id" : "https://w3id.org/idsa/autogen/dynamicAttributeToken/be20ab22-9af0-4c4b-9179-bf5e84147f86",
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
		"@value" : "2021-12-03T16:41:31.515Z",
		"@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
	  },
	  "ids:recipientConnector" : [ {
		"@id" : "http://w3id.org/engrd/connector"
	  } ],
	  "ids:recipientAgent" : [ ],
	  "ids:correlationMessage" : {
		"@id" : "https://w3id.org/idsa/autogen/artifactRequestMessage/dacd7695-cf7c-43af-b80c-54931b803cfc"
	  }
	}
	--aDbue-EGZyC4BcMi99dnOgN5AEfBsGOQrcT
	Content-Disposition: form-data; name="payload"
	Content-Length: 160


	{"firstName":"John","lastName":"Doe","address":"591  Franklin Street, Pennsylvania","checksum":"ABC123 2021/12/03 17:41:31","dateOfBirth":"2021/12/03 17:41:31"}
	--aDbue-EGZyC4BcMi99dnOgN5AEfBsGOQrcT--

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
