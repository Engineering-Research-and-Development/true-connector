### Audit logs <a href="#auditlogs" id="auditlogs"></a>

Audit logging is turned **off** by default. If you wish to configure it or even turn off please follow this [document](https://github.com/Engineering-Research-and-Development/true-connector-execution\_core\_container/blob/1.14.3/doc/AUDIT.md) .


## Accessing audit logs

Access to the audit logs should be allowed only to the person responsible for configuring and setting up TRUE Connector. Logs are stored in docker volumes, and in default configuration those docker volumes are:

ecc_provider
ecc_consumer

Once audit events are turned on, and docker containers are up and running, you can inspect the from the terminal, and access the one for the Execution Core Container by executing command:

```
docker exec -it ecc-consumer /bin/sh
```

Once you manage to connect to container, you can navigate to */home/nobody/data/log/ecc* and verify that log and audit files are present. File might be empty, if there are no actions are performed so far, sure to have some interaction with the connector, to verify that file is being updated. 

```
/home/nobody/data/log/ecc $ ls -la
total 12
drwxr-xr-x    2 nobody   nogroup       4096 Jul 25 16:01 .
drwxr-xr-x    1 root     root          4096 Jul 19 09:47 ..
-rw-r--r--    1 nobody   nobody        1579 Jul 27 10:17 true_connector_audit_consumer.log
-rw-r--r--    1 nobody   nobody       55019 Jul 27 10:37 true_connector_consumer.log
/home/nobody/data/log/ecc $
```

Content of the file is consisted of json entries.

## Trace log file

Trace log file contains logs that can be useful when debugging or investigating what was incorrect and why connector is responding as expected. In cases when connector does not start, or if response is not expected, some rejection message is returned instead any other response, good starting point is to check content of this log file and get information why connector is not responding as expected. 

User might try to solve the problem, in most cases problem will be configuration related or that invalid values are passed.