### Hostname validation <a href="#hostnamevalidation" id="hostnamevalidation"></a>

You need to have valid truststore, with public keys from external systems (towards which you are making https calls) imported into truststore. Set truststore and its password by modifying following properties

```
TRUSTORE_NAME=truststoreEcc.jks
TRUSTORE_PASSWORD=allpassword
```
