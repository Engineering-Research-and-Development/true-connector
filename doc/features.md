# Features

Following document provide overview of the components and technologies used to build TrueConnector.

TrueConnector follows state-of-the-art technologies, standards (IDS Information Model) and uses best practices of the software development process. 

Software quality is ensured by adhering to and implementing code style guides and logging and providing test coverage. Quality checks and project reports can be generated via maven plugin.


`Java` `Maven` `Spring Boot` `Spring Security` `Apache Camel` `OpenAPI` `Swagger`
`Logback` `Docker` `TLS`

## Core components

TrueConnector is compose of 3 components: Execution Core Container (ECC), DataApp (dataApp) and Usage Control application (UC dataApp).

Responsibility of ECC is to enforce IDS Ecosystem requirements, like fetch token from Identity Provider, enforce data usage.

DataApp is here to make bridge between IDS domain and user specific domain. There are 2 logical parts of the dataApp: consumer and provider part. Consumer part is responsible for establishing the bridge between backend system and ECC, preparing request for provider part, while provider part is responsible for preparing response. Provider part has implemented logic for contract negotiation, which should not be changed, and creating simple JSON artifact and prepare IDS response. If you need to do some modification, then this is the place to do it, either on consumer side, or on provider side of the dataApp. How to do that, check DataApp documentation (link provided below)

| Library | License | Owner | Contact |
|:--------|:--------|:------|:--------|
| [Execution Core Container](https://github.com/Engineering-Research-and-Development/true-connector-execution_core_container)| License | Engineering | contact email |
| [Basic DataApp](https://github.com/Engineering-Research-and-Development/true-connector-basic_data_app) | License | Engineering | contact email |
| [Usage Control DataApp](https://github.com/Engineering-Research-and-Development/true-connector-uc_data_app_platoon) [^1]| License | Engineering | contact email |

[^1]: This is a fork of the Platoon project

## Libraries

Libraries used in TRUEConnector are:

| Library | License | Owner | Contact |
|:--------|:--------|:------|:--------|
| [Multipart Message Library](https://github.com/Engineering-Research-and-Development/true-connector-multipart_message_library) | License | Engineering | contact email |
| [WebSocket Message Streamer](https://github.com/Engineering-Research-and-Development/true-connector-websocket_message_streamer) | License | Engineering | contact email |
| [IDS Information Model Library](https://maven.iais.fraunhofer.de/artifactory/eis-ids-public/de/fraunhofer/iais/eis/ids/infomodel/) | [Apache 2.0](https://github.com/International-Data-Spaces-Association/Java-Representation-of-IDS-Information-Model) | Fraunhofer IAIS | [E-Mail IAIS](mailto:contact@ids.fraunhofer.de) |
| [IDS Information Model Serializer Library](https://maven.iais.fraunhofer.de/artifactory/eis-ids-public/de/fraunhofer/iais/eis/ids/infomodel-serializer/) | Apache 2.0 | Fraunhofer IAIS | [E-Mail IAIS](mailto:contact@ids.fraunhofer.de) |

## IDS Communication

TRUEConnector supports communication with following IDS systems (services)

| Component | License | Owner | Contact |
|:--------|:--------|:------|:--------|
| [Clearing House Eng](https://github.com/Engineering-Research-and-Development/market4.0-clearing_house) | License | Engineering | Contact |
| [DAPS](https://daps.aisec.fraunhofer.de/) | [Apache 2.0](https://github.com/Fraunhofer-AISEC/omejdn-server) | Fraunhofer AISEC | [Gerd Brost](mailto:gerd.brost@aisec.fraunhofer.de) |
| [IDS Broker](https://broker.ids.isst.fraunhofer.de/) | [Apache 2.0](https://github.com/International-Data-Spaces-Association/metadata-broker-open-core) | Fraunhofer IAIS | [E-Mail](mailto:contact@ids.fraunhofer.de) |


