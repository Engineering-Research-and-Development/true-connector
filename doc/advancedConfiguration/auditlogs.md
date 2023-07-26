### Audit logs <a href="#auditlogs" id="auditlogs"></a>

Audit logging is turned **off** by default. If you wish to configure it or even turn off please follow this [document](https://github.com/Engineering-Research-and-Development/true-connector-execution\_core\_container/blob/1.14.1/doc/AUDIT.md) .


## Accessing audit logs

Access to the audit logs should be allowed only to the person responsible for configuring and setting up TRUE Connector. Lods are stored in docker volumes, and in default configuration those docker volumes are:

ecc_provider_log
ecc_consumer_log

Once audit events are turned on, and docker containers are up and running, you can inspect the from the terminal, and access the one for the Excecution Core Container by executing command:

```
docker exec -it ecc-consumer /bin/sh
```

Once you manage to log into container, you can navigate to */var/log/ecc* and verify that audit tile is present. File might be empty, if there are no actions performed so far, so be sure to have some interaction with the connector, to verify that file is being updated.

```
/var/log/ecc $ ls -la
total 12
drwxr-xr-x    2 nobody   nogroup       4096 Jul 25 16:01 .
drwxr-xr-x    1 root     root          4096 Jul 19 09:47 ..
-rw-r--r--    1 nobody   nobody        1578 Jul 25 16:09 true_connector_audit_consumer.log
/var/log/ecc $
```

Content of the file is consisted of json entries.