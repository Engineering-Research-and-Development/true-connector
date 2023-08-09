## Docker image signing and verification <a href="#cosign" id="cosign"></a>

Docker images that are part of the TRUE Connector are signed using [cosign](https://github.com/sigstore/cosign). In releases section, you can find appropriate version of cosign executable, appropriate of the target OS.

Signed images starts with following versions:

**rdlabengpa/ids\_execution\_core\_container:v1.14.2**\

**rdlabengpa/ids\_be\_data\_app:v0.3.1**\

**rdlabengpa/ids\_uc\_data\_app\_platoon:v1.7.3**\

**rdlabengpa/ids\_uc\_data\_app\_platoon\_pip:v1.0.0**\


Once images are downloaded, you can verify the signature by executing following command, (trueconn.pub file can be found in the root of this repo) and response should be like following

```
cosign verify --key trueconn.pub rdlabengpa/ids_execution_core_container:v1.14.2

Verification for index.docker.io/rdlabengpa/ids_execution_core_container:v1.14.2 --
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
                "docker-manifest-digest": "sha256:13db7775bc9bfb1f5b85f1d4930f64665993aa06567c379e4ebfd73be10a9fb4"
            },
            "type": "cosign container image signature"
        },
        "optional": null
    }
]
```

```
cosign verify --key trueconn.pub rdlabengpa/ids_be_data_app:v0.3.1

Verification for index.docker.io/rdlabengpa/ids_be_data_app:v0.3.1 --
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
                "docker-manifest-digest": "sha256:718eded2099437494e9d2995205282c8d66465a267c0188a838d66f6a3b05bac"
            },
            "type": "cosign container image signature"
        },
        "optional": null
    }
]
```

```
cosign verify --key trueconn.pub rdlabengpa/ids_uc_data_app_platoon:v1.7.3

Verification for index.docker.io/rdlabengpa/ids_uc_data_app_platoon:v1.7.3 --
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
                "docker-manifest-digest": "sha256:12e83927ec001d65ad68e3f7f53572cde92cccc5d933a936599d1f133b342ada"
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

