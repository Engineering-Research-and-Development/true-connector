# TRUE CONNECTOR

**TRUE** (**TRU**sted **E**ngineering) **Connector** for the IDS (International Data Space) ecosystem


## Table of Contents

* [Features](doc/features.md)
* [Introduction](doc/startup.md)
* [REST API](doc/rest_api/REST_API.md)
* [How to Exchange Data](doc/exchange_data.md)
* [Modifying configuration](doc/modify_configuration.md)
* [Advanced configuration](doc/advanced_configuration.md)
* [Contract Negotiation](doc/contract_negotiation.md)
* [Self Description API](https://github.com/Engineering-Research-and-Development/true-connector-execution_core_container/blob/master/doc/SELF_DESCRIPTION.md)
* [Postman collection](#postman)
* [License](#license)


## Quick start

For more detailed information about TRUEConnector, check links provided in this document.

Easiest way to use TRUEConnector is to clone or download this repository and from terminal execute following:

```
docker-compose up &

```

After initial startup, connector is available at *https://localhost:8090/*  (provider connector)

For more details, on how to send messages, change connector configuration, please check additional documentation.

## Postman collection <a name="postman"></a>

There is a postman collection which can be used to initiate requests that are most commonly used: perform contract negotiation, get artifact, broker interaction, manipulate Self Description document via API.

![Postman collection](doc/postman_collection.png?raw=true "Postman collection")

[TRUEConnector.postman_collection](TRUEConnector.postman_collection.json)</br>

[TRUEConnector enviroment.postman_environment](TRUEConnector_enviroment.postman_environment.json)

This collection comes with predefined environments so be sure to also import environment file.

## Contributing

You are very welcome to contribute to this project when you find a bug, want to suggest an improvement, or have an idea for a useful feature. 

The current development is driven by
* [Gabriele De Luca](https://github.com/gabrieledeluca), [Engineering](https://www.eng.it/)
* [Igor Balog](https://github.com/IgorBalog-Eng), [Engineering](https://www.eng.it/)
* [David Jovanovic](https://github.com/davidjovanovic), [Engineering](https://www.eng.it/)
* [Mattia Giuseppe Marzano](https://github.com/MattiaMarzano-Eng), [Engineering](https://www.eng.it/)
* [Luca Pasquale Curcio](https://github.com/omarsilva1), [Engineering](https://www.eng.it/)

The former core development was driven by
* Milan Karajovic
* [Antonio Scatoloni](https://github.com/ascatox), [Engineering](https://www.eng.it/)
* [Vojkan Bukumiric](https://github.com/vojkanBukumiric91)
* [Petar Crepulja](https://github.com/PetarCrepuljaESL)


## License <a name="license"></a>
The TRUE Connector components are released following different licenses:

* **Execution Core Container**, open-source distributed under the license AGPLv3
* **BE Data APP**, open-source distributed under the license AGPLv3
* **UC Data APP**, TBC
