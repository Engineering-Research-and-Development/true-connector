# Self Description examples

The TRUE Connector will search for a Self Description document, by default named self_description.json, provided in the following property:

```
application.selfdescription.filelocation=
```

The same thing goes for persisting, the Connector will save the document in the location provided by the previous property named self_description.json.

The Self Description logic can be accessed directly or by using the SwaggerUI

```
https://{IPADDRESS}:{SELF_DESCRIPTION_PORT}/swagger-ui/index.html
```

and should look like this:

![SwaggerUI Home](doc/Swagger_Home.png?raw=true "SwaggerUI Home")


## Getting the Self Description

In order to get the Self Description you can send the following request:

```
curl -X GET "https://{IPADDRESS}:{SELF_DESCRIPTION_PORT}/api/selfDescripton/" -H  "accept: application/json"
```

![Self Description Controller](doc/Self_Description_Controller.png?raw=true "Self Description Controller")

The response should be something like this:

```
{
  "@context": {
    "xsd": "http://www.w3.org/2001/XMLSchema#",
    "ids": "https://w3id.org/idsa/core/",
    "idsc": "https://w3id.org/idsa/code/"
  },
  "@type": "ids:BaseConnector",
  "@id": "https://w3id.org/engrd/connector/",
  "ids:description": [
    {
      "@value": "Sender Connector description",
      "@type": "http://www.w3.org/2001/XMLSchema#string"
    }
  ],
  "ids:hasEndpoint": [],
  "ids:resourceCatalog": [
    {
      "@type": "ids:ResourceCatalog",
      "@id": "https://w3id.org/idsa/autogen/resourceCatalog/d851424b-dd53-497b-900b-11590b00a470",
      "ids:offeredResource": [
        {
          "@type": "ids:TextResource",
          "@id": "https://w3id.org/idsa/autogen/textResource/cfee20f0-61b2-488f-948c-80be743b759d",
          "ids:language": [
            {
              "@id": "https://w3id.org/idsa/code/EN"
            },
            {
              "@id": "https://w3id.org/idsa/code/IT"
            }
          ],
          "ids:version": "1.0.0",
          "ids:description": [
            {
              "@value": "Default resource description",
              "@type": "http://www.w3.org/2001/XMLSchema#string"
            }
          ],
          "ids:contentType": {
            "@id": "https://w3id.org/idsa/code/SCHEMA_DEFINITION"
          },
          "ids:created": {
            "@value": "2022-02-14T14:28:48.837+01:00",
            "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
          },
          "ids:resourcePart": [],
          "ids:contractOffer": [
            {
              "@type": "ids:ContractOffer",
              "@id": "https://w3id.org/idsa/autogen/contractOffer/bdf785b1-d159-4cd8-a21f-1e0104918c20",
              "ids:permission": [
                {
                  "@type": "ids:Permission",
                  "@id": "https://w3id.org/idsa/autogen/permission/ff34445e-d353-4b94-b94d-91cd74b1ad3f",
                  "ids:target": {
                    "@id": "http://w3id.org/engrd/connector/artifact/1"
                  },
                  "ids:description": [],
                  "ids:title": [],
                  "ids:action": [
                    {
                      "@id": "https://w3id.org/idsa/code/USE"
                    }
                  ],
                  "ids:assignee": [
                    {
                      "@id": "https://assignee.com"
                    }
                  ],
                  "ids:assigner": [
                    {
                      "@id": "https://assigner.com"
                    }
                  ],
                  "ids:preDuty": [],
                  "ids:postDuty": [],
                  "ids:constraint": [
                    {
                      "@type": "ids:Constraint",
                      "@id": "https://w3id.org/idsa/autogen/constraint/dca0997c-bbca-4fb8-bf85-667c913c5c73",
                      "ids:rightOperand": {
                        "@value": "2022-02-07T13:28:48Z",
                        "@type": "xsd:datetime"
                      },
                      "ids:leftOperand": {
                        "@id": "https://w3id.org/idsa/code/POLICY_EVALUATION_TIME"
                      },
                      "ids:operator": {
                        "@id": "https://w3id.org/idsa/code/AFTER"
                      }
                    },
                    {
                      "@type": "ids:Constraint",
                      "@id": "https://w3id.org/idsa/autogen/constraint/5a73ad9c-97b2-49b1-9f82-81be5456ec26",
                      "ids:rightOperand": {
                        "@value": "2022-03-14T13:28:48Z",
                        "@type": "xsd:datetime"
                      },
                      "ids:leftOperand": {
                        "@id": "https://w3id.org/idsa/code/POLICY_EVALUATION_TIME"
                      },
                      "ids:operator": {
                        "@id": "https://w3id.org/idsa/code/BEFORE"
                      }
                    }
                  ]
                }
              ],
              "ids:provider": {
                "@id": "https://provider.com"
              },
              "ids:contractDate": {
                "@value": "2022-02-14T14:28:48.898+01:00",
                "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
              },
              "ids:obligation": [],
              "ids:prohibition": [],
              "ids:consumer": {
                "@id": "https://consumer.com"
              }
            }
          ],
          "ids:sample": [],
          "ids:modified": {
            "@value": "2022-02-14T14:28:48.837+01:00",
            "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
          },
          "ids:theme": [],
          "ids:keyword": [
            {
              "@value": "Engineering Ingegneria Informatica SpA",
              "@type": "http://www.w3.org/2001/XMLSchema#string"
            },
            {
              "@value": "TRUEConnector",
              "@type": "http://www.w3.org/2001/XMLSchema#string"
            }
          ],
          "ids:spatialCoverage": [],
          "ids:contentPart": [],
          "ids:representation": [
            {
              "@type": "ids:TextRepresentation",
              "@id": "https://w3id.org/idsa/autogen/textRepresentation/a14f524b-2d5b-488f-a52b-f59bfe4a0c98",
              "ids:instance": [
                {
                  "@type": "ids:Artifact",
                  "@id": "http://w3id.org/engrd/connector/artifact/1",
                  "ids:creationDate": {
                    "@value": "2022-02-14T14:28:48.729+01:00",
                    "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
                  }
                }
              ],
              "ids:language": {
                "@id": "https://w3id.org/idsa/code/EN"
              },
              "ids:created": {
                "@value": "2022-02-14T14:28:48.916+01:00",
                "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
              }
            }
          ],
          "ids:resourceEndpoint": [],
          "ids:defaultRepresentation": [],
          "ids:temporalCoverage": [],
          "ids:title": [
            {
              "@value": "Default resource",
              "@type": "http://www.w3.org/2001/XMLSchema#string"
            }
          ]
        }
      ],
      "ids:requestedResource": []
    }
  ],
  "ids:securityProfile": {
    "@id": "https://w3id.org/idsa/code/BASE_SECURITY_PROFILE"
  },
  "ids:hasAgent": [],
  "ids:extendedGuarantee": [],
  "ids:inboundModelVersion": [
    "4.1.0"
  ],
  "ids:hasDefaultEndpoint": {
    "@type": "ids:ConnectorEndpoint",
    "@id": "https://0.0.0.0:8443/",
    "ids:endpointInformation": [],
    "ids:endpointDocumentation": [],
    "ids:accessURL": {
      "@id": "https://172.19.160.1:8443/"
    }
  },
  "ids:outboundModelVersion": "4.1.0",
  "ids:title": [
    {
      "@value": "Sender Connector title",
      "@type": "http://www.w3.org/2001/XMLSchema#string"
    }
  ],
  "ids:maintainer": {
    "@id": "http://sender.maintainerURI.com"
  },
  "ids:curator": {
    "@id": "http://sender.curatorURI.com"
  }
}
```


