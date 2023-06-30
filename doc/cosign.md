## Docker image signing and verification <a href="#cosign" id="cosign"></a>

Docker images that are part of the TRUE Connector are signed using [cosign](https://github.com/sigstore/cosign). In releases section, you can find appropriate version of cosign executable, appropriate of the target OS.

Signed images starts with following versions:

**rdlabengpa/ids\_execution\_core\_container:v1.13.0**\
**rdlabengpa/ids\_be\_data\_app:v0.2.7**\
**rdlabengpa/ids\_uc\_data\_app\_platoon:v1.7**\
**rdlabengpa/ids\_uc\_data\_app\_platoon\_pip:v1.0.0 **\


Once images are downloaded, you can verify the signature by executing following command, (trueconn.pub file can be found in the root of this repo) and response should be like following

```
cosign verify --key trueconn.pub rdlabengpa/ids_execution_core_container:v1.13.0

Verification for index.docker.io/rdlabengpa/ids_execution_core_container:v1.13.0 --
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
				"docker-manifest-digest": "sha256:7a1f59b7e875e6ba9f13743979180493afc632b44c737244ec0a3480f74312e5"
			},
			"type": "cosign container image signature"
		},
		"optional": null
	}
]
```

```
cosign verify --key trueconn.pub rdlabengpa/ids_be_data_app:v0.2.7

Verification for index.docker.io/rdlabengpa/ids_be_data_app:v0.2.7 --
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
				"docker-manifest-digest": "sha256:d96ed00f0b07672a94d15a0c2ff3ac5e12c170670e9572eafe648d9ddec0c66f"
			},
			"type": "cosign container image signature"
		},
		"optional": null
	}
]
```

```
cosign verify --key trueconn.pub rdlabengpa/ids_uc_data_app_platoon:v1.7.0

Verification for index.docker.io/rdlabengpa/ids_uc_data_app_platoon:v1.7.0 --
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
				"docker-manifest-digest": "sha256:8cd164c3812979ced639ab5f1d03860f967f1f5d49846f52797675b51b3965b7"
			},
			"type": "cosign container image signature"
		},
		"optional": null
	}
]
```

```
cosign verify --key trueconn.pub rdlabengpa/ids_uc_data_app_platoon_pip:v1.0.0

Verification for index.docker.io/rdlabengpa/ids_uc_data_app_platoon_pip:v1.0.0 --
The following checks were performed on each of these signatures:
  - The cosign claims were validated
  - The signatures were verified against the specified public key

[
	{
		"critical": {
			"identity": {
				"docker-reference": "index.docker.io/rdlabengpa/ids_uc_data_app_platoon_pip"
			},
			"image": {
				"docker-manifest-digest": "sha256:ced6bac3b5be2177da95892c1c5bbfb37b353444d9456f9fd55a0b14a3e1f88b"
			},
			"type": "cosign container image signature"
		},
		"optional": null
	}
]

```

