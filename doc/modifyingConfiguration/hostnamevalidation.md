### Enable hostname validation <a href="#hostnamevalidation" id="hostnamevalidation"></a>

To enable hostname validation, set following property to false:

```
DISABLE_SSL_VALIDATION=false
```

By changing this property to false and enabling hostname validation, you will have to have valid truststore, with public keys from external systems (towards which you are making https calls) imported into truststore. Set truststore and its password by modifying following properties

```
TRUSTORE_NAME=truststoreEcc.jks
TRUSTORE_PASSWORD=allpassword
```
