# Test cases

## /proxy Endpoint

Following endpoint is used as utility endpoint, logic behind it is hiding logic related with IDS message creation. This endpoint is not password protected. Body of the request is json, with key-pair structure. Possible keys, with some predefined values are:

_multipart_, of type String, with predefined values: mixed, form, http-header, wss; required\
_forwardTo_ of type String, should be formatted as URI; required\
_messageType_ - of type String, messages that are currently supported/logic implemented; required\
_forwardToInternal_ of type String, should be formatted as URI; used in case of wss flow\
_payload_ - of type String, json object; can be left out\
_requestedArtifact_ - of type String, should be formatted as URI\
_requestedElement_ - of type String, should be formatted as URI\
_transferContract_ - of type String, should be formatted as URI\


Example request:

```
curl --location --request POST 'https://localhost:8184/proxy' \
--header 'Content-Type: application/json' \
--header 'Authorization: Basic Y29ubmVjdG9yOnBhc3N3b3Jk' \
--data-raw '{
    "multipart": "form",
    "Forward-To": "https://connectora:8080/api/ids/data",
    "messageType":"DescriptionRequestMessage"
}
```

This endpoint is used to initiate flow, as convenient method, so that we do not need to take care of creating properly formatted IDS message. It will be used in other test cases as a starting request.

In case of wrong value for multipart parameter, following error response will be returned

```
Missing proper value for MULTIPART, should be one of: 'mixed', 'form', 'http-header'
```

In case of missing multipart parameter:

```
Multipart field not found in request, mandatory for the flow
```

In case of not supported message - messageType parameter:

```
{
    "timestamp": "2023-02-21T15:05:36.678+0000",
    "status": 500,
    "error": "Internal Server Error",
    "message": "No message available",
    "path": "/proxy"
}
```

## /data endpoint

Endpoint exposed by the Connector, used to receive requests from other Connectors in Dataspace.

Depending of the connector configuration, data received on this endpoint will be processes accordingly (mixed/form/header) and validate IDS message.

