### Contract Request Message <a href="#contract_request_message" id="contract_request_message"></a>

Contract Request Message is initial message sent in Contract Negotiation flow. It can contain requestedElement, if we know what artifact we are requesting, or without it, if we need to get whole self description document, and then analyze it and get element we are looking for.

<details>

<summary>Multipart form - Contract Request Message</summary>

```
curl --location --request POST 'https://localhost:8184/proxy' \
--header 'Content-Type: application/json' \
--header 'Authorization: Basic Y29ubmVjdG9yOnBhc3N3b3Jk' \
--data-raw '{
"multipart": "form",
"Forward-To": "https://ecc-provider:8889/data",
"messageType": "ContractRequestMessage",
"requestedElement": "http://w3id.org/engrd/connector/artifact/1",
"payload" : xxxxxx
}'
```

</details>

For payload part you need to pass Contract Request from prevoius request or you can use following snippet, but be sure to modify following fields: Permission - @id and target

<details>

<summary>Contract Request Payload part</summary>

```
{
	"@context": {
		"ids": "https://w3id.org/idsa/core/",
		"idsc": "https://w3id.org/idsa/code/"
	},
	"@type": "ids:ContractRequest",
	"@id": "https://w3id.org/idsa/autogen/contractRequest/46863e9c-e7ce-4041-959c-11b317a10c5c",
	"ids:permission": [
		{
			"@type": "ids:Permission",
			"@id": "https://w3id.org/idsa/autogen/permission/57c1728b-788d-4b80-ae1d-02a7d46eb1a0",
			"ids:target": {
				"@id": "http://w3id.org/engrd/connector/artifact/1"
			},
			"ids:assignee": [],
			"ids:assigner": [],
			"ids:action": [
				{
					"@id": "https://w3id.org/idsa/code/USE"
				}
			],
			"ids:preDuty": [],
			"ids:postDuty": [],
			"ids:constraint": [
				{
					"@type": "ids:Constraint",
					"@id": "https://w3id.org/idsa/autogen/constraint/07f7dd8b-0b47-46e9-8d25-7205ea243de9",
					"ids:leftOperand": {
						"@id": "https://w3id.org/idsa/code/POLICY_EVALUATION_TIME"
					},
					"ids:operator": {
						"@id": "https://w3id.org/idsa/code/AFTER"
					},
					"ids:rightOperand": {
						"@value": "2022-06-20T09:43:49Z",
						"@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
					},
					"ids:pipEndpoint": {
						"@id": "http://pip.endpoint.after"
					}
				},
				{
					"@type": "ids:Constraint",
					"@id": "https://w3id.org/idsa/autogen/constraint/5832a389-9af1-4e2f-9ab4-038ac5db0091",
					"ids:leftOperand": {
						"@id": "https://w3id.org/idsa/code/POLICY_EVALUATION_TIME"
					},
					"ids:operator": {
						"@id": "https://w3id.org/idsa/code/BEFORE"
					},
					"ids:rightOperand": {
						"@value": "2022-07-27T09:43:49Z",
						"@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
					},
					"ids:pipEndpoint": {
						"@id": "http://pip.endpoint.before"
					}
				}
			],
			"ids:description": [],
			"ids:title": []
		}
	],
	"ids:provider": {
		"@id": "http://w3id.org/engrd/connector/provider"
	},
	"ids:obligation": [],
	"ids:prohibition": [],
	"ids:consumer": {
		"@id": "http://w3id.org/engrd/connector/consumer"
	}
}
```

</details>

If everything goes well, you will get response with body containing "@type" : "ids:ContractAgreementMessage" and payload containing "@type": "ids:ContractAgreement", as shown in example response.

<details>

<summary>Contract Request Message - Response example</summary>

