### Get offered resource after access is granted <a href="#get_offered_resource_granted" id="get_offered_resource_granted"></a>

When you have finished negotiation, you can query for resource again to see if we get artifact data.

**NOTE**: Be sure to replace value for transferContract with correct value - it should be contractAgreement id. You can get it from the step Contract Agreement request, the one that is set in payload. (like following: https://w3id.org/idsa/autogen/contractAgreement/7dacb032-ed43-4492-b76f-ff637fb2d417). This value is important, since it it will be used in contract negotiation, to validate against that contract agreement, if consumer can consume artifact.

<details>

<summary>Multipart Form - Artifact Request Message</summary>

```
curl --location --request POST 'http://localhost:8184/proxy' \
--header 'Content-Type: application/json' \
--header 'Authorization: Basic Y29ubmVjdG9yOnBhc3N3b3Jk' \
--data-raw '{
    "multipart": "form",
    "Forward-To": "http://ecc-provider:8889/data",
    "messageType":"ArtifactRequestMessage",
    "requestedArtifact": "http://w3id.org/engrd/connector/artifact/1",
    "transferContract" : "xxxxxx"
}'
```

</details>

If you have done everything correctly, you should get response with requested artifact, like in our example. Expected response is ArtifactResponseMessage, as header, and in payload - json document containing information about requested resource.

<details>

<summary>Artifact Request Message - Example response</summary>

```
--Jg43iZd4C8H3mA96jSHQsSVP_HdzROIqTkFz
Content-Disposition: form-data; name="header"
Content-Length: 2730
Content-Type: application/ld+json

{
  "@context" : {
    "ids" : "https://w3id.org/idsa/core/",
    "idsc" : "https://w3id.org/idsa/code/"
  },
  "@type" : "ids:ArtifactResponseMessage",
  "@id" : "https://w3id.org/idsa/autogen/artifactResponseMessage/d3f76bea-85ea-4e44-bf71-57bdbe8f6234",
  "ids:issuerConnector" : {
    "@id" : "http://w3id.org/engrd/connector/provider"
  },
  "ids:senderAgent" : {
    "@id" : "http://w3id.org/engrd/connector/provider"
  },
  "ids:securityToken" : {
    "@type" : "ids:DynamicAttributeToken",
    "@id" : "https://w3id.org/idsa/autogen/dynamicAttributeToken/e9d90738-7ecf-46a9-83f5-ad5e3752a74b",
    "ids:tokenValue" : "DummyTokenValue",
    "ids:tokenFormat" : {
      "@id" : "https://w3id.org/idsa/code/JWT"
    }
  },
  "ids:modelVersion" : "4.1.0",
  "ids:issued" : {
    "@value" : "2022-06-27T10:17:25.025Z",
    "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
  },
  "ids:correlationMessage" : {
    "@id" : "https://w3id.org/idsa/autogen/artifactRequestMessage/e62e0c02-319b-4aa8-8685-1be59276e596"
  },
  "ids:recipientConnector" : [ {
    "@id" : "http://w3id.org/engrd/connector/consumer"
  } ],
  "ids:recipientAgent" : [ ],
  "ids:transferContract" : {
    "@id" : "https://w3id.org/idsa/autogen/contractAgreement/7dacb032-ed43-4492-b76f-ff637fb2d417"
  }
}
--Jg43iZd4C8H3mA96jSHQsSVP_HdzROIqTkFz
Content-Disposition: form-data; name="payload"
Content-Length: 160

{"firstName":"John","lastName":"Doe","address":"591  Franklin Street, Pennsylvania","checksum":"ABC123 2022/06/27 12:17:25","dateOfBirth":"2022/06/27 12:17:25"}
--Jg43iZd4C8H3mA96jSHQsSVP_HdzROIqTkFz--
```

</details>

The appeariance of "John Doe" signifies the successful exchange with this contract.