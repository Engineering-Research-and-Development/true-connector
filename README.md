# TRUE CONNECTOR
TRUE (TRUsted Engineering) Connector for the IDS (International Data Space) ecosystem

The TRUE Connector is composed of three components:
* Execution Core Container (ECC), open-source project designed by ENG. It is in charge of the data exchange through the IDS ecosystem representing data using the IDS Information Model and interacting with an external Identity Provider. It is also able to communicate with an IDS Broker for registering and querying information.
* Back-end (BE) Data Application, open-source project designed by ENG. It represents a trivial data application for generating and consuming data on top of the ECC component.
* Usage-Control (UC) Data Application, a customized version of the Fraunhofer IESE base application for integrating the MyData Framework (a Usage Control Framework designed and implemented by Fraunhofer IESE) in a connector.

![TRUE Connector Architecture](doc/TRUE_Connector_Architecture.png?raw=true "TRUE Connector Architecture")
