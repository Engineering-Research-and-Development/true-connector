# Testbed 

For more information follow the link [Testbed](https://github.com/International-Data-Spaces-Association/IDS-testbed)

Clone or download this repo. Currently verified version of the Testbed is 1.0.

## Preconfigure

### Generate DAPS certificate using Omejdn DAPS

This step is not mandatory, since Testbed comes with some generated certificates which can be used.

If you want to create new certificate, please follow [instructions](https://github.com/International-Data-Spaces-Association/IDS-testbed/tree/master/CertificateAuthority) provided by Testbed, on how to achieve this.


### DAPS certificate

You can use certificate already provided in Testbed project, in following location - *IDS-testbed\CertificateAuthority\data\cert\*
We need to make some small adjustments, to generate valid p12 file. For this purpose, we need to copy *ReferenceTestbedCA.crt* file from ca folder (one level above) and execute following command:

```
openssl pkcs12 -export -out testbed3.p12 -inkey testbed3.key -in testbed3.crt -certfile ReferenceTestbedCA.crt
```
As Export password insert ***password***, and confirm it.


This will generate valid testbed3.p12 file. Copy this file to trueconnector\ecc_cert folder.

**Note:** If you using Linux OS, after coping file, inside trueconnector\ecc_cert folder execute next command:
``chmod 666 testbed3.p12``

**Remark:** in DAPS, only testbed1, testbed2 and testbed3 files are registered, so we will use same testbed3.p12 file for both consumer and provider.


### TrueConnector properties

Make sure that following properties are configured for Testbed environment:

**.env** 

```
### PROVIDER Configuration
PROVIDER_DAPS_KEYSTORE_NAME=testbed3.p12
PROVIDER_DAPS_KEYSTORE_PASSWORD=password
PROVIDER_DAPS_KEYSTORE_ALIAS=1

PROVIDER_MULTIPART_EDGE=form

CONSUMER_DAPS_KEYSTORE_NAME=testbed3.p12
CONSUMER_DAPS_KEYSTORE_PASSWORD=password
CONSUMER_DAPS_KEYSTORE_ALIAS=1
```

(for the moment, we will use same DAPS certificate for both Provider and Consumer)

**application.properties** for both consumer and provider

```
application.isEnabledDapsInteraction=true

#Omejdn 
application.dapsUrl=http://omejdn/auth/token
application.dapsJWKSUrl=http://omejdn/auth/jwks.json

application.encodeDecodePayload=true

application.isEnabledUsageControl=true
application.usageControlVersion=platoon

```

**dataApp application.properties**

```
application.encodePayload=true
```

### Enabling hostname validation

In order to enable this functionality, following changes are required:

**.env** file 

```
DISABLE_SSL_VALIDATION=false

TRUSTORE_NAME=truststoreEcc.jks
TRUSTORE_PASSWORD=allpassword

```

This will load certificates from truststore and when making https call towards target system, certificate will be validated against truststore, and if certificate is present and valid, call will be successful, otherwise you will get PKIX exception.

### Docker networking

Since we are running 2 separate docker containers, one for Testbed and other for TrueConnector, we must connect those 2 environments, so that they could communicate, and "see each other". For example, DAPS is mandatory service, for both environments and it is deployed in Testbed docker container, and by default, not reachable in TrueConnector.

In Testbed docker setup, there is network created, in docker-compose.yml.

```
networks:
  local:
    driver: bridge
```

This network needs to be added in TrueConnector docker compose, so that 2 ecosystems can communicate with each other.</b>
Modify TrueConnector docker-compose.yml file and add following at the end of the file:

```
networks:
  tc-network:
    external: true
    name: testbed_local

```

And also for ecc-consumer and ecc-provider service, add it to the network, by simply adding:

```
    networks:
      - tc-network
```

### Export TrueConnector certificate

Open *ssl-server.jks* file from TrueConnector/ecc_cert folder using KeyStore Explorer and export certificate (right click on entry name):

![Certificate_1](Export_TC_Certificate_1.jpg "Export TrueConnector Certificate")

and provide location where to save exported certificate. It will be needed in next step, to update DSC truststore.

![Certificate_2](Export_TC_Certificate_2.jpg "Export TrueConnector Certificate 2")

Or you can use already extracted *execution_core_container.cer* file from **ecc_cert** folder.

### Updating DSC truststore

Open DSC truststore file *truststore.p12* (IDS-testbed\DataspaceConnectorA\conf\ and IDS-testbed\DataspaceConnectorB\conf\) using KeyStore Explorer and import TrueConnector certificate, so that DSC can make https calls towards TrueConnector provider

![Truststore](Import_TC_Certificate.jpg "Import TrueConnector Certificate")

and provide alias *true-connector*

![Truststore Alias](Import_TC_Certificate_alias.jpg "Import TrueConnector Certificate alias")

This will be used when DSC makes https request towards ecc-provider, to check hostname with imported certificate.


## Configuration

## TrueConnector as consumer

Once both docker compose files are up and running, you can start postman, import Testbed postman connection  from Testbed project(TestbedPreconfiguration.postman_collection.json) and execute several requests (until Register connector), to setup DSC connector:

![DSC preconfiguration](DSC_preconfiguration.jpg "DSC preconfiguration")

This will create contract offer, resource and artifact into DSC connectora (provider)

There is Postman collection that can be used to perform contract negotiation with DataSpaceConnector and get artifact. For this purpose, you can use and import [following collection](./DSC%20communication.postman_collection.json) into Postman. You can execute whole collection in one go, or execute each request in ordering how they are listed.

Once imported, it should look like following:

![DSC Collection](DSC_Communication.jpg "DSC Collection")


## TrueConnector as provider

TrueConnector comes with predefined Self Description document, with one artifact and following contract offer. You can get more information by expecting the document itself on URL:

```
https://localhost:8090/

```

Artifact id is *http://w3id.org/engrd/connector/artifact/1*

Next to this value, we will also need following ones:

ids:TextResource - https://w3id.org/idsa/autogen/textResource/58898070-162b-4b62-8e7f-524d857bc6ca

ids:Permission - array of permissions from Self Description document

### Description Request Message - get Self Description from TrueConnctor Provider

From Testbed postman collection, this time we will use following:

![TC DSC Collection](TC_DSC_Collection.jpg "TC DSC Collection")

Open the request, and make modifications, like in the picture (modify recipient to be TrueConnector provider - *https://ecc-provider:8889/data*)

![TS Description Request](TS_DescriptionRequest.jpg "TS Description Request")

And fire the request. After successful response, you should get Description Request Message, with TrueConnector Self Description document in payload part.

To narrow search, you can enable 'elementId' and set value of the textResource

![TC TextResource](TC_TextResource.jpg "TC TextResource")

### Contract Negotiation with TrueConnector provider

This step DSC performs automatically, meaning that we do not need to send several requests like we did when TrueConnector was consumer. In order to do so, we need to prepare request, and modify following:

Request parameters:</br>
Modify all three fields to match TrueConnector as provider.

![TC ContractNegotiation 1](TC_ContractNegotiation_parameters.jpg "TC ContractNegotiation parameters")

Request body:</br>
Get whole **permission** from TrueConnector Self Description in body, replace one that is present in request and modify target element:

![TC_ContractNegotiation 1](TC_ContractNegotiation_body.jpg "TC ContractNegotiation body")


From:

```
"ids:target" : {
    "@id" : "http://w3id.org/engrd/connector/artifact/1"
  }
      
```

to:

```
"ids:target" : "http://w3id.org/engrd/connector/artifact/1"
          
```

After successful contract negotiation, response will look like following:

![TC_ContractNegotiation Response](TC_ContractNegotiation_response.jpg "TC ContractNegotiation Response")

Note the link marked with red, this is the agreement id that will be needed for next step.

### Request Artifact

If not replaced by postman, make sure that URL in the postman has correct value for 'Consumer agreement ID'

![TC Request Artifact](TC_ObtainData_datalink.jpg "TC Request Artifact")

### Obtain data

You can find required request for Dataspace Connector in following section:

![TC Obtain Data Request](TC_ObtainData_request.jpg "TC Obtain Data Request")

After executing request, response should look like in following picture:

![TC Obtain Data](TC_ObtainData.jpg "TC Obtain Data")

## Broker interaction

### Register connector to Metadata Broker

You can register consumer connector by executing following request:

```
curl --location --request POST 'https://localhost:8184/proxy' \
--header 'Authorization: Basic Y29ubmVjdG9yOnBhc3N3b3Jk' \
--header 'Content-Type: text/plain' \
--data-raw '{
    "multipart": "form",
    "Forward-To": "https://broker-reverseproxy/infrastructure",
    "messageType": "ConnectorUpdateMessage"
}'
```

If you want to register provider connector, then simply change port from 8184 to 8183.

Upon successful registration, you should receive MessageProcessedNotificationMessage.

### Query broker

Following request can be use to query Metadata Broker

```
curl --location --request POST 'https://localhost:8184/proxy' \
--header 'Content-Type: text/plain' \
--header 'Authorization: Basic Y29ubmVjdG9yOnBhc3N3b3Jk' \
--data-raw '{
    "multipart": "form",
    "Forward-To": "https://broker-reverseproxy/infrastructure",
    "messageType": "QueryMessage",
    "payload": "PREFIX ids: <https://w3id.org/idsa/core/> SELECT ?connectorUri WHERE { ?connectorUri a ids:BaseConnector . } "
}'
```

Upon successful registration, you should receive ResultMessage and in payload something like following:

```
Content-Disposition: form-data; name="payload"
Content-Length: 56

?connectorUri
<https://localhost/connectors/-1136570709>

```
## Broker Self Description after registering connector

```
curl --location --request POST 'https://localhost:8184/proxy' \
--header 'Content-Type: application/json' \
--header 'Authorization: Basic Y29ubmVjdG9yOnBhc3N3b3Jk' \
--data-raw '{
    "multipart": "form",
    "Forward-To": "https://broker-reverseproxy/infrastructure",
    "messageType": "DescriptionRequestMessage",
    "requestedElement":"https://localhost/connectors",
    "payload":""
}'

```

and as response, you should get something like following (payload part)

```

{
  "@graph" : [ {
    "@id" : "https://localhost/connectors/",
    "@type" : "ids:ConnectorCatalog",
    "listedConnector" : "https://localhost/connectors/-1136570709"
  }, {
    "@id" : "https://localhost/connectors/-1136570709",
    "@type" : "ids:BaseConnector",
    "sameAs" : "https://w3id.org/engrd/connector/consumer",
    "curator" : "http://consumer.curatorURI.com",
    "description" : "Data Consumer Connector description",
    "hasDefaultEndpoint" : "https://178.254.183.40:8091/",
    "inboundModelVersion" : "4.1.0",
    "maintainer" : "http://consumer.maintainerURI.com",
    "outboundModelVersion" : "4.1.0",
    "publicKey" : "https://w3id.org/idsa/autogen/publicKey/d32d6df9-3990-4500-bbd2-6ed32505f73d",
    "resourceCatalog" : "https://localhost/connectors/-1136570709/-661022256",
    "securityProfile" : "https://w3id.org/idsa/code/BASE_SECURITY_PROFILE",
    "title" : "Data Consumer Connector title"
  } ],
  
  ...
```


