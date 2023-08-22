### Contract Request Message <a href="#contract_request_message" id="contract_request_message"></a>

Contract Request Message is initial message sent in Contract Negotiation flow. It can contain requestedElement, if we know what artifact we are requesting, or without it, if we need to get whole self description document, and then analyze it and get element we are looking for.

<details>

<summary>Multipart form - Contract Request Message</summary>

```
curl --location -k --request POST 'https://localhost:8184/proxy' \
--header 'Content-Type: application/json' \
--header 'Authorization: Basic aWRzVXNlcjpwYXNzd29yZA==' \
--data-raw '{
	"multipart": "form",
	"Forward-To": "https://ecc-provider:8889/data",
	"messageType": "ContractRequestMessage",
	"requestedElement": "http://w3id.org/engrd/connector/artifact/1",
	"payload" : {
        "@context": {
            "ids": "https://w3id.org/idsa/core/",
            "idsc": "https://w3id.org/idsa/code/"
        },
        "@type": "ids:ContractRequest",
        "@id": "{{contract_id}}",
        "ids:permission": [
            {{contract_permission}}
        ],
        "ids:provider": {
            "@id": "{{contract_provider}}"
        },
        "ids:obligation": [],
        "ids:prohibition": [],
        "ids:consumer": {
            "@id": "http://w3id.org/engrd/connector/consumer"
        }
    }
}'
```

</details>

For payload part placeholders, Postman collection will preset required fields from previous request.

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

If everything goes well, you will get response with "ids:ContractAgreement", as shown in example response.

<details>

<summary>Contract Request Message - Response example</summary>

```
{
    "@context": {
        "ids": "https://w3id.org/idsa/core/",
        "idsc": "https://w3id.org/idsa/code/"
    },
    "@type": "ids:ContractAgreement",
    "@id": "https://w3id.org/idsa/autogen/contractAgreement/1150fc17-dd70-41a9-9f5a-7e26ce082018",
    "ids:contractStart": {
        "@value": "2023-06-27T09:51:29.638Z",
        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
    },
    "ids:contractDate": {
        "@value": "2023-06-27T09:51:29.620Z",
        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
    },
    "ids:consumer": {
        "@id": "http://w3id.org/engrd/connector/consumer"
    },
    "ids:provider": {
        "@id": "http://w3id.org/engrd/connector/provider"
    },
    "ids:permission": [
        {
            "@type": "ids:Permission",
            "@id": "https://w3id.org/idsa/autogen/permission/f04e78e7-3808-404d-8436-d7f7c264f307",
            "ids:action": [
                {
                    "@id": "https://w3id.org/idsa/code/USE"
                }
            ],
            "ids:title": [
                {
                    "@value": "Example Usage Policy",
                    "@type": "http://www.w3.org/2001/XMLSchema#string"
                }
            ],
            "ids:description": [
                {
                    "@value": "provide-access",
                    "@type": "http://www.w3.org/2001/XMLSchema#string"
                }
            ],
            "ids:target": {
                "@id": "http://w3id.org/engrd/connector/artifact/1"
            }
        }
    ]
}
```

</details>
