### Description Request Message <a href="#description_request_message" id="description_request_message"></a>

Before start of negotiation process, Description Request Message is sent to identify the actors and potentialy deny access if Dynamic Attribute Token (DAT) is not valid. Initially, Description Request Message is sent by consumer without payload.

<details>

<summary>Multipart form - Description Request Message</summary>

```
curl --location --request POST 'https://localhost:8184/proxy' \
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