## Adding Offered Resource

To add a offered resource to existing resource catalog use the request:

```
curl -X 'POST' \
  'https://{IPADDRESS}:{SELF_DESCRIPTION_PORT}/api/offeredResource/' \
  -H 'accept: application/json' \
  -H 'catalog: https://w3id.org/idsa/autogen/resourceCatalog/bbc379f4-1616-451b-a101-e26ddcd66873' \
  -H 'Content-Type: application/json' \
  -d '{
    "@context": {
        "ids": "https://w3id.org/idsa/core/",
        "idsc": "https://w3id.org/idsa/code/"
    },
    "@type": "ids:TextResource",
    "@id": "https://w3id.org/idsa/autogen/textResource/e60889ba-c4b2-4497-81ff-fee2b26bb69f",
    "ids:language": [{
            "@id": "https://w3id.org/idsa/code/EN"
        }, {
            "@id": "https://w3id.org/idsa/code/IT"
        }
    ],
    "ids:version": "1.0.0",
    "ids:keyword": [{
            "@value": "Engineering Ingegneria Informatica SpA",
            "@type": "http://www.w3.org/2001/XMLSchema#string"
        }, {
            "@value": "TRUEConnector",
            "@type": "http://www.w3.org/2001/XMLSchema#string"
        }
    ],
    "ids:description": [{
            "@value": "Default resource description",
            "@type": "http://www.w3.org/2001/XMLSchema#string"
        }
    ],
    "ids:contentType": {
        "@id": "https://w3id.org/idsa/code/SCHEMA_DEFINITION"
    },
    "ids:created": {
        "@value": "2022-02-22T15:08:37.243Z",
        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
    },
    "ids:theme": [],
    "ids:title": [{
            "@value": "Default resource",
            "@type": "http://www.w3.org/2001/XMLSchema#string"
        }
    ],
    "ids:representation": [{
            "@type": "ids:TextRepresentation",
            "@id": "https://w3id.org/idsa/autogen/textRepresentation/df61c48b-d925-4500-9ea4-c64bd6b31d57",
            "ids:instance": [{
                    "@type": "ids:Artifact",
                    "@id": "http://w3id.org/engrd/connector/artifact/1",
                    "ids:creationDate": {
                        "@value": "2022-02-22T15:08:37.109Z",
                        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
                    }
                }
            ],
            "ids:language": {
                "@id": "https://w3id.org/idsa/code/EN"
            },
            "ids:created": {
                "@value": "2022-02-22T15:08:37.333Z",
                "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
            }
        }
    ]
}
'
```

