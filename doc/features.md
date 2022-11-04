#Features

Following document provide overview of the components and technologies used to build TrueConnector.

TrueConnector follows state-of-the-art technologies, standards (IDS Information Model) and uses best practices of the software development process. 

Software quality is ensured by adhering to and implementing code style guides and logging and providing test coverage. Quality checks and project reports can be generated via maven plugin.


`Java` `Maven` `Spring Boot` `Spring Security` `Apache Camel` `OpenAPI` `Swagger`
`Logback` `Docker` `TLS`

## Core components

TrueConnector is compose of 2 components: Execution Core Container (ECC) and DataApp (dataApp).

Responsibility of ECC is to enforce IDS Ecosystem requirements, like 
DataApp is here to make bridge between IDS domain and user specific domain. It contains logic to receive IDS request, handle some specific use cases (like contract negotiation), create simple response and prepare IDS response. If you need to do some modification, then this is the place to do it, either on consumer side, or on provider side of the dataApp. How to do that, check DataApp documentation (link provided below)

| Library | License | Owner | Contact |
|:--------|:--------|:------|:--------|
| [Execution Core Container](https://github.com/Engineering-Research-and-Development/true-connector-execution_core_container)| License | Engineering | contact email |
| [Basic DataApp](https://github.com/Engineering-Research-and-Development/true-connector-basic_data_app) | License | Engineering | contact email |
| [Usage Control DataApp](https://github.com/Engineering-Research-and-Development/true-connector-uc_data_app_platoon) [^1]| License | Engineering | contact email |

[^1]: This is a fork of the Platoon project

## Libraries

| Library | License | Owner | Contact |
|:--------|:--------|:------|:--------|
| [Multipart Message Library](https://github.com/Engineering-Research-and-Development/true-connector-multipart_message_library) | License | Engineering | contact email |
| [WebSocket Message Streamer](https://github.com/Engineering-Research-and-Development/true-connector-websocket_message_streamer) | License | Engineering | contact email |
| [IDS Information Model Library](https://maven.iais.fraunhofer.de/artifactory/eis-ids-public/de/fraunhofer/iais/eis/ids/infomodel/) | [Apache 2.0](https://github.com/International-Data-Spaces-Association/Java-Representation-of-IDS-Information-Model) | Fraunhofer IAIS | [E-Mail IAIS](mailto:contact@ids.fraunhofer.de) |
| [IDS Information Model Serializer Library](https://maven.iais.fraunhofer.de/artifactory/eis-ids-public/de/fraunhofer/iais/eis/ids/infomodel-serializer/) | Apache 2.0 | Fraunhofer IAIS | [E-Mail IAIS](mailto:contact@ids.fraunhofer.de) |

## IDS Communication

| Component | License | Owner | Contact |
|:--------|:--------|:------|:--------|
| [IDS Broker](https://broker.ids.isst.fraunhofer.de/) | [Apache 2.0](https://github.com/International-Data-Spaces-Association/metadata-broker-open-core) | Fraunhofer IAIS | [E-Mail](mailto:contact@ids.fraunhofer.de) |
| [DAPS](https://daps.aisec.fraunhofer.de/) | [Apache 2.0](https://github.com/Fraunhofer-AISEC/omejdn-server) | Fraunhofer AISEC | [Gerd Brost](mailto:gerd.brost@aisec.fraunhofer.de) |
