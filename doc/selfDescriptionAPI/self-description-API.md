## Self Description API <a href="#selfdescription" id="selfdescription"></a>

To manage your Self Description Document please check following [link](https://github.com/Engineering-Research-and-Development/true-connector-execution_core_container/blob/1.14.6/doc/SELF_DESCRIPTION.md)

You can copy existing valid self-description.json document to following location **/ecc\_resources\_consumer** or **/ecc\_resources\_provider** folders, for consumer or provider.


There is also possibility to change location of self\_description.json document, which can be done by changing following property:

```
application.selfdescription.filelocation=

```

Be careful when changing this property, since it needs to be reflected inside docker container.

When connector is starting up, it will look for file named _self\_description.json_ file, and if such file exists, it will load Self Description document from file, otherwise it will create default Self Description document, from properties (with example default values):

```
application.selfdescription.description=Data Connector description
application.selfdescription.title=Data Connector title
application.selfdescription.curator=http://curatorURI.com
application.selfdescription.maintainer=http://maintainerURI.com
application.selfdescription.inboundModelVersion=4.0.0,4.1.0,4.1.2,4.2.0,4.2.1,4.2.2,4.2.3,4.2.4,4.2.5,4.2.6,4.2.7

```

With single offered resource, artifact and contract offer.

Other elements of self description document are calculated based on configuration, like connector endpoint, public key and such.

Cryptographic hash of Connector certificate - calculate from configured DAPS certificate 

Security profile cannot be changed, it is hardcoded in java code (user should not change it freely)

Connector Id - from env file, PROVIDER_ISSUER_CONNECTOR_URI or CONSUMER_ISSUER_CONNECTOR_URI

Default endpoint - calculated based on public IP address of the machine/docker configuration and configured port
