# Modifying configuration <a name="modifyconfiguration"></a>

If you wish to change some configuration parameters for TRUE Connector, it can be done by editing **.env** file.

## Enable hostname validation <a name="hosnamevalidation"></a>

To enable hostname validation, set following property to false:

```
DISABLE_SSL_VALIDATION=false
```
By changing this property to false and enabling hostname validation, you will have to have valid truststore, with public keys from external systems (towards which you are making https calls) imported into truststore.
Set truststore and its password by modifying following properties

```
TRUSTORE_NAME=truststoreEcc.jks
TRUSTORE_PASSWORD=allpassword
```

## SSL/HTTPS <a name="ssl"></a>

If you have your own certificate that you wish to use for SSL configuration, you can apply it by changing:

```
#SSL settings
KEYSTORE_NAME={your_certificate}
KEY_PASSWORD={your_certificate_key}
KEYSTORE_PASSWORD={your_certificate_password}
ALIAS={your_certificate_alias}
```

If you want to use http and not https, simply disable following property

If you want to use http and not https, simply disable following properties

```
SERVER_SSL_ENABLED=false
REST_ENABLE_HTTPS=false
```

Keep also in mind to change the data app URLs

```
PROVIDER_DATA_APP_ENDPOINT=http://be-dataapp-provider:8083/data
CONSUMER_DATA_APP_ENDPOINT=http://be-dataapp-consumer:8083/data
```

## Change message format - Multipart/Mixed, Multipart/Form, Http-headers <a name="messageformat"></a>

TRUE Connector can have different message formats between each component, and it can be modified by editing following properties:

```
# REST Communication type between ECC - mixed | form | http-header
MULTIPART_ECC=mixed

# mixed | form | http-header
PROVIDER_MULTIPART_EDGE=mixed

# mixed | form | http-header
CONSUMER_MULTIPART_EDGE=mixed

```
There is only one property to configure communication between ECC, since Consumer ECC and Provider ECC must have same configuration in order to be able to exchange and interprete message in correct way.

Message format between consumer DataApp and Consumer ECC (also called EDGE connection) can be independent from other configurations. Same is applied for EDGE connection between Provider ECC and Provider DataApp

## WebSocket configuration (WSS) <a name="wss"></a>

TRUE Connector can be configured to use WebSocket over HTTPS, for exchanging large files. WSS communication can be configured (independently of each other):

```
# Mandatory for WSS communication
MULTIPART_ECC=mixed
PROVIDER_MULTIPART_EDGE=mixed
CONSUMER_MULTIPART_EDGE=mixed
```

* between Consumer DataApp and Consumer ECC

```
# For EDGE communication between Consumer ECC and Consumer DataApp
CONSUMER_WS_EDGE=true

```
* between Consumer ECC and Provider ECC

```
# For WebSocket communication between ECC's
WS_ECC=true
```

* between Provider DataApp and Provider ECC

```
# For EDGE communication between Provider DataApp and Provider ECC
PROVIDER_WS_EDGE=true
# In case of WSS configuration
#PROVIDER_DATA_APP_ENDPOINT=https://be-dataapp-provider:9000/incoming-data-app/routerBodyBinary
```

To configure connector for WebSocket configuration, modify following:

*be-dataapp-resources\config.properties*

```
server.ssl.key-password=changeit
server.ssl.key-store=/cert/ssl-server.jks
```

With custom certificate or leave default one.
*Note:* if using custom certificate, same certificate must be used in ECC and DataApp, in order to be able to do handshake between ECC and DataApp. Check [SSL/HTTPS](#ssl)

On the following link, information regarding WebSocket Message Streamer implementation can be found here [WebSocket Message Streamer library](https://github.com/Engineering-Research-and-Development/market4.0-websocket_message_streamer).

## IDSCPv2 configuration <a name="idscpv2"></a>

TRUE Connector can exchange data using IDSCPv2 protocol, currently only between ECC's, not between DataApp and ECC. To do this, modify following properties:

```
# Enable WSS between ECC
WS_ECC=false

# Enable IDSCPv2 between ECC - set WS_ECC=false
IDSCP2=true
```
