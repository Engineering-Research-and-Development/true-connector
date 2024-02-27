## Enable Self Description Validation <a href="#seldesrptionvalidation" id="seldesrptionvalidation"></a>

Self description validation is enabled by default, and connector will check does received self description document contains next fields: ***Connector ID, Security Profile, PublicKey***

To disable self description validation, set following property to false:

```
VALIDATE_SELF_DESCRIPTION=false
```