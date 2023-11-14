## Prerequisite <a href="doc/#prerequisite" id="prerequisite"></a>

To have secure and certification compliant environment, following prerequisites are mandatory to be performed before setting up TRUE Connector:

* NTP time server of the machine, where TRUE Connector will be deployed, has to be enabled and configured correctly. This will allow that once certificates are checked, correct time will be used to verify certificate, expired or not. This applies for both DAPS and TLS1.3 certificates. Connector will rely on OS time when checking certificates
* Docker is mandatory "OS service" for running connector
* verify [System requirements](system-requirements.md) before starting the connector.

### Securing docker host

* The host OS should be audited and secure; OS should be as minimal as possible and it should be preferably used to host our Docker exclusively. There should not coexist other services like web servers or web applications so that attacker could not exploit it or lead to potential exploit (minimal threat attack surface).
* Monitoring mechanism (Linux auditd service for example) should be installed and configured as prerequisite before deploying connector. This will capture if someone tries to make changes on property files used by the connector.
* make sure to create rules to monitor folders and property files of the TRUE Connector (for example auditctl -w /xxxx/TRUEConnector/* -k trueconnector, depending on the location where TRUE Connector is deployed)
* make sure to create rules for monitoring docker service (dockerd, /run/containerc, /var/lib/docker, /etc/docker, docker.service...) This might differ based on OS distribution
* rules for auditing should be persisted (/etc/audit/audit.d/rules/audit.rules file, depending on the OS distribution, location might differ)
* make sure to create rules for mounted docker volumes (to be able to keep track of changes made over files present in those volumes)


* User responsible for setting up environment where connector will run should isolate or disable other services. 
* OS user for running docker should not be root user; be sure to create new user, assign new user to docker group, that user can run docker compose
* disable password login to the server for newly created user and allow only key-based authentication for accessing the server where connector will run
* disable access for the root user by using a password when connecting to the server via ssh (key-based auth only)
* in case of adding some additional, more configurable and robust firewall, be sure to restrict access to the /api/* endpoints to only internal network, since those endpoints should not be exposed to the outside world, but intended to be used by "internal" user, to make modifications to the self description document.


* 2 types of certificate are required: DAPS and TLS. 
DAPS certificate should be obtained from Certified Authority responsible for the Dataspace, while TLS certificate can be self signed or signed by some CA. More information about TLS certificate can be found [here](../security.md).


## Post configuration steps

Once TRUE Connector is successfully configured and is up and running, responsible user for setting up environment and configuring connector should generate new passwords for 2 type of users required for operating with connector. More information how to do this can be found [here](https://github.com/Engineering-Research-and-Development/true-connector-execution_core_container/blob/1.14.5/doc/SECURITY.md#change-default-password). 

Make sure to update following properties to address your usecase:


.env file

```
PROVIDER_ISSUER_CONNECTOR_URI=http://w3id.org/engrd/connector/provider
CONSUMER_ISSUER_CONNECTOR_URI=http://w3id.org/engrd/connector/consumer
```
and in ecc_resources_consumer and ecc_resources_provider application.property file:

```
application.selfdescription.description=Data Consumer Connector description
application.selfdescription.title=Data Consumer Connector title
application.selfdescription.curator=http://consumer.curatorURI.com
application.selfdescription.maintainer=http://consumer.maintainerURI.com

```
