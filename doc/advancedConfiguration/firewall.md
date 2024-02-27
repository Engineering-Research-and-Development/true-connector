## Firewall <a href="#firewall" id="firewall"></a>

TRUE Connector allows setting up HttpFirewall through Spring Security, and it is enabled by default configuration. Firewall is used both in Execution Core Container (ECC) and DataApp. To turn it off, please change following properties in **.env** file: 


```
### PROVIDER Configuration
PROVIDER_DATA_APP_FIREWALL=false
PROVIDER_ECC_FIREWALL=false

### CONSUMER Configuration
CONSUMER_DATA_APP_FIREWALL=false
CONSUMER_ECC_FIREWALL=false
```

When Firewall is enabled, it will read properties defined in `firewall.properties` file located in Execution Core Container (ECC) and DataApp resources folder, which easily can be modified by needs of setup.

```
#Set which HTTP header names should be allowed (if want to allow all header names, keep it empty)
allowedHeaderNames=
#Set which values in header names should have the exact value and allowed (if want to allow any values keep it empty)
allowedHeaderValues=
#Set which HTTP methods should be allowed
allowedMethods=GET,POST
#Set if a backslash "\" or a URL encoded backslash "%5C" should be allowed in the path or not
allowBackSlash=true
#Set if a slash "/" that is URL encoded "%2F" should be allowed in the path or not
allowUrlEncodedSlash=true
#Set if double slash "//" that is URL encoded "%2F%2F" should be allowed in the path or not
allowUrlEncodedDoubleSlash=true
#Set if semicolon is allowed in the URL (i.e. matrix variables)
allowSemicolon=true
#Set if a percent "%" that is URL encoded "%25" should be allowed in the path or not
allowUrlEncodedPercent=true
#if a period "." that is URL encoded "%2E" should be allowed in the path or not
allowUrlEncodedPeriod=true
```