![Offered Resource Controller](doc/Offered_Resource_Controller.png?raw=true "Offered Resource Controller")

The response should be the self description document.


## Adding Contract Offer

To add a contract offer to existing offered resource use the request:

```
curl -X 'POST' \
  'https://{IPADDRESS}:{SELF_DESCRIPTION_PORT}/api/contractOffer/' \
  -H 'accept: application/json' \
  -H 'resource: https://w3id.org/idsa/autogen/textResource/48290cb2-f31b-4b8e-8c13-d2d69a3dee30' \
  -H 'Content-Type: application/json' \
  -d '{
    "@context": {
        "ids": "https://w3id.org/idsa/core/",
        "idsc": "https://w3id.org/idsa/code/"
    }, 
        "@type": "ids:ContractOffer",
        "@id": "https://w3id.org/idsa/autogen/contractOffer/94d96932-cefd-4aa1-bc84-bd207965d085",
        "ids:permission": [{
                "@type": "ids:Permission",
                "@id": "https://w3id.org/idsa/autogen/permission/e507c35a-2bae-4938-9f96-fddf3443f199",
                "ids:target": {
                    "@id": "http://w3id.org/engrd/connector/artifact/1"
                },
                "ids:description": [],
                "ids:action": [{
                        "@id": "https://w3id.org/idsa/code/USE"
                    }
                ],
                "ids:title": [],
                "ids:assignee": [{
                        "@id": "https://assignee.com"
                    }
                ],
                "ids:assigner": [{
                        "@id": "https://assigner.com"
                    }
                ],
                "ids:preDuty": [],
                "ids:postDuty": [],
                "ids:constraint": [{
                        "@type": "ids:Constraint",
                        "@id": "https://w3id.org/idsa/autogen/constraint/11b4da2e-1af5-465f-8ea7-0e8ad6ac3dc9",
                        "ids:rightOperand": {
                            "@value": "2022-02-15T15:08:37Z",
                            "@type": "http://www.w3.org/2001/XMLSchema#datetime"
                        },
                        "ids:leftOperand": {
                            "@id": "https://w3id.org/idsa/code/POLICY_EVALUATION_TIME"
                        },
                        "ids:operator": {
                            "@id": "https://w3id.org/idsa/code/AFTER"
                        }
                    }, {
                        "@type": "ids:Constraint",
                        "@id": "https://w3id.org/idsa/autogen/constraint/3cdf1978-f39f-4802-a0db-28274c58d2f3",
                        "ids:rightOperand": {
                            "@value": "2022-03-22T15:08:37Z",
                            "@type": "http://www.w3.org/2001/XMLSchema#datetime"
                        },
                        "ids:leftOperand": {
                            "@id": "https://w3id.org/idsa/code/POLICY_EVALUATION_TIME"
                        },
                        "ids:operator": {
                            "@id": "https://w3id.org/idsa/code/BEFORE"
                        }
                    }
                ]
            }
        ]
    
}'
```

