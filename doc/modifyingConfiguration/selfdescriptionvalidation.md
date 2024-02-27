## Enable Self Description Validation <a href="#seldesrptionvalidation" id="seldesrptionvalidation"></a>

To enable self description validation, set following property to true:

```
VALIDATE_SELF_DESCRIPTION=true
```

By enabling this property, connector will check does received self description document contains next fields: ***Connector ID, Security Profile, PublicKey***

***NOTE:*** In order to have properly working self description validation, DAPS must be properly configured.