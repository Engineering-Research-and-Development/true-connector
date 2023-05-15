# TRUE CONNECTOR

**TRUE** (**TRU**sted **E**ngineering) **Connector** for the IDS (International Data Space) ecosystem

The TRUE Connector is composed of three components:

* [Execution Core Container (ECC)](https://github.com/Engineering-Research-and-Development/true-connector-execution_core_container), open-source project designed by ENG. It is in charge of the data exchange through the IDS ecosystem representing data using the IDS Information Model and interacting with an external Identity Provider. It is also able to communicate with an IDS Broker for registering and querying information.
* [Back-End (BE) Data Application](https://github.com/Engineering-Research-and-Development/true-connector-basic_data_app), open-source project designed by ENG. It represents a trivial data application for generating and consuming data on top of the ECC component.
* [Usage-Control (UC) Data Application](https://github.com/Engineering-Research-and-Development/true-connector-uc\_data\_app\_platoon), a customized version of the Platoon base application for integrating Usage Control functionality. This version of Usage control application requires persistence layer, and it this setup, it is H2 in memory database, with file persistence, but if required, it can be changed with PostgreSQL database.

![TRUE Connector Architecture](doc/TRUE\_Connector\_Architecture.png)

## Table of Contents

* [TRUE Connector](<README.md#true-connector>)
  * [Table of Contents](<README.md#table-of-contents>)
  * [Introduction](<README.md#introduction->)
    * [System requirements](doc/system-requirements.md)
    * [Volumes](doc/volumes.md)
    * [Default configuration](doc/default-configuration.md)
    * [Starting and stopping containers](doc/start-stop.md)
    * [Component overview](doc/component-overview.md)
  * [REST API](doc/rest-api.md)
  * [Connector reachability](doc/reachability.md)
    * [Connector Id](doc/reachability.md#connector-id-)
  * [How to Exchange Data](doc/exchange-data.md)
  * [Modifying configuration](doc/modify-configuration.md)
    * [Enable hostname validation](doc/modify-configuration.md#enable-hostname-validation-)
    * [SSL/HTTPS](doc/modify-configuration.md#sslhttps-)
    * [Change message format - Multipart/Mixed, Multipart/Form, Http-headers](doc/modify-configuration.md#change-message-format---multipartmixed-multipartform-http-headers-)
    * [WebSocket configuration (WSS)](doc/modify-configuration.md#websocket-configuration-wss-)
    * [IDSCPv2 configuration](doc/modify-configuration.md#idscpv2-configuration-)
  * [Advanced configuration](doc/advanced-configuration.md)
    * [Supported Identity Providers](doc/advanced-configuration.md#supported-identity-providers-)
    * [Extended jwt validation](doc/advanced-configuration.md#extended-jwt-validation-)
    * [Convert keystorage files](doc/advanced-configuration.md#convert-keystorage-files-)
    * [Validate protocol](doc/advanced-configuration.md#validate-protocol-)
    * [Clearing House](doc/advanced-configuration.md#clearing-house-)
    * [Broker](doc/advanced-configuration.md#broker-)
    * [Usage Control](doc/advanced-configuration.md#usage-control-)
    * [MyData Usage Control](doc/advanced-configuration.md#mydata-usage-control-)
    * [Audit logs](doc/advanced-configuration.md#audit-logs-)
  * [Contract Negotiation - simple flow](doc/contract-negotiation.md)
    * [Get offered resource](doc/contract-negotiation.md#get-offered-resource-)
    * [Description Request Message](doc/contract-negotiation.md#description-request-message-)
    * [Contract Request Message](doc/contract-negotiation.md#contract-request-message-)
    * [Contract Agreement request](doc/contract-negotiation.md#contract-agreement-request-)
    * [Get offered resource after access is granted](doc/contract-negotiation.md#get-offered-resource-after-access-is-granted-)
  * [Self Description API](doc/self-description-API.md)
    * [Changing API password](doc/self-description-API.md#changing-api-password)
  * [Postman collection](doc/self-description-API.md#postman-collection-)
  * [Cosign](doc/self-description-API.md#cosign-)
  * [License](doc/license.md)
  * [Contributing TRUE Connector](doc/contributingTC.md)
  
## Introduction <a href="#introduction" id="introduction"></a>

Once you clone or download repository, you will have following directory structure, with following directories:

```
be-dataapp_data_receiver - containing data needed for receiver/provider dataApp, files to share...
be-dataapp_data_sender
be-dataapp_resources - directory containing property file used for advanced configuration for both dataApps
ecc_cert - directory used to store certificate files (DAPS certificate, HTTPS certificate, truststore...)
ecc_resources_consumer - directory containing property file for consumer ECC advanced configuration
ecc_resources_provider - directory containing property file for provider ECC advanced configuration
kubernetes - directory containing yaml files to have TRUE Connector in a Kubernetes enviroment

Platoon Usage control related (contains property file for usage control data app):
uc-dataapp_resources_consumer
uc-dataapp_resources_provider
```

TRUE Connector comes as dockerized application, which consists of few docker containers:

* provider execution core container
* provider data application (sample data application)
* provider usage control application
* consumer execution core container
* consumer data application (sample data application)
* consumer usage control application