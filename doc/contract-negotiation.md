## Contract Negotiation - simple flow <a href="#contractnegotiation" id="contractnegotiation"></a>

Usage Control is disabled by default. If you want to enable it (mandatory for contract negotiation), please check ["Enabling usage control"](advanced-configuration.md#usage-control-).

If mandatory, for other connectors, you can perform contract negotiation with other connector (not TRUE Connector) or with TRUE Connector. There is default contract offer that will be sent if ContractRequestMessage is received. It will allow consuming of resource.

Assuming you are running docker instance on local machine. If not, please update hostname to match your scenario.

You can use provided [Postman collection](TRUEConnector.postman\_collection.json) and [Postman environment](TRUEConnector\_enviroment.postman\_environment.json); import both files into Postman and perform Contract Negotiation automatically or do this step by step, as described below.

![TRUE Connector Postman](TRUEConnector\_Postman.jpg)

### Get offered resource <a href="#get_offered_resource" id="get_offered_resource"></a>

In order to get resource that TRUE Connector offers, you need to send ArtifactRequestMessage to B-endpoint.

We can query the resource with ArtifactRequestMessage:

<details>

<summary>Multipart form - Artifact Request Message</summary>

```
curl --location --request POST 'https://localhost:8084/proxy' \
--header 'Content-Type: application/json' \
--header 'Authorization: Basic Y29ubmVjdG9yOnBhc3N3b3Jk' \
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

### Description Request Message <a href="#description_request_message" id="description_request_message"></a>

Before start of negotiation process, Description Request Message is sent to identify the actors and potentialy deny access if Dynamic Attribute Token (DAT) is not valid. Initially, Description Request Message is sent by consumer without payload.

<details>

<summary>Multipart form - Description Request Message</summary>

```
curl --location --request POST 'https://localhost:8084/proxy' \
--header 'Content-Type: application/json' \
--header 'Authorization: Basic Y29ubmVjdG9yOnBhc3N3b3Jk' \
--data-raw '{
	"multipart": "form",
	"Forward-To": "https://ecc-provider:8889/data",
	"messageType":"DescriptionRequestMessage"
}'
```

</details>

If DAT is invalid, Provider sents RejectionMessage with optional reason. However, if DAT is valid, SelfDescriptionResponse is being sent to Consumer with similar content:

<details>

<summary>Description Request Message - Response example</summary>

```
--dd8poS2Z0x4yMG0zN4LBBbNn6lKINE192Dpsz
Content-Disposition: form-data; name="header"
Content-Length: 1157
Content-Type: application/ld+json

{
  "@context" : {
	"ids" : "https://w3id.org/idsa/core/",
	"idsc" : "https://w3id.org/idsa/code/"
  },
  "@type" : "ids:DescriptionResponseMessage",
  "@id" : "https://w3id.org/idsa/autogen/descriptionResponseMessage/0d6796c9-b4ca-4314-9641-96731d29471d",
  "ids:securityToken" : {
	"@type" : "ids:DynamicAttributeToken",
	"@id" : "https://w3id.org/idsa/autogen/dynamicAttributeToken/43f60b53-cba1-4aeb-b308-8979950d256f",
	"ids:tokenValue" : "DummyTokenValue",
	"ids:tokenFormat" : {
	  "@id" : "https://w3id.org/idsa/code/JWT"
	}
  },
  "ids:senderAgent" : {
	"@id" : "https://w3id.org/engrd/connector/provider"
  },
  "ids:issuerConnector" : {
	"@id" : "https://w3id.org/engrd/connector/provider"
  },
  "ids:modelVersion" : "4.1.0",
  "ids:issued" : {
	"@value" : "2021-12-09T13:50:03.883Z",
	"@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
  },
  "ids:correlationMessage" : {
	"@id" : "https://w3id.org/idsa/autogen/descriptionRequestMessage/8405b08f-4c93-4082-b22c-a07ba4e74753"
  },
  "ids:recipientConnector" : [ {
	"@id" : "http://w3id.org/engrd/connector/consumer"
  } ],
  "ids:recipientAgent" : [ ]
}
--dd8poS2Z0x4yMG0zN4LBBbNn6lKINE192Dpsz
Content-Disposition: form-data; name="payload"
Content-Length: 6068

