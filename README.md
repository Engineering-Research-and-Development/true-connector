# TRUE CONNECTOR

**TRUE** (**TRU**sted **E**ngineering) **Connector** for the IDS (International Data Space) ecosystem

The TRUE Connector is composed of three components:

* [Execution Core Container (ECC)](https://github.com/Engineering-Research-and-Development/market4.0-execution\_core\_container\_business\_logic), open-source project designed by ENG. It is in charge of the data exchange through the IDS ecosystem representing data using the IDS Information Model and interacting with an external Identity Provider. It is also able to communicate with an IDS Broker for registering and querying information.
* [Back-End (BE) Data Application](https://github.com/Engineering-Research-and-Development/market4.0-data\_app\_test\_BE), open-source project designed by ENG. It represents a trivial data application for generating and consuming data on top of the ECC component.
* [Usage-Control (UC) Data Application](https://github.com/Engineering-Research-and-Development/true-connector-uc\_data\_app\_platoon), a customized version of the Platoon base application for integrating Usage Control functionality. This version of Usage control application requires persistence layer, and it this setup, it is H2 in memory database, with file persistence, but if required, it can be changed with PostgreSQL database.

![TRUE Connector Architecture](doc/TRUE\_Connector\_Architecture.png)

## Table of Contents

* [TRUE CONNECTOR](<README.md#true-connector>)
  * [Table of Contents](<README.md#table-of-contents>)
  * [Introduction](<README.md#introduction->)
    * [System requirements](https://github.com/Engineering-Research-and-Development/true-connector/blob/gitbook/doc/system-requirements.md)
    * [Volumes](<README (1).md#volumes->)
    * [Default configuration](<README (1).md#default-configuration->)
    * [Starting and stopping containers](<README (1).md#starting-and-stopping-containers->)
    * [Component overview](<README (1).md#component-overview->)
  * [REST API](<README (1).md#rest-api->)
  * [Connector reachability](<README (1).md#connector-reachability->)
    * [Connector Id](<README (1).md#connector-id->)
  * [How to Exchange Data](<README (1).md#how-to-exchange-data->)
  * [Modifying configuration](<README (1).md#modifying-configuration->)
    * [Enable hostname validation](<README (1).md#enable-hostname-validation->)
    * [SSL/HTTPS](<README (1).md#sslhttps->)
    * [Change message format - Multipart/Mixed, Multipart/Form, Http-headers](<README (1).md#change-message-format---multipartmixed-multipartform-http-headers->)
    * [WebSocket configuration (WSS)](<README (1).md#websocket-configuration-wss->)
    * [IDSCPv2 configuration](<README (1).md#idscpv2-configuration->)
  * [Advanced configuration](<README (1).md#advanced-configuration->)
    * [Supported Identity Providers](<README (1).md#supported-identity-providers->)
    * [Extended jwt validation](<README (1).md#extended-jwt-validation->)
    * [Convert keystorage files](<README (1).md#convert-keystorage-files->)
    * [Validate protocol](<README (1).md#validate-protocol->)
    * [Clearing House](<README (1).md#clearing-house->)
    * [Broker](<README (1).md#broker->)
    * [Usage Control](<README (1).md#usage-control->)
    * [MyData Usage Control](<README (1).md#mydata-usage-control->)
    * [Audit logs](<README (1).md#audit-logs->)
  * [Contract Negotiation - simple flow](<README (1).md#contract-negotiation---simple-flow->)
    * [Get offered resource](<README (1).md#get-offered-resource->)
    * [Description Request Message](<README (1).md#description-request-message->)
    * [Contract Request Message](<README (1).md#contract-request-message->)
    * [Contract Agreement request](<README (1).md#contract-agreement-request->)
    * [Get offered resource after access is granted](<README (1).md#get-offered-resource-after-access-is-granted->)
  * [Self Description API](<README (1).md#self-description-api->)
    * [Changing API password](<README (1).md#changing-api-password>)
  * [Postman collection](<README (1).md#postman-collection->)
  * [Cosign](<README (1).md#cosign->)
  * [License](<README (1).md#license->)
  
## Introduction <a href="#introduction" id="introduction"></a>

Once you clone or download repository, you will have following directory structure, with following directories:

```
be-dataapp_data_receiver - containing data needed for receiver/provider dataApp, files to share...
be-dataapp_data_sender
be-dataapp_resources - directory containing property file used for advanced configuration for both dataApps
ecc_cert - directory used to store certificate files (DAPS certificate, HTTPS certificate, truststore...)
ecc_resources_consumer - directory containing property file for consumer ECC advanced configuration
ecc_resources_provider - directory containing property file for provider ECC advanced configuration
kubernetes - directory containing yaml files to have True Connector in a Kubernetes enviroment

Platoon Usage control related (contains property file for usage control data app):
uc-dataapp_resources_consumer
uc-dataapp_resources_provider
```

TrueConnector comes as dockerized application, which consists of few docker containers:

* provider execution core container
* provider data application (sample data application)
* provider usage control application
* consumer execution core container
* consumer data application (sample data application)
* consumer usage control application

# Contributing TRUEConnector

The following is a set of guidelines for contributing to the TRUEConnector. You are very
welcome to contribute to this project, and it's components [Execution Core Container (ECC)](https://github.com/Engineering-Research-and-Development/market4.0-execution_core_container_business_logic), [Back-End (BE) Data Application](https://github.com/Engineering-Research-and-Development/market4.0-data_app_test_BE), [Usage-Control (UC) Data Application](https://github.com/Engineering-Research-and-Development/true-connector-uc_data_app_platoon), [Websocket Message Streamer](https://github.com/Engineering-Research-and-Development/true-connector-websocket_message_streamer) and [Multipart Message Library](https://github.com/Engineering-Research-and-Development/true-connector-multipart_message_library) when you find a bug, want to suggest an improvement, or have
an idea for a useful feature. For this, always create an issue and a corresponding project and branch, and follow our style guides as described below.

## Changelog

We document changes in the CHANGELOG.md on root level in each project.

## Issues

You always have to create an issue if you want to integrate a bugfix, improvement, or feature. Briefly and clearly describe the purpose of your contribution in the corresponding issue. You can send email to the [TRUEConnector team](mailto:trueconnector-team@eng.it) before creating an issue, if unclear in which project to create an issue.

**Bug Report**: As mentioned above, bug reports should be submitted as an issue. To give others
the chance to reproduce the error in order to find a solution as quickly as possible, the report
should at least include the following information:
* Description: What did you expect and what happened instead?
* Steps to reproduce (system specs included)
* Relevant logs and/or media (optional): e.g. an image

For more details about branches, naming conventions and some suggestions, take a look at following [Developer instructions](https://github.com/Engineering-Research-and-Development/true-connector-execution_core_container/tree/develop#developer-guide-section)