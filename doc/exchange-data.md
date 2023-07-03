## How to Exchange Data <a href="#exchangedata" id="exchangedata"></a>

With default configuration, you can use following curl command, to get data from Provider connector

<details>

<summary>Multipart Form request</summary>

```
curl --location 'https://localhost:8184/proxy' \
--header 'Content-Type: application/json' \
--header 'Authorization: Basic cHJveHk6cGFzc3dvcmQ=' \
--data '{
    "multipart": "form",
    "Forward-To": "https://ecc-provider:8889/data",
    "messageType": "ArtifactRequestMessage",
    "requestedArtifact": "http://w3id.org/engrd/connector/artifact/1",
    "transferContract": "https://w3id.org/idsa/autogen/contractAgreement/d0459442-4eb3-4372-8640-0ca49abf8f1d",
    "payload" : {
		"catalog.offers.0.resourceEndpoints.path":"/pet2"
		}
}'
```

</details>

_NOTE_: even that this curl command is exported from Postman, it is noticed several times, that when you try to import it back in Postman, there are some problems during this process, which results in omitting request body, and then request fill fail - cannot find body to create request.\
If this happens, please check body of the request in Postman, and if body is empty, simply copy everything enclosed between\
_--data-raw '_ and _'_

For more details on request samples, please check following link [Backend DataApp Usage](https://github.com/Engineering-Research-and-Development/market4.0-data\_app\_test\_BE/blob/master/README.md)

Be sure to use correct configuration/ports for sender and receiver Data App and Execution Core Container (check .env file).

Default values:

```
DataApp URL: https://localhost:8184/proxy
"Forward-To": "https://ecc-provider:8889/data",
```

For WSS flow:

```
DataApp URL: https://localhost:8184/proxy
"multipart": "wss",
"Forward-To": "wss://ecc-provider:8086/data",
"Forward-To-Internal": "wss://ecc-consumer:8887",
```

For IDSCPv2:

Follow the REST endpoint or WS examples, put the server hostname/ip address in the Forward-To header (_wss/https://{RECEIVER\_IP\_ADDRESS/Hostname}:{WS\_PUBLIC\_PORT}_).

* **AISECv2** put the certificates (keyStore and trustStore) in the _cert_ folder,edit related settings (_IDSCP2 AISEC DAPS settings_ section in env file)

