### Description Request Message <a href="#description_request_message" id="description_request_message"></a>

Before start of negotiation process, Description Request Message is sent to identify the actors and potentialy deny access if Dynamic Attribute Token (DAT) is not valid. Initially, Description Request Message is sent by consumer without payload.

<details>

<summary>Multipart form - Description Request Message</summary>

```
curl --location 'https://localhost:8184/proxy' \
--header 'Content-Type: application/json' \
--header 'Authorization: Basic cHJveHk6cGFzc3dvcmQ=' \
--data '{
    "multipart": "form",
    "Forward-To": "https://ecc-provider:8889/data",
    "messageType": "DescriptionRequestMessage"
}'
```

</details>

If DAT is invalid, Provider sends RejectionMessage with optional reason. However, if DAT is valid, SelfDescriptionResponse is being sent to Consumer with similar content:

<details>

<summary>Description Request Message - Response example</summary>

```
{
    "@context": {
        "ids": "https://w3id.org/idsa/core/",
        "idsc": "https://w3id.org/idsa/code/"
    },
    "@type": "ids:BaseConnector",
    "@id": "https://w3id.org/engrd/connector/provider",
    "ids:hasDefaultEndpoint": {
        "@type": "ids:ConnectorEndpoint",
        "@id": "https://188.2.57.38:8449/",
        "ids:accessURL": {
            "@id": "https://188.2.57.38:8449/"
        }
    },
    "ids:resourceCatalog": [
        {
            "@type": "ids:ResourceCatalog",
            "@id": "https://w3id.org/idsa/autogen/resourceCatalog/6b2a6a4d-82d9-45a3-9893-a8b4f3591fc8",
            "ids:offeredResource": [
                {
                    "@type": "ids:TextResource",
                    "@id": "https://w3id.org/idsa/autogen/textResource/f3ec0292-02fe-41d3-bc1f-bb19c383e994",
                    "ids:contractOffer": [
                        {
                            "@type": "ids:ContractOffer",
                            "@id": "https://w3id.org/idsa/autogen/contractOffer/a050f828-2246-490f-b2ec-e303f2fc6139",
                            "ids:contractStart": {
                                "@value": "2023-06-27T09:51:29.638Z",
                                "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
                            },
                            "ids:contractDate": {
                                "@value": "2023-06-27T09:51:30.670Z",
                                "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
                            },
                            "ids:provider": {
                                "@id": "https://w3id.org/engrd/connector/provider"
                            },
                            "ids:permission": [
                                {
                                    "@type": "ids:Permission",
                                    "@id": "https://w3id.org/idsa/autogen/permission/bf06df92-f5bd-4420-925f-89087776dc1e",
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
                                        "@id": "http://w3id.org/engrd/connector/artifact/big"
                                    }
                                }
                            ]
                        }
                    ],
                    "ids:representation": [
                        {
                            "@type": "ids:TextRepresentation",
                            "@id": "https://w3id.org/idsa/autogen/textRepresentation/94e3a195-a10f-4b1d-97ef-3de3046df796",
                            "ids:created": {
                                "@value": "2023-06-27T09:51:30.740Z",
                                "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
                            },
                            "ids:instance": [
                                {
                                    "@type": "ids:Artifact",
                                    "@id": "http://w3id.org/engrd/connector/artifact/big",
                                    "ids:creationDate": {
                                        "@value": "2023-06-27T09:51:28.865Z",
                                        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
                                    }
                                }
                            ],
                            "ids:language": {
                                "@id": "https://w3id.org/idsa/code/EN"
                            }
                        }
                    ],
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
                    "ids:modified": {
                        "@value": "2023-06-27T09:51:30.502Z",
                        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
                    },
                    "ids:created": {
                        "@value": "2023-06-27T09:51:30.502Z",
                        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
                    },
                    "ids:version": "1.0.0",
                    "ids:title": [
                        {
                            "@value": "World class literature",
                            "@type": "http://www.w3.org/2001/XMLSchema#string"
                        }
                    ],
                    "ids:description": [
                        {
                            "@value": "Used to verify large data transfer",
                            "@type": "http://www.w3.org/2001/XMLSchema#string"
                        }
                    ],
                    "ids:contentType": {
                        "@id": "https://w3id.org/idsa/code/SCHEMA_DEFINITION"
                    },
                    "ids:language": [
                        {
                            "@id": "https://w3id.org/idsa/code/EN"
                        },
                        {
                            "@id": "https://w3id.org/idsa/code/IT"
                        }
                    ]
                },
                {
                    "@type": "ids:DataResource",
                    "@id": "https://w3id.org/idsa/autogen/dataResource/f8163cc7-53f4-451a-9cc4-0e7f7861ac86",
                    "ids:contractOffer": [
                        {
                            "@type": "ids:ContractOffer",
                            "@id": "https://w3id.org/idsa/autogen/contractOffer/0e482510-3225-468f-9c8e-9bf4fb2105e3",
                            "ids:contractStart": {
                                "@value": "2023-06-27T09:51:29.638Z",
                                "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
                            },
                            "ids:contractDate": {
                                "@value": "2023-06-27T09:51:31.235Z",
                                "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
                            },
                            "ids:provider": {
                                "@id": "https://w3id.org/engrd/connector/provider"
                            },
                            "ids:permission": [
                                {
                                    "@type": "ids:Permission",
                                    "@id": "https://w3id.org/idsa/autogen/permission/5e51c719-d4cd-4024-a7a0-26c274ab400d",
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
                                        "@id": "http://w3id.org/engrd/connector/artifact/test1.csv"
                                    }
                                }
                            ]
                        }
                    ],
                    "ids:representation": [
                        {
                            "@type": "ids:TextRepresentation",
                            "@id": "https://w3id.org/idsa/autogen/textRepresentation/c376d9fd-7f26-40af-a044-9fbd2f363a92",
                            "ids:created": {
                                "@value": "2023-06-27T09:51:31.321Z",
                                "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
                            },
                            "ids:instance": [
                                {
                                    "@type": "ids:Artifact",
                                    "@id": "http://w3id.org/engrd/connector/artifact/test1.csv",
                                    "ids:creationDate": {
                                        "@value": "2023-06-27T09:51:29.089Z",
                                        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
                                    }
                                }
                            ],
                            "ids:language": {
                                "@id": "https://w3id.org/idsa/code/EN"
                            }
                        }
                    ],
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
                    "ids:modified": {
                        "@value": "2023-06-27T09:51:31.070Z",
                        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
                    },
                    "ids:created": {
                        "@value": "2023-06-27T09:51:31.070Z",
                        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
                    },
                    "ids:version": "1.0.0",
                    "ids:title": [
                        {
                            "@value": "CSV resource",
                            "@type": "http://www.w3.org/2001/XMLSchema#string"
                        }
                    ],
                    "ids:description": [
                        {
                            "@value": "Used to verify wss flow",
                            "@type": "http://www.w3.org/2001/XMLSchema#string"
                        }
                    ],
                    "ids:contentType": {
                        "@id": "https://w3id.org/idsa/code/SCHEMA_DEFINITION"
                    },
                    "ids:language": [
                        {
                            "@id": "https://w3id.org/idsa/code/EN"
                        },
                        {
                            "@id": "https://w3id.org/idsa/code/IT"
                        }
                    ]
                },
                {
                    "@type": "ids:TextResource",
                    "@id": "https://w3id.org/idsa/autogen/textResource/2751fec2-5ab8-4795-9e45-cb292b8d54ea",
                    "ids:contractOffer": [
                        {
                            "@type": "ids:ContractOffer",
                            "@id": "https://w3id.org/idsa/autogen/contractOffer/bf482e9d-a370-4489-b4ce-bd09ec6d1e1f",
                            "ids:contractStart": {
                                "@value": "2023-06-27T09:51:29.638Z",
                                "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
                            },
                            "ids:contractDate": {
                                "@value": "2023-06-27T09:51:29.620Z",
                                "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
                            },
                            "ids:provider": {
                                "@id": "https://w3id.org/engrd/connector/provider"
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
                    ],
                    "ids:representation": [
                        {
                            "@type": "ids:TextRepresentation",
                            "@id": "https://w3id.org/idsa/autogen/textRepresentation/9b91a10d-2cb9-4afc-a148-7bfa054b5e9a",
                            "ids:created": {
                                "@value": "2023-06-27T09:51:29.926Z",
                                "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
                            },
                            "ids:instance": [
                                {
                                    "@type": "ids:Artifact",
                                    "@id": "http://w3id.org/engrd/connector/artifact/1",
                                    "ids:creationDate": {
                                        "@value": "2023-06-27T09:51:25.473Z",
                                        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
                                    }
                                }
                            ],
                            "ids:language": {
                                "@id": "https://w3id.org/idsa/code/EN"
                            }
                        }
                    ],
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
                    "ids:modified": {
                        "@value": "2023-06-27T09:51:29.348Z",
                        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
                    },
                    "ids:created": {
                        "@value": "2023-06-27T09:51:29.349Z",
                        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
                    },
                    "ids:version": "1.0.0",
                    "ids:title": [
                        {
                            "@value": "Default resource",
                            "@type": "http://www.w3.org/2001/XMLSchema#string"
                        }
                    ],
                    "ids:description": [
                        {
                            "@value": "Default resource description",
                            "@type": "http://www.w3.org/2001/XMLSchema#string"
                        }
                    ],
                    "ids:contentType": {
                        "@id": "https://w3id.org/idsa/code/SCHEMA_DEFINITION"
                    },
                    "ids:language": [
                        {
                            "@id": "https://w3id.org/idsa/code/EN"
                        },
                        {
                            "@id": "https://w3id.org/idsa/code/IT"
                        }
                    ]
                }
            ]
        }
    ],
    "ids:securityProfile": {
        "@id": "https://w3id.org/idsa/code/BASE_SECURITY_PROFILE"
    },
    "ids:curator": {
        "@id": "http://provider.curatorURI.com"
    },
    "ids:maintainer": {
        "@id": "http://provider.maintainerURI.com"
    },
    "ids:inboundModelVersion": [
        "4.2.7"
    ],
    "ids:outboundModelVersion": "4.2.7",
    "ids:title": [
        {
            "@value": "Data Provider Connector title",
            "@type": "http://www.w3.org/2001/XMLSchema#string"
        }
    ],
    "ids:description": [
        {
            "@value": "Data Provider Connector description",
            "@type": "http://www.w3.org/2001/XMLSchema#string"
        }
    ]
}
```

</details>

If the incoming message is assumed trustworthy, the Provider answers with an IDS SelfDescriptionResponse. During the establishment phase of the negotiation, this message contains the currently valid SelfDescription of Provider in JSON-LD, including its provided IDS Resources and respective ContractOffers. Note that the connector is not obliged to provide ContractOffers for any/all resources but can also only announce their existence. The usage conditions might be sensitive too and do not need to be supplied. However, the provisioning of ContractOffers eases their usage and therefore should be in the interest of a Data Provider.
