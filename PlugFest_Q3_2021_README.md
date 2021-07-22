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

### Contract negotiation

If mandatory, for other connectors, you can perform contract negotiation with other connector (not TRUE Connector) or with TRUE Connector. There is default contract offer that will be sent if ContractRequestMessage is received. It will allow consuming of resource in year 2021.

If you do not wnat to do contract negotiation, and you are using TRUE Connector "on both sides", there is "workaround", to upload Usage Control policy directly to Consumer Usage Control Data App. In order to achieve this, use following link:

```
http://localhost:9553/swagger-ui.html#/odrl-policy-controller
```

Assuming you are running docker instance on local machine. If not, please update hostname to match your scenario.

In POST request, upload policy from [here](https://github.com/Engineering-Research-and-Development/true-connector-uc_data_app/blob/master/src/main/resources/policy-examples/0.0.2/1%20restrict-access-interval.json)

### Get offered resource

In order to get resource that TrueConnector offers, you need to send *ArtifactRequestMessage* to B-endpoint.

TODO: update how to test once when we have new proxy request
Prepare ArtifactRequestMessage, set requestedArtifact to be *http://w3id.org/engrd/connector/artifact/1* and
