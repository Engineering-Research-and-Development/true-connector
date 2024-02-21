# Postgre configuration

Both ECC and UCApp uses in-memory database (H2) with persisting db on file system. This setup can be used for some small POC projects, to verify if integration is working and similar, but for real use case scenario, some more resilient database should be used, for example PostgreSQL (provided config) or some other database.

In order to switch to PostgreSQL database, following steps are needed:

 - Modify docker compose file, and add 2 PostgreSQL services, one for Provider and one for Consumer:
 
```
  postgres_provider:
    image: postgres:16.2-alpine3.19
    hostname: postgres_provider
    ports:
      - "5432:5432"
    networks:
      - provider
    env_file:
      - ./postgres_provider.env
    volumes:
      - ./app_provider:/var/lib/postgresql/data
      - ./create-multiple-postgresql-databases.sh:/docker-entrypoint-initdb.d/create-multiple-postgresql-databases.sh

  postgres_consumer:
    image: postgres:16.2-alpine3.19
    hostname: postgres_consumer
    ports:
      - "5433:5432"
    networks:
      - consumer
    env_file:
      - ./postgres_consumer.env
    volumes:
      - ./app_consumer:/var/lib/postgresql/data
      - ./create-multiple-postgresql-databases.sh:/docker-entrypoint-initdb.d/create-multiple-postgresql-databases.sh


```

 - Add dependency for ECC and UCApp to postgres
 
```
  ecc-provider:
  ...
    depends_on:
      - postgres_provider
      
  ecc-consumer:
  ...
    depends_on:
      - postgres_consumer

  uc-dataapp-provider:
  ...
    depends_on:
      - postgres_provider
      
  uc-dataapp-consumer:
  ...
    depends_on:
      - postgres_consumer

```

 - Modify usage control property files, for `ecc_resources_provider` 
 
```
#H2 properties
#spring.datasource.url=jdbc:h2:file:/home/nobody/data/audit_logs_provider;CIPHER=AES
#spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
#spring.datasource.driver-class-name=org.h2.Driver
spring.h2.console.enabled=false

##PostgreSQL
spring.jpa.database=POSTGRESQL
spring.datasource.url = jdbc:postgresql://postgres_provider:5432/ecc_provider
spring.datasource.driver-class-name = org.postgresql.Driver
spring.jpa.database-platform = org.hibernate.dialect.PostgreSQLDialect

spring.datasource.username=connector
spring.datasource.password=12345
spring.jpa.show-sql=false
spring.jpa.generate-ddl=true
spring.jpa.hibernate.ddl-auto=update
spring.jpa.properties.hibernate.jdbc.lob.non_contextual_creation=true
```

and `ecc_resources_consumer` 

```
#H2 properties
#spring.datasource.url=jdbc:h2:file:/home/nobody/data/audit_logs_consumer;CIPHER=AES
#spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
#spring.datasource.driver-class-name=org.h2.Driver
spring.h2.console.enabled=false

##PostgreSQL
spring.jpa.database=POSTGRESQL
spring.datasource.url = jdbc:postgresql://postgres_consumer:5432/ecc_consumer
spring.datasource.driver-class-name = org.postgresql.Driver
spring.jpa.database-platform = org.hibernate.dialect.PostgreSQLDialect

spring.datasource.username=connector
spring.datasource.password=12345
spring.jpa.show-sql=false
spring.jpa.generate-ddl=true
spring.jpa.hibernate.ddl-auto=update
spring.jpa.properties.hibernate.jdbc.lob.non_contextual_creation=true

```

and  `uc-dataapp_resources_provider` 
 
```
## H2 DB with persisting on disk
#spring.datasource.url=jdbc:h2:file:/home/nobody/data/platoon_db_provider;CIPHER=AES
#spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
#spring.datasource.driver-class-name=org.h2.Driver
spring.h2.console.enabled=false

## PostgreSQL
spring.jpa.database=POSTGRESQL
spring.datasource.url = jdbc:postgresql://postgres_provider:5432/usagecontrol_provider
spring.datasource.driver-class-name = org.postgresql.Driver
spring.jpa.database-platform = org.hibernate.dialect.PostgreSQLDialect

spring.datasource.platform = usagecontrol
spring.datasource.username = connector
spring.datasource.password = 12345
spring.jpa.show-sql=false
spring.jpa.generate-ddl=true
spring.jpa.hibernate.ddl-auto=update
spring.jpa.properties.hibernate.jdbc.lob.non_contextual_creation=true
```

and `uc-dataapp_resources_consumer` 

```
## H2 DB with persisting on disk
#spring.datasource.url=jdbc:h2:file:/home/nobody/data/platoon_db_consumer;CIPHER=AES
#spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
#spring.datasource.driver-class-name=org.h2.Driver
spring.h2.console.enabled=false

# PostgreSQL
spring.jpa.database=POSTGRESQL
spring.datasource.url = jdbc:postgresql://postgres_consumer:5432/usagecontrol_consumer
spring.datasource.driver-class-name = org.postgresql.Driver
spring.jpa.database-platform = org.hibernate.dialect.PostgreSQLDialect

spring.datasource.platform = usagecontrol
spring.datasource.username = connector
spring.datasource.password = 12345
spring.jpa.show-sql=false
spring.jpa.generate-ddl=true
spring.jpa.hibernate.ddl-auto=update
spring.jpa.properties.hibernate.jdbc.lob.non_contextual_creation=true
```

 - Postgres env file
 
2 env files needed for PostgreSQL should be created, in root of TRUE Connector directory: 

`postgres_provider.env` with content

```
POSTGRES_USER=connector
POSTGRES_PASSWORD=12345
POSTGRES_MULTIPLE_DATABASES=usagecontrol_provider, ecc_provider
```

`postgres_consumer.env` with content

```
POSTGRES_USER=connector
POSTGRES_PASSWORD=12345
POSTGRES_MULTIPLE_DATABASES=usagecontrol_consumer, ecc_consumer
```

 - Script for creating multiple databases

Script `create-multiple-postgresql-databases.sh` should be created with content:

```
#!/bin/bash

set -e
set -u

function create_database() {
    local database=$1
    echo "  Creating database '$database'"
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname="postgres" <<-EOSQL
        CREATE DATABASE $database;
        GRANT ALL PRIVILEGES ON DATABASE $database TO $POSTGRES_USER;
EOSQL
}

if [ -n "$POSTGRES_MULTIPLE_DATABASES" ]; then
    echo "Multiple database creation requested: $POSTGRES_MULTIPLE_DATABASES"
    for db in $(echo $POSTGRES_MULTIPLE_DATABASES | tr ',' ' '); do
        create_database $db
    done
    echo "Multiple databases created"
fi
```

After saving script, please ensure that script is executable. If it is not executable, you can make it executable using the following terminal command:

```bash
chmod +x create-multiple-postgresql-databases.sh
```

