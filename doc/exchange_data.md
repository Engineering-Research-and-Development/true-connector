# How to Exchange Data <a name="exchangedata"></a>

With default configuration, you can use following curl command, to get data from Provider connector

<details>
  <summary>Multipart Form request</summary>

	curl --location --request POST 'https://localhost:8084/proxy' \
	--header 'Content-Type: text/plain' \
	--data-raw '{
	    "multipart": "form",
	    "Forward-To": "https://ecc-provider:8889/data",
	    "messageType": "ArtifactRequestMessage" ,
	    "requestedArtifact": "http://w3id.org/engrd/connector/artifact/1" ,
	    "payload" : {
			"catalog.offers.0.resourceEndpoints.path":"/pet2"
			}
	}'

</details>

*NOTE*: even that this curl command is exported from Postman, it is noticed several times, that when you try to import it back in Postman, there are some problems during this process, which results in omitting request body, and then request fill fail - cannot find body to create request.</br>
If this happens, please check body of the request in Postman, and if body is empty, simply copy everything enclosed between</br>
*--data-raw '* and *'*

For more details on request samples, please check following link [Backend DataApp Usage](https://github.com/Engineering-Research-and-Development/market4.0-data_app_test_BE/blob/master/README.md)

Be sure to use correct configuration/ports for sender and receiver Data App and Execution Core Container (check .env file).

Default values:

```
DataApp URL: https://localhost:8084/proxy
"Forward-To": "https://ecc-provider:8889/data",
```

For WSS flow:

```
DataApp URL: https://localhost:8084/proxy
"multipart": "wss",
"Forward-To": "wss://ecc-provider:8086/data",
"Forward-To-Internal": "wss://ecc-consumer:8887",
```

For IDSCPv2:

Follow the REST endpoint or WS examples, put the server hostname/ip address in the Forward-To header (*wss/https://{RECEIVER_IP_ADDRESS/Hostname}:{WS_PUBLIC_PORT}*).
* **AISECv2** put the certificates (keyStore and trustStore) in the *cert* folder,edit related settings (*IDSCP2 AISEC DAPS settings* section in env file)
