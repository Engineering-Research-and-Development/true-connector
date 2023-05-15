## Advanced configuration <a href="#advancedconfiguration" id="advancedconfiguration"></a>

If you did not find which property to change by editing **.env** file, there is an option, to modify property file directly, by editing one of the **application-docker.properties** files located in **ecc\_resources\_consumer** or **ecc\_resources\_provider** directories. There are comments present in property files, which describes impact and usage of some of the properties.

### Supported Identity Providers <a href="#identityproviders" id="identityproviders"></a>

Since Identity provider is disabled by default, in order to enable it, set following application.property to true:

```
application.isEnabledDapsInteraction=true

```

The TRUE Connector is able to interact with the following Identity Providers: For each of 3 supported identity providers, you need to obtain certificate, in order to be able to get JWToken from DAPS server. Certificate needs to be copied into _ecc\_cert_ folder and modify _DAPS\_KEYSTORE\_NAME_, _DAPS\_KEYSTORE\_PASSWORD_ and _DAPS\_KEYSTORE\_ALIAS_ in _.env_ file, for both Provider and Consumer section..

* **AISECv2** (default configuration)additional step: edit _application-docker.properties_ and modify _application.dapsVersion=v2_ and _application.dapsUrl_ should point to DAPS v2 server
* **ORBITER** put the certificates (private and public key) in the _ecc\_cert_ folder, edit related settings (i.e., _application.daps.orbiter.privateKey_, _application.daps.orbiter.password_) and set the _application.dapsVersion_ (in the _application-docker.properties_) to _orbiter_ _application.dapsUrl_ should point to Orbiter IDP server

DAPS related configuration can be achieved by modifying following (.env file). Following snippet is just an example:

```
PROVIDER_DAPS_KEYSTORE_NAME=daps-keystore-provider.p12
PROVIDER_DAPS_KEYSTORE_PASSWORD=password
PROVIDER_DAPS_KEYSTORE_ALIAS=1
```

and/or

```
CONSUMER_DAPS_KEYSTORE_NAME=daps-keystore-consumer.p12
CONSUMER_DAPS_KEYSTORE_PASSWORD=password
CONSUMER_DAPS_KEYSTORE_ALIAS=1
```

### Extended jwt validation <a href="#extendedjwt" id="extendedjwt"></a>

TRUE Connector can check additional claims from jwToken. For more information. please check \[following link] (https://github.com/Engineering-Research-and-Development/true-connector-execution\_core\_container/blob/master/doc/TRANSPORTCERTSSHA256.md)

### Convert keystorage files <a href="#convert_keystorage" id="convert_keystorage"></a>

Change values for keystore file name, password and alias that matches Your keystore file. Keystore can be in jks format or p12. If you have some other certificate format (like pem for example), you can convert it by executing following commands from terminal:

You should have 2 files, cert.pem, containing public key

```
-----BEGIN CERTIFICATE-----
MIIDHzCCAgcCCQD0p/3nqCMT5zANBgkqhkiG9w0BAQ0FADBUMQswCQYDVQQGEwJF
...
ACsqRifEx7DKolsGyRM/zZWZZNkXNMCR1GfZv6yUNSVXQ5w=
-----END CERTIFICATE-----

```

and privkey.key, containing private key

```
-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCzDmSOphiul2hh
...
RmSOiiYKXvxW1Z2VU3uKNVU=
-----END PRIVATE KEY-----

```

You can use following command, to convert cert and key file to p12 keystorage file:

```
openssl pkcs12 -export -in cert.pem -inkey privkey.key -out certificate.p12 -name "alias"

```

Provide passwords when prompted.\
Change alias to desired value.

Once you have p12 file, you can use it as is in TRUE Connector, or you can convert it to jks with:

```
keytool -importkeystore -srckeystore certificate.p12 -srcstoretype pkcs12 -destkeystore cert.jks

```

TRUE Connector supports p12 format of certificate file, but if for some reason connector does not read file correct, you can try to convert it to jks format using provided command.

### Validate protocol <a href="#validateprotocol" id="validateprotocol"></a>

Forward-To protocol validation can be enabled by setting the property **application.enableProtocolValidation** to true. If you have this enabled please refer to the following step.

Forward-To protocol validation can be changed by editing _application-docker.properties_ and modify **application.validateProtocol**. Default value is _false_ and Forward-To URL will not be validated. Forward-To URL can be set like http(https,wss)://example.com or just example.com and the protocol chosen (from application-docker.properties) will be automatically set (it will be overwritten!)\
Example: http://example.com will be wss://example if you chose wss in the properties).

If validateProtocol is true, then Forward-To header must contain full URL, including protocol.\
Forward-To=localhost:8890/data - this one will fail, since it lack of information is it http or https\
Forward-To=https://localhost:8890/data - this one will work, since it has protocol information in URL.

### Clearing House <a href="#clearinghouse" id="clearinghouse"></a>

The TRUE Connector supports is able to communicate with the Fraunhofer Clearing House for registering transactions.

Since Clearing house is disabled by default, in order to enable it, set following property to true:

```
application.isEnabledClearingHouse=true

```

### Broker <a href="#broker" id="broker"></a>

Information on how TRUE Connector can interact with Broker, can be found on following [link](https://github.com/Engineering-Research-and-Development/true-connector-execution\_core\_container/blob/master/doc/BROKER.md)

### Usage Control <a href="#usagecontrol" id="usagecontrol"></a>

Details about the PMP and PEP components and how to switch to PostgeSQL from the default H2 in-memory database you can find [here](PLATOON\_USAGE\_CONTROL.md).

Since Usage Control is disabled by default, in order to enable it, set following property to true:

```
application.isEnabledUsageControl=true

```

### MyData Usage Control <a href="#mydata" id="mydata"></a>

The TRUE Connector integrates both the [Platoon Usage Control Data App](https://github.com/Engineering-Research-and-Development/true-connector-uc\_data\_app\_platoon) and [MyData Usage Control Data App](https://github.com/Engineering-Research-and-Development/true-connector-uc\_data\_app) for enforcing the Usage Control. True Connector is by default configured to use Platoon Usage Control, in order to use MyData follow the instructions in the [document](MYDATA\_USAGE\_CONTROL.md).

### Audit logs <a href="#auditlogs" id="auditlogs"></a>

Audit logging is turned **off** by default. If you wish to configure it or even turn off please follow this [document](https://github.com/Engineering-Research-and-Development/true-connector-execution\_core\_container/blob/master/doc/AUDIT.md) .
