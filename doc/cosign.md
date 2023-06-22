## Docker image signing and verification <a href="#cosign" id="cosign"></a>

Docker images that are part of the TRUE Connector are signed using [cosign](https://github.com/sigstore/cosign). In releases section, you can find appropriate version of cosign executable, appropriate of the target OS.

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