Regarding example requests, feel free to use same requests, for configuration, like described in [internal endpoints](TEST\_API.md#internalendpoints)

## /about/version

Main purpose for this endpoint is to provide version of the deployed Execution Core Container version. This endpoint is not password protected.\
User can also use it to check if TRUE Connector is ready for use (if component is completed with initialization/startup).

Example of the request:

```
curl --location 'http://localhost:8081/about/version'
```

and expected response:

```
0.3.0-SNAPSHOT
```

## Self Description API

Following set of endpoints are used to manipulate with Self Description document, like get, add, update or remove specific element. All of the endpoints are password protected, and require user with _ADMIN_ role.

### /api/contractOffer/

Used to perform CRUD operations over contractOffer element of Self Description.

#### GET contract offer

Required header element - contractOffer of type URI

Request example:

```
curl --location 'http://localhost:8081/api/contractOffer/' \
--header 'contractOffer: https://w3id.org/idsa/autogen/contractOffer/1e902a98-7858-4336-9607-64b9e243a76c' \
--header 'Authorization: Basic YWRtaW46cGFzc3dvcmQ='
```

If requested contract offer is present in self description, following response is returned:

```
{
    "@context": {
        "ids": "https://w3id.org/idsa/core/",
        "idsc": "https://w3id.org/idsa/code/"
    },
    "@type": "ids:ContractOffer",
    "@id": "https://w3id.org/idsa/autogen/contractOffer/1e902a98-7858-4336-9607-64b9e243a76c",
    "ids:permission": [
        {
            "@type": "ids:Permission",
            "@id": "https://w3id.org/idsa/autogen/permission/cec50a74-9d2e-4b2e-b8c6-a079c34d3799",
            "ids:target": {
                "@id": "http://w3id.org/engrd/connector/artifact/big"
            },
            "ids:description": [
                {
                    "@value": "provide-access",
                    "@type": "http://www.w3.org/2001/XMLSchema#string"
                }
            ],
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
            ]
        }
    ],
    "ids:provider": {
        "@id": "https://w3id.org/engrd/connector/"
    },
    "ids:contractDate": {
        "@value": "2023-02-21T16:45:51.278+01:00",
        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
    },
    "ids:obligation": [],
    "ids:contractStart": {
        "@value": "2023-02-21T16:45:51.200+01:00",
        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
    },
    "ids:prohibition": []
}
```

If header element is not present or if contract offer does not exist, following response is returned:

```
{
    "message": "Missing request header 'contractOffer' for method parameter of type URI"
}
```

or

```
{
    "message": "Did not find contract offer with id 'https://w3id.org/idsa/autogen/textResource/424e2559-50ad-411e-bea0-93ff6550aa80'"
}
```

#### POST contract offer

Add new contract offer to offered resource.

Required parameters are:

resource - of type String, should be formatted as URI contractOffer - of type String, json representation of de.fraunhofer.iais.eis.ContractOfferImpl class

NOTE: It is required to provide context in json representation, otherwise, request data will not be parsed correct and subelements will not be created properly, which might result in invalid data added to Self Description.

Example request for adding contact offer:

```
curl --location 'http://localhost:8081/api/contractOffer/' \
--header 'resource: https://w3id.org/idsa/autogen/textResource/a329a2fd-1002-4753-822e-89561f148839' \
--header 'Authorization: Basic YWRtaW46cGFzc3dvcmQ=' \
--header 'Content-Type: application/json' \
--data-raw '{
    "@context" : {
    "ids" : "https://w3id.org/idsa/core/"
  },
    "@type": "ids:ContractOffer",
    "@id": "https://w3id.org/idsa/autogen/contractOffer/1dbb4896-test-4c9d-8789-c58727a30884",
    "ids:permission": [
        {
            "@type": "ids:Permission",
            "@id": "https://w3id.org/idsa/autogen/permission/faa443fc-f56d-427b-b041-16402bd7e995",
            "ids:description": [
                {
                    "@value": "provide-access",
                    "@type": "http://www.w3.org/2001/XMLSchema#string"
                }
            ],
            "ids:action": [
                {
                    "@id": "https://w3id.org/idsa/code/USE"
                }
            ],
            "ids:title": [
                {
                    "@value": "Example Usage Policy IGOR",
                    "@type": "http://www.w3.org/2001/XMLSchema#string"
                }
            ],
            "ids:target": {
                "@id": "http://w3id.org/engrd/connector/artifact/test"
            }
        }
    ],
    "ids:provider": {
        "@id": "https://w3id.org/engrd/connector/"
    },
    "ids:contractDate": {
        "@value": "2023-02-22T09:50:50.916Z",
        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
    },
    "ids:contractStart": {
        "@value": "2023-02-22T09:48:46.826Z",
        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
    }
}'
```

If everything is correct, as response, updated self description will be returned, with HTTP status 200, and user can verify that response contains newly added contract offer.

In case of invalid input data (ContractOffer json string), HTTP status code 400, with following error will be returned:

```
{
    "message": "Error while processing request\nCould not transform input to an appropriate implementing class for de.fraunhofer.iais.eis.ContractOffer"
}
```

If contract offer already exists, HTTP status code 400, with following error response will be returned:

```
{
    "message": "Contract offer with id 'https://w3id.org/idsa/autogen/contractOffer/1dbb4896-7222-4c9d-8789-c58727a30884' already exists"
}
```

In case of invalid resource id - HTTP status code 404:

```
{
    "message": "Resource with id 'https://w3id.org/idsa/autogen/textResource/a329a2fd-1002-4753-822e-89561f148838' not found"
}
```

#### PUT contract offer

Update existing contract offer.

Required parameters are:

resource - of type String, should be formatted as URI contractOffer - of type String, json representation of de.fraunhofer.iais.eis.ContractOfferImpl class

Successful scenario will return in response updated self description, with HTTP status 200, and user can verify that response contains updated contract offer.

In case of failed update, use case is the same like with adding contract offer - invalid input data or contract offer with such id does not exists or resource with id does not exists.

#### DELETE contract offer

Removes contract offer from self description document.

Required header element - contractOffer of type URI

Request example:

```
curl --location --request DELETE 'http://localhost:8081/api/contractOffer/' \
--header 'contractOffer: https://w3id.org/idsa/autogen/contractOffer/1e902a98-7858-4336-9607-64b9e243a76c' \
--header 'Authorization: Basic YWRtaW46cGFzc3dvcmQ='
```

Expected response - self description document, without contract offer, if such existed.

### /offeredResource/

#### GET offered resource

Required header element - resource of type URI

Request example:

```
curl --location 'http://localhost:8081/api/offeredResource/' \
--header 'resource: https://w3id.org/idsa/autogen/textResource/a329a2fd-1002-4753-822e-89561f148839' \
--header 'Authorization: Basic YWRtaW46cGFzc3dvcmQ='
```

And successful response:

```
{
    "@context": {
        "ids": "https://w3id.org/idsa/core/",
        "idsc": "https://w3id.org/idsa/code/"
    },
    "@type": "ids:TextResource",
    "@id": "https://w3id.org/idsa/autogen/textResource/6e7c04f2-a09d-41b2-8334-013877bbda12",
    "ids:language": [
        {
            "@id": "https://w3id.org/idsa/code/EN"
        },
        {
            "@id": "https://w3id.org/idsa/code/IT"
        }
    ],
    "ids:contentType": {
        "@id": "https://w3id.org/idsa/code/SCHEMA_DEFINITION"
    },
    "ids:version": "1.0.0",
    "ids:description": [
        {
            "@value": "Default resource description",
            "@type": "http://www.w3.org/2001/XMLSchema#string"
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
    "ids:created": {
        "@value": "2023-02-22T12:40:24.641+01:00",
        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
    },
    "ids:title": [
        {
            "@value": "Default resource",
            "@type": "http://www.w3.org/2001/XMLSchema#string"
        }
    ],
    "ids:contractOffer": [
        {
            "@type": "ids:ContractOffer",
            "@id": "https://w3id.org/idsa/autogen/contractOffer/13332dd2-7a8a-47da-9acf-07541aae1cb4",
            "ids:permission": [
                {
                    "@type": "ids:Permission",
                    "@id": "https://w3id.org/idsa/autogen/permission/eabce652-a0bb-46a5-96bb-52a5df8d7e5a",
                    "ids:target": {
                        "@id": "http://w3id.org/engrd/connector/artifact/1"
                    },
                    "ids:description": [
                        {
                            "@value": "provide-access",
                            "@type": "http://www.w3.org/2001/XMLSchema#string"
                        }
                    ],
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
                    ]
                }
            ],
            "ids:provider": {
                "@id": "https://w3id.org/engrd/connector/"
            },
            "ids:prohibition": [],
            "ids:contractStart": {
                "@value": "2023-02-22T12:40:24.668+01:00",
                "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
            },
            "ids:contractDate": {
                "@value": "2023-02-22T12:40:24.667+01:00",
                "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
            }
        }
    ],
    "ids:representation": [
        {
            "@type": "ids:TextRepresentation",
            "@id": "https://w3id.org/idsa/autogen/textRepresentation/7ce77ae6-78b0-484a-8c90-6fd28d89693d",
            "ids:instance": [
                {
                    "@type": "ids:Artifact",
                    "@id": "http://w3id.org/engrd/connector/artifact/1",
                    "ids:creationDate": {
                        "@value": "2023-02-22T12:40:24.521+01:00",
                        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
                    }
                }
            ],
            "ids:language": {
                "@id": "https://w3id.org/idsa/code/EN"
            },
            "ids:created": {
                "@value": "2023-02-22T12:40:24.689+01:00",
                "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
            }
        }
    ],
    "ids:modified": {
        "@value": "2023-02-22T12:40:24.641+01:00",
        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
    }
}
```

In case of non existing offered resource, HTTP status 404:

```
{
    "message": "Resource with id 'https://w3id.org/idsa/autogen/textResource/6e7c04f2-a09d-41b2-8334-013877bbda13' not found"
}
```

When resource header is not present, HTTP status 500:

```
{
    "message": "Missing request header 'resource' for method parameter of type URI"
}
```

#### POST offered resource

Add new offered resource to catalog.

Required parameters are:

catalog - of type String, should be formatted as URI resource - of type String, json representation of de.fraunhofer.iais.eis.ResourceImpl class

NOTE: It is required to provide context in json representation, otherwise, request data will not be parsed correct and subelements will not be created properly, which might result in invalid data added to Self Description.

Example request for adding offered resource:

```
curl --location --request POST 'http://localhost:8081/api/offeredResource/' \
--header 'resource: https://w3id.org/idsa/autogen/textResource/6e7c04f2-a09d-41b2-8334-013877bbda12' \
--header 'Authorization: Basic YWRtaW46cGFzc3dvcmQ=' \
--header 'Content-Type: application/json' \
--data-raw '{
    "@context": {
        "ids": "https://w3id.org/idsa/core/",
        "idsc": "https://w3id.org/idsa/code/"
    },
    "@type": "ids:TextResource",
    "@id": "https://w3id.org/idsa/autogen/textResource/6e7c04f2-test-41b2-8334-013877bbda12",
    "ids:language": [
        {
            "@id": "https://w3id.org/idsa/code/EN"
        },
        {
            "@id": "https://w3id.org/idsa/code/IT"
        }
    ],
    "ids:contentType": {
        "@id": "https://w3id.org/idsa/code/SCHEMA_DEFINITION"
    },
    "ids:version": "1.0.0",
    "ids:description": [
        {
            "@value": "Default resource description",
            "@type": "http://www.w3.org/2001/XMLSchema#string"
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
    "ids:created": {
        "@value": "2023-02-22T12:40:24.641+01:00",
        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
    },
    "ids:title": [
        {
            "@value": "Default resource",
            "@type": "http://www.w3.org/2001/XMLSchema#string"
        }
    ],
    "ids:contractOffer": [
        {
            "@type": "ids:ContractOffer",
            "@id": "https://w3id.org/idsa/autogen/contractOffer/13332dd2-test-47da-9acf-07541aae1cb4",
            "ids:permission": [
                {
                    "@type": "ids:Permission",
                    "@id": "https://w3id.org/idsa/autogen/permission/eabce652-test-46a5-96bb-52a5df8d7e5a",
                    "ids:target": {
                        "@id": "http://w3id.org/engrd/connector/artifact/1"
                    },
                    "ids:description": [
                        {
                            "@value": "provide-access",
                            "@type": "http://www.w3.org/2001/XMLSchema#string"
                        }
                    ],
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
                    ]
                }
            ],
            "ids:provider": {
                "@id": "https://w3id.org/engrd/connector/"
            },
            "ids:contractStart": {
                "@value": "2023-02-22T12:40:24.668+01:00",
                "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
            },
            "ids:contractDate": {
                "@value": "2023-02-22T12:40:24.667+01:00",
                "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
            }
        }
    ],
    "ids:representation": [
        {
            "@type": "ids:TextRepresentation",
            "@id": "https://w3id.org/idsa/autogen/textRepresentation/7ce77ae6-test-484a-8c90-6fd28d89693d",
            "ids:instance": [
                {
                    "@type": "ids:Artifact",
                    "@id": "http://w3id.org/engrd/connector/artifact/test",
                    "ids:creationDate": {
                        "@value": "2023-02-22T12:40:24.521+01:00",
                        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
                    }
                }
            ],
            "ids:language": {
                "@id": "https://w3id.org/idsa/code/EN"
            },
            "ids:created": {
                "@value": "2023-02-22T12:40:24.689+01:00",
                "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
            }
        }
    ],
    "ids:modified": {
        "@value": "2023-02-22T12:40:24.641+01:00",
        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
    }
}'
```

If everything is correct, as response, updated self description will be returned, with HTTP status 200, and user can verify that response contains newly added offered resource.

In case of invalid input data (Resource json string), HTTP status code 400, with following error will be returned:

```
{
    "message": "Error while processing request\nCould not transform input to an appropriate implementing class for de.fraunhofer.iais.eis.Resource"
}
```

If contract resource exists, HTTP status code 400, with following error response will be returned:

```
{
    "message": "Resource with id 'https://w3id.org/idsa/autogen/textResource/6e7c04f2-test-41b2-8334-013877bbda12' already exists"
}
```

In case of invalid resource id - HTTP status code 404:

```
{
    "message": "Resource with id 'https://w3id.org/idsa/autogen/textResource/6e7c04f2-test-41b2-8334-013877bbda12' not found"
}
```

If catalog header parameter is missing or invalid, proper error response message will be sent back

```
{
    "message": "Missing request header 'catalog' for method parameter of type URI"
}
```

or

```
{
    "message": "Did not find resourceCatalog with id https://w3id.org/idsa/autogen/resourceCatalog/c65c6d5d-ffdd-4872-a8ee-cc0aa6e223f9"
}
```

#### PUT offered resource

Update existing offered resource.

Required parameters are:

catalog - of type String, should be formatted as URI resource - of type String, json representation of de.fraunhofer.iais.eis.ResourceImpl class

Successful scenario will return in response updated self description, with HTTP status 200, and user can verify that response contains updated resource offer.

In case of failed update, use case is the same like with adding offered resource - invalid input data or offered resource with such id does not exists or catalog with id does not exists.

#### DELETE

Removes offered resource from Self Description document

Required header element - resource of type URI

Example request:

```
curl --location --request DELETE 'http://localhost:8081/api/offeredResource/' \
--header 'resource: https://w3id.org/idsa/autogen/textResource/6e7c04f2-a09d-41b2-8334-013877bbda12' \
--header 'Authorization: Basic YWRtaW46cGFzc3dvcmQ='
```

Expected successful response - self description document, without offered resource, if such existed.

When resource header is not present, HTTP status 500:

```
{
    "message": "Missing request header 'resource' for method parameter of type URI"
}
```

### /representation/

#### GET representation

Required header element - representation of type URI

Request example:

```
curl --location 'http://localhost:8081/api/representation/' \
--header 'representation: https://w3id.org/idsa/autogen/textRepresentation/09b9b628-77ee-40a2-98c4-79b559370cda' \
--header 'Authorization: Basic YWRtaW46cGFzc3dvcmQ='
```

Successful response:

```
{
    "@context": {
        "ids": "https://w3id.org/idsa/core/",
        "idsc": "https://w3id.org/idsa/code/"
    },
    "@type": "ids:TextRepresentation",
    "@id": "https://w3id.org/idsa/autogen/textRepresentation/09b9b628-77ee-40a2-98c4-79b559370cda",
    "ids:instance": [
        {
            "@type": "ids:Artifact",
            "@id": "http://w3id.org/engrd/connector/artifact/1",
            "ids:creationDate": {
                "@value": "2023-02-22T14:46:48.907+01:00",
                "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
            }
        }
    ],
    "ids:language": {
        "@id": "https://w3id.org/idsa/code/EN"
    },
    "ids:created": {
        "@value": "2023-02-22T14:46:49.144+01:00",
        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
    }
}
```

If header element is not provided or invalid:

```
{
    "message": "Missing request header 'representation' for method parameter of type URI"
}
```

or

```
{
    "message": "Did not find representation with id 'https://w3id.org/idsa/autogen/textRepresentation/09b9b628-77ee-40a2-98c4-79b559370cdb'"
}
```

#### POST representation

Add new representation to offered resource.

Required parameters are:

resource - of type String, should be formatted as URI representation - of type String, json representation of de.fraunhofer.iais.eis.RepresentationImpl class

NOTE: It is required to provide context in json representation, otherwise, request data will not be parsed correct and sub-elements will not be created properly, which might result in invalid data added to Self Description.

Example request for adding contact offer:

```
curl --location 'http://localhost:8081/api/representation/' \
--header 'resource: https://w3id.org/idsa/autogen/textResource/424e2559-50ad-411e-bea0-93ff6550aa80' \
--header 'Authorization: Basic YWRtaW46cGFzc3dvcmQ=' \
--header 'Content-Type: application/json' \
--data-raw '{
    "@context": {
        "ids": "https://w3id.org/idsa/core/",
        "idsc": "https://w3id.org/idsa/code/"
    },
    "@type": "ids:TextRepresentation",
    "@id": "https://w3id.org/idsa/autogen/textRepresentation/09b9b628-test-40a2-98c4-79b559370cda",
    "ids:instance": [
        {
            "@type": "ids:Artifact",
            "@id": "http://w3id.org/engrd/connector/artifact/test",
            "ids:creationDate": {
                "@value": "2023-02-22T14:46:48.907+01:00",
                "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
            }
        }
    ],
    "ids:language": {
        "@id": "https://w3id.org/idsa/code/EN"
    },
    "ids:created": {
        "@value": "2023-02-22T14:46:49.144+01:00",
        "@type": "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
    }
}'
```

If everything is correct, as response, updated self description will be returned, with HTTP status 200, and user can verify that response contains newly added representation.

In case of invalid input data (Representation json string), HTTP status code 400, with following error will be returned:

```
{
    "message": "Error while processing request\nCould not transform input to an appropriate implementing class for de.fraunhofer.iais.eis.Representation"
}
```

If contract offer already exists, HTTP status code 400, with following error response will be returned:

```
{
    "message": "Representation with id 'https://w3id.org/idsa/autogen/textRepresentation/09b9b628-test-40a2-98c4-79b559370cda' already exists"
}
```

In case of invalid resource id - HTTP status code 404:

```
{
    "message": "Resource with id 'https://w3id.org/idsa/autogen/textResource/a329a2fd-1002-4753-822e-89561f148838' not found"
}
```

#### PUT representation

Update existing representation.

Required parameters are:

resource - of type String, should be formatted as URI representation - of type String, json representation of de.fraunhofer.iais.eis.RepresentationImpl class

Successful scenario will return in response updated self description, with HTTP status 200, and user can verify that response contains updated representation.

In case of failed update, use case is the same like with adding representation - invalid input data or representation with such id does not exists or resource with id does not exists.

#### DELETE representation

Removes representation from self description document.

Required header element - representation of type URI

Request example:

```
curl --location --request DELETE 'http://localhost:8081/api/representation/' \
--header 'representation: https://w3id.org/idsa/autogen/textRepresentation/09b9b628-77ee-40a2-98c4-79b559370cda' \
--header 'Authorization: Basic YWRtaW46cGFzc3dvcmQ='
```

Expected response - self description document, without contract offer, if such existed.

### /selfDescription/

Example request:

```
curl --location 'http://localhost:8081/api/selfDescription/' \
--header 'Authorization: Basic YWRtaW46cGFzc3dvcmQ='
```

Expected response is connector Self Description document, with all elements.

Validation of Self Description is omitted in this API.

### /api/password/{password}

Endpoint used to generate new password.

Path variable is mandatory.

Logic will enforce password strength check, which can be configured in property file.

If password check is correct, response will be like:

```
$2a$10$FiI8JM4y7BF0Of7f6mjkeeoydyLYNuLtEOVWjenei4.21LU/.c1k6
```

In case password check is not successful, response message will contain information, which user can inspect and correct new password.

## Internal endpoints <a href="#internalendpoints" id="internalendpoints"></a>

Endpoint used to receive proxy request from DataApp. DataApp, will after receiving proxy request, creates valid IDS message request, and send it to Execution Core Container.

### /incoming-data-app/multipartMessageBodyBinary

multipart - mixed

Example request:

```
curl --location --request POST 'https://localhost:8887/incoming-data-app/multipartMessageBodyBinary' \
--header 'Forward-To: https://localhost:8889/data' \
--header 'Authorization: Basic Y29ubmVjdG9yOnBhc3N3b3Jk' \
--header 'Content-Type: text/plain' \
--data-raw '--9RDrAvgB92_-w2A-YY7av8i7GEQcKogs7pjm
Content-Disposition: form-data; name="header"
Content-Length: 1196
Content-Type: application/ld+json

{
  "@context" : {
    "ids" : "https://w3id.org/idsa/core/",
    "idsc" : "https://w3id.org/idsa/code/"
  },
  "@type" : "ids:ArtifactRequestMessage",
  "@id" : "https://w3id.org/idsa/autogen/artifactRequestMessage/e639dcba-d3b3-41b0-87fd-c181c2586bef",
  "ids:transferContract" : {
    "@id" : "https://w3id.org/idsa/autogen/contractAgreement/39f9cc50-5d9b-4d12-80dc-23e03f3cc1f8"
  },
  "ids:recipientConnector" : [ ],
  "ids:issuerConnector" : {
    "@id" : "http://w3id.org/engrd/connector/"
  },
  "ids:senderAgent" : {
    "@id" : "http://sender.agent/sender"
  },
  "ids:securityToken" : {
    "@type" : "ids:DynamicAttributeToken",
    "@id" : "https://w3id.org/idsa/autogen/dynamicAttributeToken/89910184-7a73-4d2f-8559-64dbfef254f2",
    "ids:tokenFormat" : {
      "@id" : "https://w3id.org/idsa/code/JWT"
    },
    "ids:tokenValue" : "DummyTokenValue"
  },
  "ids:issued" : {
    "@value" : "2023-02-24T11:58:46.963+01:00",
    "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
  },
  "ids:recipientAgent" : [ ],
  "ids:modelVersion" : "4.1.0",
  "ids:requestedArtifact" : {
    "@id" : "http://w3id.org/engrd/connector/artifact/1"
  }
}
--9RDrAvgB92_-w2A-YY7av8i7GEQcKogs7pjm--'
```

### /incoming-data-app/multipartMessageBodyFormData

multipart - form

Example request:

```
curl --location --request POST 'https://localhost:8887/incoming-data-app/multipartMessageBodyFormData' \
--header 'Forward-To: https://localhost:8889/data' \
--header 'Authorization: Basic Y29ubmVjdG9yOnBhc3N3b3Jk' \
--form 'header="{
  \"@context\" : {
    \"ids\" : \"https://w3id.org/idsa/core/\",
    \"idsc\" : \"https://w3id.org/idsa/code/\"
  },
  \"@type\" : \"ids:ArtifactRequestMessage\",
  \"@id\" : \"https://w3id.org/idsa/autogen/artifactRequestMessage/e639dcba-d3b3-41b0-87fd-c181c2586bef\",
  \"ids:transferContract\" : {
    \"@id\" : \"https://w3id.org/idsa/autogen/contractAgreement/39f9cc50-5d9b-4d12-80dc-23e03f3cc1f8\"
  },
  \"ids:recipientConnector\" : [ ],
  \"ids:issuerConnector\" : {
    \"@id\" : \"http://w3id.org/engrd/connector/\"
  },
  \"ids:senderAgent\" : {
    \"@id\" : \"http://sender.agent/sender\"
  },
  \"ids:securityToken\" : {
    \"@type\" : \"ids:DynamicAttributeToken\",
    \"@id\" : \"https://w3id.org/idsa/autogen/dynamicAttributeToken/89910184-7a73-4d2f-8559-64dbfef254f2\",
    \"ids:tokenFormat\" : {
      \"@id\" : \"https://w3id.org/idsa/code/JWT\"
    },
    \"ids:tokenValue\" : \"DummyTokenValue\"
  },
  \"ids:issued\" : {
    \"@value\" : \"2023-02-24T11:58:46.963+01:00\",
    \"@type\" : \"http://www.w3.org/2001/XMLSchema#dateTimeStamp\"
  },
  \"ids:recipientAgent\" : [ ],
  \"ids:modelVersion\" : \"4.1.0\",
  \"ids:requestedArtifact\" : {
    \"@id\" : \"http://w3id.org/engrd/connector/artifact/1\"
  }
}"' \
--form 'payload="PAYLOAD"'
```

\###/incoming-data-app/multipartMessageHttpHeader

multipart - http-header

This request is a bit specific, since it is required to convert IDS message to http headers (logic that DataApp proxy request do for you) and when conversion is done correct this is how request looks like, depending of the Messagetype and its mandatory fields:

```
curl --location 'https://localhost:8887/incoming-data-app/multipartMessageHttpHeader' \
--header 'Forward-To: https://localhost:8889/data' \
--header 'IDS-CorrelationMessage: http://correlationMessage' \
--header 'IDS-Id: https://w3id.org/idsa/autogen/ArtifactRequestMessage/e5939da0-7240-499b-ac1b-2c6ac5718933' \
--header 'IDS-Issued: 2023-02-24T12:09:07.124+01:00' \
--header 'IDS-IssuerConnector: http://w3id.org/engrd/connector/' \
--header 'IDS-Messagetype: ids:ArtifactRequestMessage' \
--header 'IDS-ModelVersion: 4.1.0' \
--header 'IDS-RequestedArtifact: http://w3id.org/engrd/connector/artifact/1' \
--header 'IDS-SecurityToken-Id: https://w3id.org/idsa/autogen/4cc8720d-f6bf-49a2-9b4b-c953b978a128' \
--header 'IDS-SecurityToken-TokenFormat: https://w3id.org/idsa/code/JWT' \
--header 'IDS-SecurityToken-TokenValue: DummyTokenValue' \
--header 'IDS-SecurityToken-Type: ids:DynamicAttributeToken' \
--header 'IDS-SenderAgent: http://w3id.org/engrd/connector/' \
--header 'IDS-TransferContract: https://w3id.org/idsa/autogen/contractAgreement/39f9cc50-5d9b-4d12-80dc-23e03f3cc1f8' \
--header 'Authorization: Basic Y29ubmVjdG9yOnBhc3N3b3Jk' \
--header 'Content-Type: text/plain' \
--data 'PAYLOAD'
```

If any of the mandatory headers is not present or that message cannot be recreated from headers, response will be returned and user should check header responses, for IDS-Messagetype = ids:RejectionMessage and IDS-RejectionReason = https://w3id.org/idsa/code/MALFORMED\_MESSAGE.

### /internal/sd

This endpoint is used internally, between DataApp and Execution Core Container, when DataApp needs to fetch Connector Self Description document (when DataApp receives DescriptionRequestMessage). Reason for existence of this API is to eliminate need for DataApp to have API credentials of public Self Description endpoint.

### Broker

There are convenient endpoints to initiate flow with Broker. They can be triggered from proxy endpoint. In order to do that, messageType in the proxy request must be correct. All of those endpoints will create valid IDS message and send message to connector, which will add IDS related elements (DAPS token and other) and forward to Broker. In order to send message to the Broker, Forward-To parameter of proxy request must have Broker URL. If Broker requires authentication, please set correct credentials in request, TRUE Connector will forward authorization header to destination, without modifying it.

Example proxy request:

```
curl --location 'https://localhost:8184/proxy' \
--header 'Authorization: Basic YWRtaW46cGFzc3dvcmQ=' \
--header 'Content-Type: application/json' \
--data '{
    "multipart": "form",
    "Forward-To": "https://broker-reverseproxy/infrastructure",
    "messageType": "ConnectorUpdateMessage"
}'
```

Processing of the response will be done based of the Broker response.

#### /selfRegistration/register

Message type of the proxy request - ConnectorUpdateMessage

#### /selfRegistration/update

Message type of the proxy request - ConnectorUpdateMessage

#### /selfRegistration/delete

Message type of the proxy request - ConnectorUnavailableMessage

#### /selfRegistration/passivate

Message type of the proxy request - ConnectorUnavailableMessage

#### /selfRegistration/query

Message type of the proxy request - QueryMessage

### WSS

Flow starts when API receives start frame, and ends when end frame is received. Data in between are buffered, and once whole package is received, it will try to recreate multipart/mixed request and continue with processing received request. Logic applies for both endpoints listed below.\
Data received are binary packets.

#### timerEndpointA

Interface between Consumer DataApp and Connector, to support receiving request data in WebSocket flow.

#### timerEndpointB

Interface between 2 connectors.

Logic regarding recreating request is same like for timerEndpointA
