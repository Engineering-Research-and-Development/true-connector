# PlugFest Q3 2021 - TrueConnector readme


## Introduction

TrueConnector B-endpoint for handling IDS Messages is reachable at following address:

```
https://217.172.12.215:8889/data

```

Configuration used for communication is xxxx.

SelfDescritpion document can be reached at:

```
https://217.172.12.215:8090/

```

Following SelfDescription document offers one resource, with id - *http://w3id.org/engrd/connector/artifact/1*

Usage control is enabled, and provider will wrap up payload with meta data needed for usage control enforcement.

DAPS is enabled, and configured Identity Provider is AISEC DAPS v2.

InfoModel compatibility is 4.0.0 and 4.1.1

## Setup

Clone this repository and make changes described in [README.md](README.md) file.

Some of things that needs to be checked/verified are:

 * all modifications are done by editing .env file, used by docker
 * provide valid DAPS certificate file, copy it to ecc_cert folder and update corresponding properties
 
```
 DAPS_KEYSTORE_NAME={provided_daps_certificate}
 DAPS_KEYSTORE_PASSWORD={daps_certificate_password}
 DAPS_KEYSTORE_ALIAS={daps_certificate_alias}
 
```
 
If you have trustsore configured, you can configure it via following properties:

```
 TRUSTORE_NAME={truststore_file}
 TRUSTORE_PASSWORD={trustire_password}

```

And configure connector to use hostname validation by setting following property:
*DISABLE_SSL_VALIDATION=false*

If you do not want to use hostname validation, leave this property to false and delete value for TRUSTORE_NAME, like:

```
TRUSTORE_NAME=
```

## TrueConnector as Data Provider

TRUE Connector will be deployed in our environment, with public accessible address as Data Provider.

```
https://217.172.12.215:8889/data

```


## TrueConnector as Data Consumer 

To start TRUE Connector as consumer, simpy execute following command

```
docker-compose -f docker-compose-consumer.yml up

```

into the folder where downloaded project is extracted.</br>
*Note*: for Linux OS you might need to have administrative rights.

In order to send message, you can read following chapters:


### Proxy endpoint

Our simple/sample DataApp exposes "proxy" endpoint. This endpoint, available at *https://localhost:8084/proxy* (Consumer DataApp) wraps up logic for creating IDS Message and sending request to Consumer Execution Core Container. Currently supported messages are:

| IDS Message |  Expected result message |
| ------- |   -------- |
| ArtifactRequestMessage | ArtifactResponseMessage |
| ContractRequestMessage |  ContractAgreementMessage |
| ContractAgreementMessage | ContractAgreementMessage |
| DescriptionRequestMessage |  DescriptionResponseMessage |

Example for one of message types looks like:

```
	curl --location --request POST 'https://localhost:8084/proxy' \
	--header 'Content-Type: application/json' \
	--data-raw '{
	    "multipart": "form",
	    "Forward-To": "https://217.172.12.215:8889/data",
	    "messageType":"ArtifactRequestMessage",
	    "requestedArtifact": "http://w3id.org/engrd/connector/artifact/{id}"   
	}'
	
```

### Contract negotiation

If mandatory, for other connectors, you can perform contract negotiation with other connector (not TRUE Connector) or with TRUE Connector. There is default contract offer that will be sent if ContractRequestMessage is received. It will allow consuming of resource in year 2021.

If you do not want to do contract negotiation, and you are using TRUE Connector "on both sides", there is "workaround", to upload Usage Control policy directly to Consumer Usage Control Data App. In order to achieve this, use following link:

```
http://localhost:9553/swagger-ui.html#/odrl-policy-controller
```

Assuming you are running docker instance on local machine. If not, please update hostname to match your scenario.

In POST request, upload policy from [here](https://github.com/Engineering-Research-and-Development/true-connector-uc_data_app/blob/master/src/main/resources/policy-examples/0.0.3/1%20restrict-access-interval.json)

<details>
  <summary>Multipart form - Contract Request Message</summary>

	curl --location --request POST 'https://localhost:8084/proxy' \
	--header 'Content-Type: application/json' \
	--data-raw '{
	"multipart": "form",
	"Forward-To": "https://217.172.12.215:8889/data",
	"messageType": "ContractRequestMessage",
	"requestedArtifact": "http://w3id.org/engrd/connector/artifact/{id}"
	}'

</details>

### Contract Agreement request

Example of Contract Agreement Message:
Payload should be ContractAgreement, obtained from previous response (ContractRequestMessage)

<details>
  <summary>Multipart form - Contract Agreement request</summary>

	curl --location --request POST 'https://localhost:8084/proxy' \
	--header 'Content-Type: application/json' \
	--data-raw '{
	"multipart": "form",
	"Forward-To": "https://217.172.12.215:8889/data",
	"messageType": "ContractAgreementMessage",
	"payload": {
		"@context": {
			"ids": "https://w3id.org/idsa/core/",
			"idsc": "https://w3id.org/idsa/code/"
		},
		"@type": "ids:ContractAgreement",
		"@id": "https://w3id.org/idsa/autogen/contract/restrict-access-interval-{id}",
		"profile": "http://example.com/ids-profile",
		"ids:target": {
			"@id": "http://w3id.org/engrd/connector/artifact/{id}"
		},
		"ids:provider": "http://example.com/party/my-party",
		"ids:consumer": "http://example.com/party/consumer-party",
		"ids:permission": [
			{
				"ids:action": [
					{
						"@id": "idsc:USE"
					}
				],
				"ids:constraint": [
					{
						"@type": "ids:Constraint",
						"ids:leftOperand": "idsc:POLICY_EVALUATION_TIME",
						"ids:operator": "idsc:TEMPORAL_EQUALS",
						"ids:rightOperand": {
							"@type": "ids:interval",
							"@value": {
								"ids:begin": {
									"@value": "2021-03-01T00:00:00Z",
									"@type": "xsd:datetimeStamp"
								},
								"ids:end": {
									"@value": "2021-03-31T00:00:00Z",
									"@type": "xsd:datetimeStamp"
								}
							}
						},
						"ids:pipEndpoint": {
							"@id": "https//pip.com/policy_evaluation_time"
						}
					}
				]
			}
		]
	}
	}'

</details>

When following request is sent, response will be MessageProcessedNotificationMessage, without payload.


### Get offered resource

In order to get resource that TrueConnector offers, you need to send *ArtifactRequestMessage* to B-endpoint.

*Note* change {id} with the correct value, representing resource requested.


<details>
  <summary>Multipart Form - Artifact Request Message</summary>

	curl --location --request POST 'https://localhost:8084/proxy' \
	--header 'Content-Type: application/json' \
	--data-raw '{
	    "multipart": "form",
	    "Forward-To": "https://217.172.12.215:8889/data",
	    "messageType":"ArtifactRequestMessage",
	    "requestedArtifact": "http://w3id.org/engrd/connector/artifact/{id}"   
	}'

</details>

Expected response is ArtifactResponseMessage, as header, and in payload - json document containing information about requested resource.
