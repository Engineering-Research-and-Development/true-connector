### OCSP - Online Certificate Status Protocol<a href="#ocsp" id="ocsp"></a>

OCSP functionality is disabled by default, in order to enable it, set following application.property:

```
# good -> only good check
# unknown -> only good and unknown check
# none -> no OCSP test needed
application.OCSP_RevocationCheckValue=none

```
| **Property value** |	**Description** |	
|:---:|:------------|
| *good* | means that OCSP must be supported and certificate is not revoked |
| *unknown* | OCSP check enabled and enforced, but certificate itself does not have OCSP check supported (no URL for checking revoke status). Check will pass in case of certificate not revoker or if cannot be determined. |
| *none* | OCSP check disabled |

When enabled, it will perform remote environment certificate check prior to sending request to provider connector.