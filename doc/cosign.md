## Docker image signing and verification <a href="#cosign" id="cosign"></a>

Docker images that are part of the TRUE Connector are signed using [cosign](https://github.com/sigstore/cosign). In releases section, you can find appropriate version of cosign executable, appropriate of the target OS.

Signed images starts with following versions:

**rdlabengpa/ids\_execution\_core\_container:v1.14.8**\

**rdlabengpa/ids\_be\_data\_app:v0.3.8**\

**rdlabengpa/ids\_uc\_data\_app\_platoon:v1.7.9**\

**rdlabengpa/ids\_uc\_data\_app\_platoon\_pip:v1.0.0**\


Once images are downloaded, you can verify the signature by executing following command, (trueconn.pub file can be found in the ecc_cert folder) and response should be like following

NOTE: Versions of cosing greater than 2.0.x will require to provide additional flag *--insecure-ignore-tlog*, to avoid message like following:

```
Error: no matching signatures:
signature not found in transparency log
main.go:69: error during command execution: no matching signatures:
signature not found in transparency log
```

```
cosign verify --insecure-ignore-tlog --key trueconn.pub rdlabengpa/ids_execution_core_container:v1.14.8

WARNING: Skipping tlog verification is an insecure practice that lacks of transparency and auditability verification for the signature.
Verification for index.docker.io/rdlabengpa/ids_execution_core_container:v1.14.8 --
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
                "docker-manifest-digest": "sha256:17cb1512a22448326e74df3ab4df3e82cdddcd7cbbb8a8e81cb177455586df7c"
            },
            "type": "cosign container image signature"
        },
        "optional": null
    }
]
```

```
cosign verify --insecure-ignore-tlog --key trueconn.pub rdlabengpa/ids_be_data_app:v0.3.8

WARNING: Skipping tlog verification is an insecure practice that lacks of transparency and auditability verification for the signature.
Verification for index.docker.io/rdlabengpa/ids_be_data_app:v0.3.8 --
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
                "docker-manifest-digest": "sha256:7eee63e0e63013b3dcb0080c7468a618fb9f0f09a337647b74d326de550dceb3"
            },
            "type": "cosign container image signature"
        },
        "optional": null
    }
]
```

```
cosign verify --insecure-ignore-tlog --key trueconn.pub rdlabengpa/ids_uc_data_app_platoon:v1.7.9

WARNING: Skipping tlog verification is an insecure practice that lacks of transparency and auditability verification for the signature.
Verification for index.docker.io/rdlabengpa/ids_uc_data_app_platoon:v1.7.9 --
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
				"docker-manifest-digest": "sha256:5303a5216dcf1d658f04bc5e5cf934bf2c8faaf2f0c402b392df167d37330162"
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
