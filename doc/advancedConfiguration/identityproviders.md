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