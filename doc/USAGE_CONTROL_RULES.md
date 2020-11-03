#Usage control examples

##Time-Based Interval Rule

The following rule describes the time interval in which it is allowed to access the resource with a specific identifier defined using the “target” property of the rule.

The snippet below is located an example of time-based rule: leftOperand is the start date and rightOperand represents the end date, in the specific case the message can be consumed only from 1st October 2020 to 31st of October 2020.

```
{
	"@context": "http://www.w3.org/ns/odrl.jsonld",
	"@type": "ids:ContractAgreement",
	"uid": "http://example.com/policy/restrict-access-interval",
	"profile": "http://example.com/ids-profile",
	"target": "http://mdm-connector.ids.isst.fraunhofer.de/artifact/1",
	"provider": "http://example.com/party/my-party",
	"consumer": "http://example.com/party/consumer-party",
	"permission": [{
			"action": "ids:use",
			"constraint": [{
					"leftOperand": "ids:datetime",
					"operator": "gt",
					"rightOperand": {
						"@value": "2020-10-01T00:00:00Z",
						"@type": "xsd:datetime"
					}
				},
				{
					"leftOperand": "ids:datetime",
					"operator": "lt",
					"rightOperand": {
						"@value": "2020-10-31T23:59:59Z",
						"@type": "xsd:datetime"
					}
				}]
		}]
}
```

##Modifier Rule

### Anonymize
The following rule describes an example of modifier rule, anonymize, which will modify the payload response using json path. The current limitation is that the payload must be json string in order to be able to apply rules with modifiers.

In the snippet below is located an example of modifier rule: replaceWith filed tells which string will be used to replace the current value (dateOfBirth will be replaced with xxxx).

```
{
	"@context": "http://www.w3.org/ns/odrl.jsonld",
	"@type": "ids:ContractAgreement",
	"uid": "http://example.com/policy/anonymize-in-transit",
	"profile": "http://example.com/ids-profile",
	"target": "http://mdm-connector.ids.isst.fraunhofer.de/artifact/2",
	"provider": "http://example.com/party/my-party",
	"consumer": "http://example.com/party/consumer-party",
	"permission": [
		{
			"action": "ids:use",
			"preobligation": [{
					"action": [{
							"rdf:value": {
								"@id": "ids:anonymize"
							},
							"refinement": [
								{
									"leftOperand": "ids:modificationMethod",
									"operator": "eq",
									"rightOperand": {
										"@value": "http://example.com/anonymize/replace",
										"@type": "xsd:anyURI"
									},
									"replaceWith": {
										"@value": "xxxx",
										"@type": "xsd:string"
									},
									"jsonPath": "$.dateOfBirth"
								}]
						}]
				}]
		}]
}
```

Example of payload, on which policy will be applied:

```
{
   "firstName":"John",
   "lastName":"Doe",
   "address":"591  Franklin Street, Pennsylvania",
   "checksum":"ABC123 2020/11/03 11:56:25",
   "dateOfBirth":"2020/11/03 11:56:25"
}
```

Palyoad after policy is applied:

```
{
   "firstName":"John",
   "lastName":"Doe",
   "address":"591  Franklin Street, Pennsylvania",
   "checksum":"ABC123 2020/11/03 11:56:25",
   "dateOfBirth":"xxxx"
}
```

### Delete
The following rule describes another example of modifier rule, delete, which will modify the payload response, removing the specified entry from the payload (defined through the jsonPath property). The current limitation is that payload must be a json string in order to be able to apply rules based on modifiers.

In the snippet below is located a running example of modifier rule: the jsonPath field will be used to evaluate and remove following the specified object (dateOfBirth) from the payload.

```
{
	"@context": "http://www.w3.org/ns/odrl.jsonld",
	"@type": "ids:ContractAgreement",
	"uid": "http://example.com/policy/anonymize-in-transit-delete",
	"profile": "http://example.com/ids-profile",
	"target": "http://mdm-connector.ids.isst.fraunhofer.de/artifact/3",
	"provider": "http://example.com/party/my-party",
	"consumer": "http://example.com/party/consumer-party",
	"permission": [{
			"action": "ids:use",
			"preobligation": [{
					"action": [{
							"rdf:value": {
								"@id": "ids:anonymize"
							},
							"refinement": [
								{
									"leftOperand": "ids:modificationMethod",
									"operator": "eq",
									"rightOperand": {
										"@value": "http://example.com/anonymize/delete",
										"@type": "xsd:anyURI"
									},
									"jsonPath": "$.dateOfBirth"
								}]
						}]
				}]
		}]
}

```

Example of payload, on which policy will be applied:

