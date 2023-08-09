### Contract Agreement request <a href="#contract_agreement_request" id="contract_agreement_request"></a>

Postman collection will preset required fields from previous request.
 
<details>

<summary>Multipart form - Contract Agreement request</summary>

```
curl --location -k --request POST 'https://localhost:8184/proxy' \
--header 'Content-Type: application/json' \
--header 'Authorization: Basic aWRzVXNlcjpwYXNzd29yZA==' \
--data-raw '{
	"multipart": "form",
	"Forward-To": "https://ecc-provider:8889/data",
	"messageType": "ContractAgreementMessage",
	"requestedArtifact": "http://w3id.org/engrd/connector/artifact/1",
	"payload" : {{contract_agreement}}
}'
```

</details>

When following request is sent, response will be MessageProcessedNotificationMessage. This means that contracts have exchanged and have been uploaded to Usage Control DataApp.\
You can also check the Usage Control logs that the policy has been updated.

