## Contract Negotiation - simple flow <a href="#contractnegotiation" id="contractnegotiation"></a>

Usage Control is disabled by default. If you want to enable it (mandatory for contract negotiation), please check ["Enabling usage control"](../advancedConfiguration/usagecontrol.md).

If mandatory, for other connectors, you can perform contract negotiation with other connector (not TRUE Connector) or with TRUE Connector. There is default contract offer that will be sent if ContractRequestMessage is received. It will allow consuming of resource.

Assuming you are running docker instance on local machine. If not, please update hostname to match your scenario.

You can use provided [Postman collection](../../TRUE%20Connector%20v1.postman_collection.json) and [Postman environment](../../TRUE%20Connector%20v1%20enviroment.postman_environment.json); import both files into Postman and perform Contract Negotiation automatically or do this step by step, as described below.


As can bee seen in screenshot, there is 3 Contract Negotiation flows:

 * Contract Negotiation - flow with default ContractRequest message
 * Contract Negotiation (Role/Purpose) - flow with updating default Contract policy, to include Role permission, in order to demonstrate interaction with PIP, necessary for checking Roles or Purpose policies
 * Contract Negotiation WS - flow with default ContractRequest message in WS (WebSocket) communication
 
![TRUE Connector Postman](../TRUEConnector\_Postman.jpg)