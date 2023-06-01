### OCSP - Online Certificate Status Protocol<a href="#ocsp" id="ocsp"></a>

OCSP functionality is disabled by default, in order to enable it, set following application.property:

```
# good -> only good check
# unknown -> only good and unknown check
# none -> no OCSP test needed
application.OCSP_RevocationCheckValue=none

```

When enabled, it will perform remote environemnt certificate check prior to sending request to provider connector.