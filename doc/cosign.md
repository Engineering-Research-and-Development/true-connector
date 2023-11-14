## Docker image signing and verification <a href="#cosign" id="cosign"></a>

Docker images that are part of the TRUE Connector are signed using [cosign](https://github.com/sigstore/cosign). In releases section, you can find appropriate version of cosign executable, appropriate of the target OS.

Signed images starts with following versions:

**rdlabengpa/ids\_execution\_core\_container:v1.14.5**\

**rdlabengpa/ids\_be\_data\_app:v0.3.6**\

**rdlabengpa/ids\_uc\_data\_app\_platoon:v1.7.7**\

**rdlabengpa/ids\_uc\_data\_app\_platoon\_pip:v1.0.0**\


Once images are downloaded, you can verify the signature by executing following command, (trueconn.pub file can be found in the ecc_cert folder) and response should be like following

```
cosign verify --key trueconn.pub rdlabengpa/ids_execution_core_container:v1.14.5

Verification for index.docker.io/rdlabengpa/ids_execution_core_container:v1.14.5 --
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
				"docker-manifest-digest": "sha256:9ac8249ee1bfc99aa49db33c68338fe13fe175493ad15acb8225c4168400c927"
			},
			"type": "cosign container image signature"
		},
		"optional": null
	}
]
```

```
cosign verify --key trueconn.pub rdlabengpa/ids_be_data_app:v0.3.6

Verification for index.docker.io/rdlabengpa/ids_be_data_app:v0.3.6 --
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
				"docker-manifest-digest": "sha256:444a8a5134ebd2b73afb6ea88d9426d48faa20946677abddc4672d5ebfd902f4"
			},
			"type": "cosign container image signature"
		},
		"optional": null
	}
]
```

```
cosign verify --key trueconn.pub rdlabengpa/ids_uc_data_app_platoon:v1.7.7

Verification for index.docker.io/rdlabengpa/ids_uc_data_app_platoon:v1.7.7 --
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
				"docker-manifest-digest": "sha256:142a5971ee47f7119e2d0715f2af9bd68f8260f9148bd8ac4c8039816c14f3d9"
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
**NOTE:** If you using cosign version above v1.17, please add the following flags at the end of command: ` --insecure-ignore-tlog`

