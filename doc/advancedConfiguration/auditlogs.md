### Audit logs <a href="#auditlogs" id="auditlogs"></a>

Audit logs must be turned on for a proper and secure deployment of the connector.
All audit events are stored in database (H2 with default configuration, possible to replace with PostgreSQL, more information can be found [here](../postgreConfiguration.md)), this way tampering of the logs is prohibited. Entries in database are done only by the Execution Core Container. Column for storing auditLog entry is encrypted using *AES/GCM/NoPadding* algorithm which requires user to set valid password. It must be done using environment variable with following name: *AES256-SECRET-KEY*. </br>
When ECC inserts audit entry into Database, AuditLog value will be encrypted using provided algorithm, and when data is requested, it will be decrypted.</br>

If you wish to configure it or even turn off please follow this [document](https://github.com/Engineering-Research-and-Development/true-connector-execution_core_container/blob/1.14.8/doc/AUDIT.md) .


## Accessing audit logs

ECC exposes protected endpoint, for API user, to fetch all audit logs, or audit logs for specific date:

```
https://localhost:8090/api/audit/
```

or for specific date

```
https://localhost:8090/api/audit/?date=2024-02-12
```

NOTE: date format must be in YYYY-MM-DD format. Otherwise response will be https 400 - bad request.

## Trace log file

Trace log file contains logs that can be useful when debugging or investigating what was incorrect and why connector is not responding as expected. 

User might try to solve the problem, in most cases problem will be configuration related or that invalid values are passed.

More information about OS logs on Host machine and how to configure it can be found [here](os-logs-configuration.md)