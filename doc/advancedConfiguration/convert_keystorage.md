### Convert keystorage files <a href="#convert_keystorage" id="convert_keystorage"></a>

Change values for keystore file name, password and alias that matches Your keystore file. Keystore can be in jks format or p12. If you have some other certificate format (like pem for example), you can convert it by executing following commands from terminal:

You should have 2 files, cert.pem, containing public key

```
-----BEGIN CERTIFICATE-----
MIIDHzCCAgcCCQD0p/3nqCMT5zANBgkqhkiG9w0BAQ0FADBUMQswCQYDVQQGEwJF
...
ACsqRifEx7DKolsGyRM/zZWZZNkXNMCR1GfZv6yUNSVXQ5w=
-----END CERTIFICATE-----

```

and privkey.key, containing private key

```
-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCzDmSOphiul2hh
...
RmSOiiYKXvxW1Z2VU3uKNVU=
-----END PRIVATE KEY-----

```

You can use following command, to convert cert and key file to p12 keystorage file:

```
openssl pkcs12 -export -in cert.pem -inkey privkey.key -out certificate.p12 -name "alias"

```

Provide passwords when prompted.\
Change alias to desired value.

Once you have p12 file, you can use it as is in TRUE Connector, or you can convert it to jks with:

```
keytool -importkeystore -srckeystore certificate.p12 -srcstoretype pkcs12 -destkeystore cert.jks

```

TRUE Connector supports p12 format of certificate file, but if for some reason connector does not read file correct, you can try to convert it to jks format using provided command.

