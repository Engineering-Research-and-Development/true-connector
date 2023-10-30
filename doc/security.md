# Security policies

The TRUE Connector uses state-of-the-art TLS 1.3 encryption for https/wss communication which is also implemented and used for idscp2 communication. In addition to TLS 1.3, security is also bolstered by using DAPS for identity provisioning and management based on the newest X.509v3 standard of certificates.

## Public Key Infrastructure - PKI

TRUE Connector supports both self signed (to be used for non production environment) and certificates provided by trusted Certificate Authority, like Let'sEncrypt, which are recommended for production environment. This certificate will be used to enable TLS channel between components.

If requested, you can create one for consumer side and one for provider side of the TRUE Connector. In that case, SAN should be split to match (consumer and provider ones should be separated)

Recommended values for certificate are following:

| Certificate Extension | Recommended value |
|:------------|:------------|
| Keystore Type | PKCS #12 or JKS |
| Version | 3 |
| Public key | RSA 4096 bits |
| Signature Algorithm | SHA-256 with RSA |
| Validity | 6 months |
| Key usage | Key Agreement, Digital Signature, Key Encipherment |
| Extended key usage | TLS Web Server Authentication (1.3.6.1.5.5.7.3.1) TLS Web Client Authentication (1.3.6.1.5.5.7.3.2) |
| Authority Key Identifier | 160-bit hash |
| Subject Key Identifier | 160-bit hash |
| Subject Alternative Name | DNS Name: be-dataapp-consumer; DNS Name: be-dataapp-provider; DNS Name: ecc-consumer; DNS Name: ecc-provider; DNS Name: localhost; DNS Name: uc-dataapp-consumer; DNS Name: uc-dataapp-provider |
| Common Name (CN) | execution-core-container | 
| Organization Unit (OU) | R&D |
| Organization Name (O) | Engineering Ingegneria Informatica SpA |
| Locality Name (L) | Lecce |
| State Name (ST) | Italy |
| Country (C) | Italy |

SAN can be changed depending on deployed network infrastructure.

When creating self signed certificate, be sure to set values provided in table above. For that purpose you can use openssl command or KeyStore Explorer, small utility application that will help you to set all the values and generate correct key. Password should be "strong enough".

## Truststore

To support hostname validation, truststore will have to be contain valid certificate, with information related with SAN. How to configure truststore correctly, you can get information from [link](https://github.com/Engineering-Research-and-Development/true-connector/blob/main/doc/testbed/TESTBED.md#export-trueconnector-certificate). This step is mandatory, and if not set correctly, you will get 'PKIX' exception when making https call.

In the truststore, next certificates are mandatory:

* DAPS TLS certificate

* DAPS key provider certificate (OCSP)

* Broker certificate

* Consumer Connector certificate

* Provider Connector

* Clearing house certificate (if CH is used)

## Identity certificate - DAPS certificate

Another certificate is required to be used in TRUE Connector - identity certificate, used to identify connector and to fetch jwToken from Identity Provider - DAPS. Following certificate can be generated using Testbed instructions described [here](https://github.com/International-Data-Spaces-Association/IDS-testbed/blob/v1.1.0/CertificateAuthority/README.md). Be aware that following certificates will work only with provided Dynamic Attribute Provisioning Service (DAPS) - Omejdn. For other DAPS implementations, this will require additional validation.
Once certificate is generated, following instruction from previous link, you can configure TRUE Connector to use DAPS, by following instructions from [here](https://github.com/Engineering-Research-and-Development/true-connector/blob/main/doc/advancedConfiguration/identityproviders.md).

# Integrity check

TRUE Connector has several ways to check the integrity:

 * [Docker cosing check](cosign.md)
 * [Healthcheck](https://github.com/Engineering-Research-and-Development/true-connector-execution_core_container/blob/1.14.4/doc/HEALTHCHECK.md)
 * Verification of the components itself, that will check if current version of subcomponent is verified or not;
 
 Each component (Execution Core Container, Basic DataApp and Platoon Usage Control) should on startup log somethign like following:
 
 ```
Certified version: true
 ```
 in case if TRUE Connector is using certified subcomponent or not.