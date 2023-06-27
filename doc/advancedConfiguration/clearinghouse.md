### Clearing House <a href="#clearinghouse" id="clearinghouse"></a>

The TRUE Connector supports is able to communicate with the Fraunhofer Clearing House for registering transactions.

Since Clearing house is disabled by default, in order to enable it, set following property to true:

```
application.isEnabledClearingHouse=true

```

Once Clearing House interaction is enabled, also configure location and credentials (if required) for the Clearing House by setting following properties: 

```
application.clearinghouse.username=
application.clearinghouse.password=
application.clearinghouse.baseUrl=
```

NOTE: Fraunhofer Clearing House implementation requires credentials for accessing.
