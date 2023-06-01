### Contract Agreement request <a href="#contract_agreement_request" id="contract_agreement_request"></a>

**NOTE**: Payload part must be replaced with value you have received from previous response. **NOTE**: Be sure to check the end date.

<details>

<summary>Multipart form - Contract Agreement request</summary>

```
curl --location --request POST 'https://localhost:8184/proxy' \
--header 'Content-Type: application/json' \
--header 'Authorization: Basic Y29ubmVjdG9yOnBhc3N3b3Jk' \
--data-raw '{
	"multipart": "form",
	"Forward-To": "https://ecc-provider:8889/data",
	"messageType": "ContractAgreementMessage",
	"requestedArtifact": "http://w3id.org/engrd/connector/artifact/1",
	"payload" : xxxxxx
}'
```

</details>

When following request is sent, response will be MessageProcessedNotificationMessage, without payload. This meands that contracts have exchanged and have been uploaded to Usage Control DataApp.\
You can also check the Usage Control logs that the policy has been updated.

<details>

<summary>Contract Request Message - Response example</summary>

```
--folW-L7KK2Sr0wN8b-ayPRgRB3QIh6-NC
Content-Disposition: form-data; name="header"
Content-Length: 1174
Content-Type: application/ld+json

{
  "@context" : {
	"ids" : "https://w3id.org/idsa/core/",
	"idsc" : "https://w3id.org/idsa/code/"
  },
  "@type" : "ids:MessageProcessedNotificationMessage",
  "@id" : "https://w3id.org/idsa/autogen/messageProcessedNotificationMessage/0fdd95e5-5c40-445c-8a51-96a618efa4a9",
  "ids:securityToken" : {
	"@type" : "ids:DynamicAttributeToken",
	"@id" : "https://w3id.org/idsa/autogen/dynamicAttributeToken/277438fb-995c-43b0-96c5-84051b4c8150",
	"ids:tokenValue" : "DummyTokenValue",
	"ids:tokenFormat" : {
	  "@id" : "https://w3id.org/idsa/code/JWT"
	}
  },
  "ids:issuerConnector" : {
	"@id" : "https://w3id.org/engrd/connector/provider"
  },
  "ids:senderAgent" : {
	"@id" : "https://w3id.org/engrd/connector/provider"
  },
  "ids:modelVersion" : "4.1.0",
  "ids:issued" : {
	"@value" : "2021-12-03T16:40:27.269Z",
	"@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
  },
  "ids:recipientConnector" : [ {
	"@id" : "http://w3id.org/engrd/connector"
  } ],
  "ids:recipientAgent" : [ ],
  "ids:correlationMessage" : {
	"@id" : "https://w3id.org/idsa/autogen/contractAgreementMessage/501a66cb-3f63-46f6-be43-61cbde077c8a"
  }
}
--folW-L7KK2Sr0wN8b-ayPRgRB3QIh6-NC--
```

</details>