{
  "@context" : {
	"ids" : "https://w3id.org/idsa/core/",
	"idsc" : "https://w3id.org/idsa/code/"
  },
  "@type" : "ids:BaseConnector",
  "@id" : "https://w3id.org/engrd/connector/provider",
  "ids:resourceCatalog" : [ {
	"@type" : "ids:ResourceCatalog",
	"@id" : "https://w3id.org/idsa/autogen/resourceCatalog/ba0987f6-f86e-4c9b-a6b1-020b3babf285",
	"ids:offeredResource" : [ {
	  "@type" : "ids:TextResource",
	  "@id" : "https://w3id.org/idsa/autogen/textResource/b8a9b5ae-2348-4b5d-b089-2dbeed833d52",
	  "ids:language" : [ {
		"@id" : "https://w3id.org/idsa/code/EN"
	  }, {
		"@id" : "https://w3id.org/idsa/code/IT"
	  } ],
	  "ids:version" : "1.0.0",
	  "ids:resourcePart" : [ ],
	  "ids:resourceEndpoint" : [ ],
	  "ids:contractOffer" : [ {
		"@type" : "ids:ContractOffer",
		"@id" : "https://w3id.org/idsa/autogen/contractOffer/0ae8d88e-0fc2-4065-b2f7-f53e3691114a",
		"ids:permission" : [ {
		  "@type" : "ids:Permission",
		  "@id" : "https://w3id.org/idsa/autogen/permission/d1fc81b0-6a4c-463f-a6f0-3d585b0cc2e2",
		  "ids:target" : {
			"@id" : "http://w3id.org/engrd/connector/artifact/1"
		  },
		  "ids:action" : [ {
			"@id" : "https://w3id.org/idsa/code/USE"
		  } ],
		  "ids:preDuty" : [ ],
		  "ids:postDuty" : [ ],
		  "ids:constraint" : [ {
			"@type" : "ids:Constraint",
			"@id" : "https://w3id.org/idsa/autogen/constraint/396733e0-7977-411a-8599-e96baecc5943",
			"ids:leftOperand" : {
			  "@id" : "https://w3id.org/idsa/code/POLICY_EVALUATION_TIME"
			},
			"ids:operator" : {
			  "@id" : "https://w3id.org/idsa/code/BEFORE"
			},
			"ids:rightOperand" : {
			  "@value" : "2022-12-31T13:48:40Z",
			  "@type" : "http://www.w3.org/2001/XMLSchema#datetime"
			}
		  }, {
			"@type" : "ids:Constraint",
			"@id" : "https://w3id.org/idsa/autogen/constraint/7d544cd2-27b2-4119-b12a-19fc0ec924ce",
			"ids:leftOperand" : {
			  "@id" : "https://w3id.org/idsa/code/POLICY_EVALUATION_TIME"
			},
			"ids:operator" : {
			  "@id" : "https://w3id.org/idsa/code/AFTER"
			},
			"ids:rightOperand" : {
			  "@value" : "2022-01-01T13:48:40Z",
			  "@type" : "http://www.w3.org/2001/XMLSchema#datetime"
			}
		  } ],
		  "ids:description" : [ ],
		  "ids:title" : [ ]
		} ],
		"ids:provider" : {
		  "@id" : "https://w3id.org/engrd/connector/provider"
		},
		"ids:contractDate" : {
		  "@value" : "2022-06-27T13:48:41.493Z",
		  "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
		},
		"ids:contractStart" : {
       "@value" : "2022-06-27T09:42:41.996Z",
       "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
      },
		"ids:prohibition" : [ ],
		"ids:obligation" : [ ]
	  } ],
	  "ids:paymentModality" : [ ],
	  "ids:sample" : [ ],
	  "ids:contentPart" : [ ],
	  "ids:representation" : [ {
		"@type" : "ids:TextRepresentation",
		"@id" : "https://w3id.org/idsa/autogen/textRepresentation/2d00b3ae-c276-4ba5-932f-35aabcdf3dd8",
		"ids:instance" : [ {
		  "@type" : "ids:Artifact",
		  "@id" : "http://w3id.org/engrd/connector/artifact/1",
		  "ids:creationDate" : {
			"@value" : "2021-12-09T13:48:39.458Z",
			"@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
		  }
		} ],
		"ids:language" : {
		  "@id" : "https://w3id.org/idsa/code/EN"
		},
		"ids:created" : {
		  "@value" : "2021-12-09T13:48:41.871Z",
		  "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
		}
	  } ],
	  "ids:defaultRepresentation" : [ ],
	  "ids:theme" : [ ],
	  "ids:keyword" : [ {
		"@value" : "Engineering Ingegneria Informatica SpA",
		"@type" : "http://www.w3.org/2001/XMLSchema#string"
	  }, {
		"@value" : "TRUEConnector",
		"@type" : "http://www.w3.org/2001/XMLSchema#string"
	  } ],
	  "ids:temporalCoverage" : [ ],
	  "ids:spatialCoverage" : [ ],
	  "ids:modified" : {
		"@value" : "2021-12-09T13:48:40.964Z",
		"@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
	  },
	  "ids:description" : [ {
		"@value" : "Default resource description",
		"@type" : "http://www.w3.org/2001/XMLSchema#string"
	  } ],
	  "ids:title" : [ {
		"@value" : "Default resource",
		"@type" : "http://www.w3.org/2001/XMLSchema#string"
	  } ],
	  "ids:created" : {
		"@value" : "2021-12-09T13:48:40.964Z",
		"@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
	  },
	  "ids:contentType" : {
		"@id" : "https://w3id.org/idsa/code/SCHEMA_DEFINITION"
	  }
	} ],
	"ids:requestedResource" : [ ]
  } ],
  "ids:description" : [ {
	"@value" : "Data Provider Connector description",
	"@type" : "http://www.w3.org/2001/XMLSchema#string"
  } ],
  "ids:title" : [ {
	"@value" : "Data Provider Connector title",
	"@type" : "http://www.w3.org/2001/XMLSchema#string"
  } ],
  "ids:maintainer" : {
	"@id" : "http://provider.maintainerURI.com"
  },
  "ids:curator" : {
	"@id" : "http://provider.curatorURI.com"
  },
  "ids:inboundModelVersion" : [ "4.1.0" ],
  "ids:outboundModelVersion" : "4.1.0",
  "ids:hasEndpoint" : [ ],
  "ids:hasDefaultEndpoint" : {
	"@type" : "ids:ConnectorEndpoint",
	"@id" : "https://178.148.148.139:8090/",
	"ids:accessURL" : {
	  "@id" : "https://178.148.148.139:8090/"
	},
	"ids:endpointInformation" : [ ],
	"ids:endpointDocumentation" : [ ]
  },
  "ids:extendedGuarantee" : [ ],
  "ids:hasAgent" : [ ],
  "ids:securityProfile" : {
	"@id" : "https://w3id.org/idsa/code/BASE_SECURITY_PROFILE"
  }
}
--dd8poS2Z0x4yMG0zN4LBBbNn6lKINE192Dpsz--
```

</details>

If the incoming message is assumed trustworthy, the Provider answers with an IDS SelfDescriptionResponse. During the establishment phase of the negotiation, this message contains the currently valid SelfDescription of Provider in JSON-LD, including its provided IDS Resources and respective ContractOffers. Note that the connector is not obliged to provide ContractOffers for any/all resources but can also only announce their existence. The usage conditions might be sensitive too and do not need to be supplied. However, the provisioning of ContractOffers eases their usage and therefore should be in the interest of a Data Provider.

### Contract Request Message <a href="#contract_request_message" id="contract_request_message"></a>

Contract Request Message is initial message sent in Contract Negotiation flow. It can contain requestedElement, if we know what artifact we are requesting, or without it, if we need to get whole self description document, and then analyze it and get element we are looking for.

<details>

<summary>Multipart form - Contract Request Message</summary>

```
curl --location --request POST 'https://localhost:8084/proxy' \
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

### Contract Agreement request <a href="#contract_agreement_request" id="contract_agreement_request"></a>

**NOTE**: Payload part must be replaced with value you have received from previous response. **NOTE**: Be sure to check the end date.

<details>

<summary>Multipart form - Contract Agreement request</summary>

```
curl --location --request POST 'https://localhost:8084/proxy' \
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

### Get offered resource after access is granted <a href="#get_offered_resource_granted" id="get_offered_resource_granted"></a>

When you have finished negotiation, you can query for resource again to see if we get artifact data.

**NOTE**: Be sure to replace value for transferContract with correct value - it should be contractAgreement id. You can get it from the step Contract Agreement request, the one that is set in payload. (like following: https://w3id.org/idsa/autogen/contractAgreement/7dacb032-ed43-4492-b76f-ff637fb2d417). This value is important, since it it will be used in contract negotiation, to validate against that contract agreement, if consumer can consume artifact.

<details>

<summary>Multipart Form - Artifact Request Message</summary>

```
curl --location --request POST 'http://localhost:8084/proxy' \
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