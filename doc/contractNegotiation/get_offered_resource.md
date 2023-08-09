### Get offered resource <a href="#get_offered_resource" id="get_offered_resource"></a>

In order to get resource that TRUE Connector offers, you need to send ArtifactRequestMessage to B-endpoint.

We can query the resource with ArtifactRequestMessage:

<details>

<summary>Multipart form - Artifact Request Message</summary>

```
curl --location -k --request POST 'https://localhost:8184/proxy' \
--header 'Content-Type: application/json' \
--header 'Authorization: Basic aWRzVXNlcjpwYXNzd29yZA==' \
--data-raw '{
	"multipart": "form",
	"Forward-To": "https://ecc-provider:8889/data",
	"messageType":"ArtifactRequestMessage",
	"requestedArtifact": "http://w3id.org/engrd/connector/artifact/1"
}'
```

</details>

If Usage Control is active (in Docker scenario), our access to the resource will be denied.\
If you recieve other response than RejectionMessage:\
1\) Check if Usage Control is enabled.\
2\) Check if there is an old policy existing in /policies folder. You should delete previously presisted \*.policy files in this folder and restart Docker.