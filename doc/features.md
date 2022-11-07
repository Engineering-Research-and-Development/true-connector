# Features

**TRUE** (**TRU**sted **E**ngineering) **Connector** for the IDS (International Data Space) ecosystem

Following document provide overview of the components and technologies used to build TrueConnector.

TrueConnector follows state-of-the-art technologies, standards (IDS Information Model) and uses best practices of the software development process. 

Software quality is ensured by adhering to and implementing code style guides and logging and providing test coverage. Quality checks and project reports can be generated via maven plugin.


`Java` `Maven` `Spring Boot` `Spring Security` `Apache Camel` `OpenAPI` `Swagger`
`Logback` `Docker` `TLS`

## Core components

The TRUE Connector is composed of three components:

* [Execution Core Container (ECC)](https://github.com/Engineering-Research-and-Development/true-connector-execution_core_container), open-source project designed by ENG. It is in charge of the data exchange through the IDS ecosystem representing data using the IDS Information Model and interacting with an external Identity Provider. It is also able to communicate with an IDS Broker for registering and querying information.
* [Back-End (BE) Data Application](https://github.com/Engineering-Research-and-Development/true-connector-basic_data_app), open-source project designed by ENG. It represents a trivial data application for generating and consuming data on top of the ECC component.
* [Usage-Control (UC) Data Application](https://github.com/Engineering-Research-and-Development/true-connector-uc_data_app_platoon), a customized version of the Platoon base application for integrating Usage Control functionality. This version of Usage control application requires persistence layer, and it this setup, it is H2 in memory database, with file persistence, but if required, it can be changed with PostgreSQL database.

![TRUE Connector Architecture](TRUE_Connector_Architecture.png?raw=true "TRUE Connector Architecture")

## Libraries

Libraries used in TRUEConnector are:

| Library | License | Owner | Contact |
|:--------|:--------|:------|:--------|
| [Multipart Message Library](https://github.com/Engineering-Research-and-Development/true-connector-multipart_message_library) | AGPLv3 | Engineering | contact email |
| [WebSocket Message Streamer](https://github.com/Engineering-Research-and-Development/true-connector-websocket_message_streamer) | AGPLv3 | Engineering | contact email |
| [IDS Information Model Library](https://maven.iais.fraunhofer.de/artifactory/eis-ids-public/de/fraunhofer/iais/eis/ids/infomodel/) | [Apache 2.0](https://github.com/International-Data-Spaces-Association/Java-Representation-of-IDS-Information-Model) | Fraunhofer IAIS | [E-Mail IAIS](mailto:contact@ids.fraunhofer.de) |
| [IDS Information Model Serializer Library](https://maven.iais.fraunhofer.de/artifactory/eis-ids-public/de/fraunhofer/iais/eis/ids/infomodel-serializer/) | Apache 2.0 | Fraunhofer IAIS | [E-Mail IAIS](mailto:contact@ids.fraunhofer.de) |

## IDS Communication

TRUEConnector supports communication with following IDS systems (services)

| Component | License | Owner | Contact |
|:--------|:--------|:------|:--------|
| [Clearing House Eng](https://github.com/Engineering-Research-and-Development/market4.0-clearing_house) | License | Engineering | Contact |
| [DAPS](https://daps.aisec.fraunhofer.de/) | [Apache 2.0](https://github.com/Fraunhofer-AISEC/omejdn-server) | Fraunhofer AISEC | [Gerd Brost](mailto:gerd.brost@aisec.fraunhofer.de) |
| [IDS Broker](https://broker.ids.isst.fraunhofer.de/) | [Apache 2.0](https://github.com/International-Data-Spaces-Association/metadata-broker-open-core) | Fraunhofer IAIS | [E-Mail](mailto:contact@ids.fraunhofer.de) |
