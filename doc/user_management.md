# User management

TRUE Connector implements simple user management; 2 users, idsUser and apiUser are present in 2 property files, and are responsible for:

idsUser - interacts with Basic DataApp, initiates communication with connector
apiUser - interacts with Execution Core Container, makes modification for Self Description document

With their responsibilities, idsUser can be found and managed by modifying DataApp property file, 

```
application.security.password=$2a$10$MQ5grDaIqDpBjMlG78PFduv.AMRe9cs0CNm/V4cgUubrqdGTFCH3m

```

while apiUser is present in ecc property file. 

```
application.user.api.password=$2a$10$MQ5grDaIqDpBjMlG78PFduv.AMRe9cs0CNm/V4cgUubrqdGTFCH3m
```

Both user credentials are not persisted anywhere beside properties files, and their passwords are encoded using BcryptPasswordEncoder.


## Modifying password for a user

Once new password is generated, (described [here](https://github.com/Engineering-Research-and-Development/true-connector-execution_core_container/blob/1.14.6/doc/SECURITY.md#change-default-password)) user should send encoded password to the operations user, which should be the only one who can modify connector property file. That user will update property file and restart TRUE Connector, so that new password will be loaded by the connector.