```
{
   "firstName":"John",
   "lastName":"Doe",
   "address":"591  Franklin Street, Pennsylvania",
   "checksum":"ABC123 2020/11/03 11:56:25",
   "dateOfBirth":"2020/11/03 11:56:25"
}
```
Palyoad after policy is applied:

```
{
   "firstName":"John",
   "lastName":"Doe",
   "address":"591  Franklin Street, Pennsylvania",
   "checksum":"ABC123 2020/11/03 11:56:25"
}
```

## Spatial-Based Rule - Location

The following rule describes a location-based rule, which allows or inhibits the usage of resources with id defined in the target property based on connector location (country).

The snippet below is located an example of spatial-based rule: the rightOperand contains value IT, which tells that the resource can be consumed only by connectors that are located in Italy


```
{
	"@context": "http://www.w3.org/ns/odrl.jsonld",
	"@type": "ids:ContractAgreement",
	"uid": "http://example.com/policy/restrict-access-location",
	"profile": "http://example.com/ids-profile",
	"target": "http://mdm-connector.ids.isst.fraunhofer.de/artifact/4",
	"provider": "http://example.com/party/my-party",
	"consumer": "http://example.com/party/consumer-party",
	"permission": [{
			"action": "ids:use",
			"constraint": [{
					"leftOperand": "https://w3id.org/idsa/core/absoluteSpatialPosition",
					"operator": "eq",
					"rightOperand": {
						"@value": "IT",
						"@type": "xsd:anyURI"
					}
				}]
		}]
}
```

##Purpose-Based Rule

The purpose-based class of rules allows or inhibits the usage of resources with an identifier defined in the target property based on message purpose.

In the snippet below is located an example of spatial-based rule: the rightOperand contains the value http://example.com/ids-purpose:Marketing, which tells that the resource is available for messages that have a purpose defined as Marketing.

```
{
	"@context": "http://www.w3.org/ns/odrl.jsonld",
	"@type": "ids:ContractAgreement",
	"uid": "http://example.com/policy/restrict-access-purpose",
	"profile": "http://example.com/ids-profile",
	"target": "http://mdm-connector.ids.isst.fraunhofer.de/artifact/5",
	"provider": "http://example.com/party/my-party",
	"consumer": "http://example.com/party/consumer-party",
	"permission": [{
			"action": "ids:use",
			"constraint": [{
					"leftOperand": "https://w3id.org/idsa/core/purpose",
					"operator": "eq",
					"rightOperand": {
						"@value": "http://example.com/ids-purpose:Marketing",
						"@type": "xsd:anyURI"
					}
				}]
		}]
}
```

##Complex Rule

Rules can be composed in order to create complex permission definitions. The following rule describes a complex based rule, which contains 3 simple rules: spatial, purpose and time interval based. All those simple rules must be evaluated as true in order to allow the usage of the resource. If any of the simple rules is evaluated as false, then the resource usage is inhibited.

In the snippet below is located an example of the complex rule: spatial rule defines that the connector must be in Italy, the purpose-based one defines that the message purpose must be http://example.com/ids-purpose:Marketing and time base rule defines that the resource can be consumed only from October 1st, 2020, until October 31st, 2020.

```
{
   "@context":"http://www.w3.org/ns/odrl.jsonld",
   "@type":"ids:ContractAgreement",
   "uid":"http://example.com/policy/complex-policy",
   "profile":"http://example.com/ids-profile",
   "target":"http://mdm-connector.ids.isst.fraunhofer.de/artifact/6",
   "provider":"http://example.com/party/my-party",
   "consumer":"http://example.com/party/consumer-party",
   "permission":[{
         "action":"ids:use",
         "constraint":[{
               "leftOperand":"https://w3id.org/idsa/core/absoluteSpatialPosition",
               "operator":"eq",
               "rightOperand":{
                  "@value":"IT",
                  "@type":"xsd:anyURI"
               }
            },
            {
               "leftOperand":"https://w3id.org/idsa/core/purpose",
               "operator":"eq",
               "rightOperand":{
                  "@value":"http://example.com/ids-purpose:Marketing",
                  "@type":"xsd:anyURI"
               }
            },
            {
               "leftOperand":"ids:datetime",
               "operator":"gt",
               "rightOperand":{
                  "@value":"2020-10-01T00:00:00Z",
                  "@type":"xsd:datetime"
               }
            },
            {
               "leftOperand":"ids:datetime",
               "operator":"lt",
               "rightOperand":{
                  "@value":"2020-10-31T00:00:00Z",
                  "@type":"xsd:datetime"
               }
            }]
      }]
}
```