```
--P4P0K6voLPRtGGaDtazTYLsuN7E7OXJ
Content-Disposition: form-data; name="header"
Content-Length: 2599
Content-Type: application/ld+json

{
  "@context" : {
    "ids" : "https://w3id.org/idsa/core/",
    "idsc" : "https://w3id.org/idsa/code/"
  },
  "@type" : "ids:ContractAgreementMessage",
  "@id" : "https://w3id.org/idsa/autogen/contractAgreementMessage/c669ffe6-7716-4c43-8930-fa4ac5b9abde",
  "ids:issuerConnector" : {
    "@id" : "http://w3id.org/engrd/connector/provider"
  },
  "ids:senderAgent" : {
    "@id" : "http://w3id.org/engrd/connector/provider"
  },
  "ids:securityToken" : {
    "@type" : "ids:DynamicAttributeToken",
    "@id" : "https://w3id.org/idsa/autogen/dynamicAttributeToken/ee2b22ee-31c3-433b-8ed6-3c53c0d8d9db",
    "ids:tokenValue" : "DUMMY_TOKEN_VALUE",
    "ids:tokenFormat" : {
      "@id" : "https://w3id.org/idsa/code/JWT"
    }
  },
  "ids:modelVersion" : "4.1.0",
  "ids:issued" : {
    "@value" : "2022-06-27T10:09:40.985Z",
    "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
  },
  "ids:correlationMessage" : {
    "@id" : "https://w3id.org/idsa/autogen/contractRequestMessage/f9bd01c6-dd10-4cd5-9c1f-7854bcb06ef5"
  },
  "ids:recipientConnector" : [ {
    "@id" : "http://w3id.org/engrd/connector/consumer"
  } ],
  "ids:recipientAgent" : [ ]
}
--P4P0K6voLPRtGGaDtazTYLsuN7E7OXJ
Content-Disposition: form-data; name="payload"
Content-Length: 2351

{
  "@context" : {
    "ids" : "https://w3id.org/idsa/core/",
    "idsc" : "https://w3id.org/idsa/code/"
  },
  "@type" : "ids:ContractAgreement",
  "@id" : "https://w3id.org/idsa/autogen/contractAgreement/7dacb032-ed43-4492-b76f-ff637fb2d417",
  "ids:permission" : [ {
    "@type" : "ids:Permission",
    "@id" : "https://w3id.org/idsa/autogen/permission/57c1728b-788d-4b80-ae1d-02a7d46eb1a0",
    "ids:target" : {
      "@id" : "http://w3id.org/engrd/connector/artifact/1"
    },
    "ids:assignee" : [ ],
    "ids:assigner" : [ ],
    "ids:action" : [ {
      "@id" : "https://w3id.org/idsa/code/USE"
    } ],
    "ids:preDuty" : [ ],
    "ids:postDuty" : [ ],
    "ids:constraint" : [ {
      "@type" : "ids:Constraint",
      "@id" : "https://w3id.org/idsa/autogen/constraint/07f7dd8b-0b47-46e9-8d25-7205ea243de9",
      "ids:leftOperand" : {
        "@id" : "https://w3id.org/idsa/code/POLICY_EVALUATION_TIME"
      },
      "ids:operator" : {
        "@id" : "https://w3id.org/idsa/code/AFTER"
      },
      "ids:rightOperand" : {
        "@value" : "2022-06-20T09:43:49Z",
        "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
      },
      "ids:pipEndpoint" : {
        "@id" : "http://pip.endpoint.after"
      }
    }, {
      "@type" : "ids:Constraint",
      "@id" : "https://w3id.org/idsa/autogen/constraint/5832a389-9af1-4e2f-9ab4-038ac5db0091",
      "ids:leftOperand" : {
        "@id" : "https://w3id.org/idsa/code/POLICY_EVALUATION_TIME"
      },
      "ids:operator" : {
        "@id" : "https://w3id.org/idsa/code/BEFORE"
      },
      "ids:rightOperand" : {
        "@value" : "2022-07-27T09:43:49Z",
        "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
      },
      "ids:pipEndpoint" : {
        "@id" : "http://pip.endpoint.before"
      }
    } ],
    "ids:description" : [ ],
    "ids:title" : [ ]
  } ],
  "ids:provider" : {
    "@id" : "http://w3id.org/engrd/connector/provider"
  },
  "ids:contractStart" : {
    "@value" : "2022-06-27T09:42:41.996Z",
    "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
  },
  "ids:contractDate" : {
    "@value" : "2022-06-27T09:43:49.320Z",
    "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
  },
  "ids:consumer" : {
    "@id" : "http://w3id.org/engrd/connector/consumer"
  },
  "ids:prohibition" : [ ],
  "ids:obligation" : [ ]
}
--P4P0K6voLPRtGGaDtazTYLsuN7E7OXJ--
```

</details>
