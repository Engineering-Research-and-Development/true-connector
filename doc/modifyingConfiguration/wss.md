### WebSocket configuration (WSS) <a href="#wss" id="wss"></a>

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

_be-dataapp-resources\config.properties_

```
server.ssl.key-password=changeit
server.ssl.key-store=/cert/ssl-server.jks
```

With custom certificate or leave default one. _Note:_ if using custom certificate, same certificate must be used in ECC and DataApp, in order to be able to do handshake between ECC and DataApp. Check [SSL/HTTPS](<README (1).md#ssl>)

On the following link, information regarding WebSocket Message Streamer implementation can be found here [WebSocket Message Streamer library](https://github.com/Engineering-Research-and-Development/market4.0-websocket\_message\_streamer).
