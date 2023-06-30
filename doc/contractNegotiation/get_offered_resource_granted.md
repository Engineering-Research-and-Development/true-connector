### Get offered resource after access is granted <a href="#get_offered_resource_granted" id="get_offered_resource_granted"></a>

When you have finished negotiation, you can query for resource again to see if we get artifact data.

Postman collection will preset required fields from previous request.
 
<details>

<summary>Multipart Form - Artifact Request Message</summary>

```
curl --location --request POST 'http://localhost:8184/proxy' \
--header 'Content-Type: application/json' \
--header 'Authorization: Basic cHJveHk6cGFzc3dvcmQ=' \
--data-raw '{
    "multipart": "form",
    "Forward-To": "http://ecc-provider:8889/data",
    "messageType":"ArtifactRequestMessage",
    "requestedArtifact": "{{contract_artifact}}",
    "transferContract": "{{transfer_contract}}",
    "payload" : ""
}'
```

</details>

If you have done everything correctly, you should get response with requested artifact, like in our example. Expected response is  json document containing information about requested resource.

<details>

<summary>Artifact Request Message - Example response</summary>

```

{"firstName":"John","lastName":"Doe","address":"591  Franklin Street, Pennsylvania","checksum":"ABC123 2023/06/27 12:26:08","dateOfBirth":"2023/06/27 12:26:08"}
```

</details>

The appeariance of "John Doe" signifies the successful exchange with this contract.