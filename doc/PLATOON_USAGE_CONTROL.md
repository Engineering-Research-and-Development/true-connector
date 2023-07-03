# Usage Control database

Usage control application uses in-memory database with persisting db on file system (in uc-dataapp_resources_consumer and dataapp_resources_provider folders). This setup can be used for some small POC projects, to verify if integration is working and similar, but for real use case scenario, some more resilient database should be used, for example PostgreSQL (provided config) or some other database.

In order to switch to PostgreSQL database, following steps are needed:

 - modify docker compose file, and add 2 PostgreSQL services, one for Provider and one for Consumer:
 
```
  postgres_provider:
    image: postgres
    hostname: postgres_provider
    ports:
      - "5432:5432"
    env_file:
      - ./postgres_provider.env
    volumes:
      - ./app_provider:/var/lib/postgresql/data


  postgres_consumer:
    image: postgres
    hostname: postgres_consumer
    ports:
      - "5444:5432"
    env_file:
      - ./postgres_consumer.env
    volumes:
      - ./app_consumer:/var/lib/postgresql/data

```

 - add dependency for usage control applications to postgres
 
```
  uc-dataapp-provider:
  ...
    depends_on:
      - postgres_provider
      
  uc-dataapp-consumer:
  ...
    depends_on:
      - postgres_consumer

```

 - modify usage control property files, both for *uc-dataapp_resources_provider* 
 
```
## H2 DB with persisting on disk
#spring.datasource.url=jdbc:h2:file:/etc/platoon_db_provider
#spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
#spring.datasource.driver-class-name=org.h2.Driver

## PostgreSQL
spring.jpa.database=POSTGRESQL
spring.datasource.url = jdbc:postgresql://postgres_provider:5432/usagecontrol_provider
spring.datasource.driver-class-name = org.postgresql.Driver
spring.jpa.database-platform = org.hibernate.dialect.PostgreSQLDialect

```

and *uc-dataapp_resources_consumer* 

```
## H2 DB with persisting on disk
#spring.datasource.url=jdbc:h2:file:/etc/platoon_db_consumer
#spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
#spring.datasource.driver-class-name=org.h2.Driver

##PostgreSQL
spring.jpa.database=POSTGRESQL
spring.datasource.url = jdbc:postgresql://postgres_consumer:5432/usagecontrol_consumer
spring.datasource.driver-class-name = org.postgresql.Driver
spring.jpa.database-platform = org.hibernate.dialect.PostgreSQLDialect

```

 - postgres env file
 
2 env files needed for PostgreSQL should be created, in root of TRUE Connector directory: 

*postgres_provider.env* with content

```
POSTGRES_USER=connector
POSTGRES_PASSWORD=12345
POSTGRES_DB=usagecontrol_provider

```

*postgres_consumer.env* with content

```
POSTGRES_USER=connector
POSTGRES_PASSWORD=12345
POSTGRES_DB=usagecontrol_consumer

```

# Usage control examples

For more information and examples of policies compatible with Platoon UC app, please check [README](https://github.com/Engineering-Research-and-Development/true-connector-uc_data_app_platoon/blob/master/README.md)

