## Docker image signing and verification <a href="#cosign" id="cosign"></a>

Docker images that are part of the TRUE Connector are signed using [cosign](https://github.com/sigstore/cosign). In releases section, you can find appropriate version of cosign executable, appropriate of the target OS.

Signed images starts with following versions:

**rdlabengpa/ids\_execution\_core\_container:v1.13.1**\

**rdlabengpa/ids\_be\_data\_app:v0.2.7**\

**rdlabengpa/ids\_uc\_data\_app\_platoon:v1.7.1**\

**rdlabengpa/ids\_uc\_data\_app\_platoon\_pip:v1.0.0**\


Once images are downloaded, you can verify the signature by executing following command, (trueconn.pub file can be found in the root of this repo) and response should be like following

```
cosign verify --key trueconn.pub rdlabengpa/ids_execution_core_container:v1.13.1

Verification for index.docker.io/rdlabengpa/ids_execution_core_container:v1.13.1 --
The following checks were performed on each of these signatures:
  - The cosign claims were validated
  - The signatures were verified against the specified public key

[
   {
      "critical":{
         "identity":{
            "docker-reference":"index.docker.io/rdlabengpa/ids_execution_core_container"
         },
         "image":{
            "docker-manifest-digest":"sha256:e92e879713fe76da5263fd2aa5639e9457514a71e71e0822bdfd627cc640c459"
         },
         "type":"cosign container image signature"
      },
      "optional":null
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
cosign verify --key trueconn.pub rdlabengpa/ids_uc_data_app_platoon:v1.7.1

Verification for index.docker.io/rdlabengpa/ids_uc_data_app_platoon:v1.7.1 --
The following checks were performed on each of these signatures:
  - The cosign claims were validated
  - The signatures were verified against the specified public key

[
   {
      "critical":{
         "identity":{
            "docker-reference":"index.docker.io/rdlabengpa/ids_uc_data_app_platoon"
         },
         "image":{
            "docker-manifest-digest":"sha256:b3c35081c5c01e9606115843c91615e7d5d6ac41de14a3a998608bd3bf1b154c"
         },
         "type":"cosign container image signature"
      },
      "optional":null
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