![Contract Offer Controller](doc/Contract_Offer_Controller.png?raw=true "Contract Offer Controller")

The response should be the self description document.


## Adding Contract Offer

To add a contract offer to existing offered resource use the request:

```
curl -X 'POST' \
  'https://{IPADDRESS}:{SELF_DESCRIPTION_PORT}/api/contractOffer/' \
  -H 'accept: application/json' \
  -H 'resource: https://w3id.org/idsa/autogen/textResource/48290cb2-f31b-4b8e-8c13-d2d69a3dee30' \
  -H 'Content-Type: application/json' \
  -d '{
    "@context": {
        "ids": "https://w3id.org/idsa/core/",
        "idsc": "https://w3id.org/idsa/code/"
    }, 
        "@type": "ids:ContractOffer",
        "@id": "https://w3id.org/idsa/autogen/contractOffer/94d96932-cefd-4aa1-bc84-bd207965d085",
        "ids:permission": [{
                "@type": "ids:Permission",
                "@id": "https://w3id.org/idsa/autogen/permission/e507c35a-2bae-4938-9f96-fddf3443f199",
                "ids:target": {
                    "@id": "http://w3id.org/engrd/connector/artifact/1"
                },
                "ids:description": [],
                "ids:action": [{
                        "@id": "https://w3id.org/idsa/code/USE"
                    }
                ],
                "ids:title": [],
                "ids:assignee": [{
                        "@id": "https://assignee.com"
                    }
                ],
                "ids:assigner": [{
                        "@id": "https://assigner.com"
                    }
                ],
                "ids:preDuty": [],
                "ids:postDuty": [],
                "ids:constraint": [{
                        "@type": "ids:Constraint",
                        "@id": "https://w3id.org/idsa/autogen/constraint/11b4da2e-1af5-465f-8ea7-0e8ad6ac3dc9",
                        "ids:rightOperand": {
                            "@value": "2022-02-15T15:08:37Z",
                            "@type": "http://www.w3.org/2001/XMLSchema#datetime"
                        },
                        "ids:leftOperand": {
                            "@id": "https://w3id.org/idsa/code/POLICY_EVALUATION_TIME"
                        },
                        "ids:operator": {
                            "@id": "https://w3id.org/idsa/code/AFTER"
                        }
                    }, {
                        "@type": "ids:Constraint",
                        "@id": "https://w3id.org/idsa/autogen/constraint/3cdf1978-f39f-4802-a0db-28274c58d2f3",
                        "ids:rightOperand": {
                            "@value": "2022-03-22T15:08:37Z",
                            "@type": "http://www.w3.org/2001/XMLSchema#datetime"
                        },
                        "ids:leftOperand": {
                            "@id": "https://w3id.org/idsa/code/POLICY_EVALUATION_TIME"
                        },
                        "ids:operator": {
                            "@id": "https://w3id.org/idsa/code/BEFORE"
                        }
                    }
                ]
            }
        ]
    
}'
```

![Contract Offer Controller](doc/Contract_Offer_Controller.png?raw=true "Contract Offer Controller")

The response should be the self description document.


## Adding Resource Representation

To add a resource representation to existing offered resource use the request:
```
{
    "@context": {
        "ids": "https://w3id.org/idsa/core/",
        "idsc": "https://w3id.org/idsa/code/"
    },
    "@type": "ids:TextRepresentation",
    "@id": "https://w3id.org/idsa/autogen/textRepresentation/df61c48b-d925-4500-9ea4-c64bd6b31d59",
    "ids:instance": [{
            "@type": "ids:Artifact",
            "@id": "http://w3id.org/engrd/connector/artifact/1",
            "ids:creationDate": {
                "@value": "2022-02-22T15:08:37.109Z",
                "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
            }
        }
    ],
    "ids:language": {
        "@id": "https://w3id.org/idsa/code/EN"
    },
    "ids:created": {
        "@value": "2022-02-22T15:08:37.333Z",
        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
    }
}

```

![Resource Representation Controller](doc/Resource_Representation_Controller.png?raw=true "Resource Representation Controller")

The response should be the self description document.