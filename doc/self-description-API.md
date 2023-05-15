## Self Description API <a href="#selfdescription" id="selfdescription"></a>

To manage your Self Description Document please check following [link](https://github.com/Engineering-Research-and-Development/true-connector-execution\_core\_container/blob/master/doc/SELF\_DESCRIPTION.md)

You can copy existing valid self-description.json document to following location **/ecc\_resources\_consumer** or **/ecc\_resources\_provider** folders, for consumer or provider\


There is also possibility to change location of self\_description.json document, which can be done by changing following property:

```
application.selfdescription.filelocation=

```

Be careful when changing this property, since it needs to be reflected inside docker container.

When connector is starting up, it will look for file named _self\_description.json_ file, and if such file exists, it will load Self Description document from file, otherwise it will create default Self Description document, from properties:

```
application.selfdescription.description=
application.selfdescription.title=
application.selfdescription.curator=
application.selfdescription.maintainer=
```

With single offered resource, artifact and contract offer.

### Changing API password <a href="#changepassword" id="changepassword"></a>

If you want to change password for API, this can be done via following endpoint

```
/notification/password/{new_password}
```

Bare in mind that this endpoint is password protected, and you will have to provide existing credentials in order for TrueConnector to generate new hash that matches with the value passed in URL. Once new hash is returned, you can modify property and set new password.

```
spring.security.user.password=
```

## Postman collection <a href="#postman" id="postman"></a>

There is a postman collection which can be used to initiate requests that are most commonly used: perform contract negotiation, get artifact, broker interaction, manipulate Self Description document via API.

![Postman collection](postman\_collection.png)

[TRUEConnector.postman\_collection](TRUEConnector.postman\_collection.json)\


[TRUEConnector enviroment.postman\_environment](TRUEConnector\_enviroment.postman\_environment.json)

This collection comes with predefined environments so be sure to also import environment file.

## Cosign <a href="#cosign" id="cosign"></a>

Docker images that are part of the TRUEConnector are signed using [cosign](https://github.com/sigstore/cosign). In releases section, you can find apropriate version of cosign executable, appropriate of the target OS.

Signed images starts with following versions:

**rdlabengpa/ids\_execution\_core\_container:v1.11.0**\
**rdlabengpa/ids\_be\_data\_app:v0.2.5**\
**rdlabengpa/ids\_uc\_data\_app\_platoon:v1.5**\


Once images are downloaded, you can verify the signature by executing following command, (trueconn.pub file can be found in the root of this repo) and response should be like following

```
cosign verify --key trueconn.pub rdlabengpa/ids_execution_core_container:v1.11.0

Verification for index.docker.io/rdlabengpa/ids_execution_core_container:v1.11.0
The following checks were performed on each of these signatures:
  - The cosign claims were validated
  - The signatures were verified against the specified public key

[
	{
		"critical": {
			"identity": {
				"docker-reference": "index.docker.io/rdlabengpa/ids_execution_core_container"
			},
			"image": {
				"docker-manifest-digest": "sha256:bed456fec085f030cb6f02a1b0e98af21c9201b138952a39e84932fb4a4f5130"
			},
			"type": "cosign container image signature"
		},
		"optional": null
	}
]
```

```
cosign verify --key trueconn.pub rdlabengpa/ids_be_data_app:v0.2.5

Verification for index.docker.io/rdlabengpa/ids_be_data_app:v0.2.5 --
The following checks were performed on each of these signatures:
  - The cosign claims were validated
  - The signatures were verified against the specified public key

[
	{
		"critical": {
			"identity": {
				"docker-reference": "index.docker.io/rdlabengpa/ids_be_data_app"
			},
			"image": {
				"docker-manifest-digest": "sha256:1c37d550e586fc8174a0f3ae5654df41f79565114e789d9c122ba0d4af66a35e"
			},
			"type": "cosign container image signature"
		},
		"optional": null
	}
]
```

```
cosign verify --key trueconn.pub rdlabengpa/ids_uc_data_app_platoon:v1.5

Verification for index.docker.io/rdlabengpa/ids_uc_data_app_platoon:v1.5 --
The following checks were performed on each of these signatures:
  - The cosign claims were validated
  - The signatures were verified against the specified public key

[
	{
		"critical": {
			"identity": {
				"docker-reference": "index.docker.io/rdlabengpa/ids_uc_data_app_platoon"
			},
			"image": {
				"docker-manifest-digest": "sha256:5f0ba75df56497c95a324aef9dfd0787b1b579aa0f8becd558996a9d3404757e"
			},
			"type": "cosign container image signature"
		},
		"optional": null
	}
]
```
