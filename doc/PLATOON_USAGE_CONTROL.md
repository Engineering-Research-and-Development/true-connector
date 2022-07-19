# Usage Control database

Usage control application uses in-memory database with persisting db on file system (in uc-dataapp_resources_consumer and dataapp_resources_provider folders). This setup can be used for some small POC projects, to verify if integration is working and similar, but for real use case scenario, some more resilient database should be used, for example PostgreSQL (provided config) or some other database.

In order to switch to PostgreSQL database, following steps are needed:

 - modify docker compose file, and add 2 postgres services, one for Consumer and one for Provider
 
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

 - modify usage control property files, both for consumer and provider *uc-dataapp_resources_provider* and *uc-dataapp_resources_consumer* folders (you should enable PostgreSQL properties and disable H2)
 
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
 
2 env files needed for postgres should be created (or use existing ones if provided). If those 2 files are not present, create them, named 

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

## Importing rule in UsageControl dataApp

Until negotiation process is implemented, provided UsageControl dataApp exposes endpoint for importing rules. Following endpoint, for Consumer Usage Control app, can be found at:

```
http://{IPADDRESS}:9553/platoontec/PlatoonDataUsage/1.0/swagger-ui/index.html?configUrl=/platoontec/PlatoonDataUsage/1.0/v3/api-docs/swagger-config
```

For Provider, change port to 9552.

Here, you can import rules, using Contract Agreement endpoint.


## Time-Based Interval Rule

The following rule describes the time interval in which it is allowed to access the resource with a specific identifier defined using the “target” property of the rule.

The snippet below is located an example of time-based rule: leftOperand is the start date and rightOperand represents the end date, in the specific case the message can be consumed only from 1st January 2022 to 31st December 2022.

[Time-Based Interval Rule](policy_examples/time_constraint.json)

## Spatial-Based Rule - Location

The following rule describes a location-based rule, which allows or inhibits the usage of resources with id defined in the target property based on connector location (country).

The snippet below is located an example of spatial-based rule: the rightOperand contains value IT, which tells that the resource can be consumed only by connectors that are located in Italy


[Spatial - Based Rule - Location](policy_examples/access_location.json)


## Purpose-Based Rule

The purpose-based class of rules allows or inhibits the usage of resources with an identifier defined in the target property based on message purpose.

In the snippet below is located an example of spatial-based rule: the rightOperand contains the value http://example.com/ids-purpose:Marketing, which tells that the resource is available for messages that have a purpose defined as Marketing.

[Purpose - Based Rule](policy_examples/purpose.json)


## Complex Rule

Rules can be composed in order to create complex permission definitions. The following rule describes a complex based rule, which contains 3 simple rules: spatial, purpose and time interval based. All those simple rules must be evaluated as true in order to allow the usage of the resource. If any of the simple rules is evaluated as false, then the resource usage is inhibited.

In the snippet below is located an example of the complex rule: spatial rule defines that the connector must be in Italy, purpose is Marketing and time base rule defines that the resource can be consumed until 31st December 2022.

[Complex Rule](policy_examples/complex.json)


## NOT APPLICABLE AT TEH MOMENT - Modifier Rule

### Anonymize
The following rule describes an example of modifier rule, anonymize, which will modify the payload response using json path. The current limitation is that the payload must be json string in order to be able to apply rules with modifiers.

In the snippet below is located an example of modifier rule: replaceWith filed tells which string will be used to replace the current value (dateOfBirth will be replaced with xxxx).

[Anonymize field in transit Rule](https://github.com/Engineering-Research-and-Development/true-connector-uc_data_app/blob/master/src/main/resources/policy-examples/0.0.3/3%20anonymize-in-transit-replace.json)


Example of payload, on which policy will be applied:

```
{
   "firstName":"John",
   "lastName":"Doe",
   "address":"591  Franklin Street, Pennsylvania",
   "checksum":"ABC123 2020/11/03 11:56:25",
   "dateOfBirth":"2020/11/03 11:56:25"
}
```

Palyoad after policy is applied:

```
{
   "firstName":"John",
   "lastName":"Doe",
   "address":"591  Franklin Street, Pennsylvania",
   "checksum":"ABC123 2020/11/03 11:56:25",
   "dateOfBirth":"xxxx"
}
```

### Delete
The following rule describes another example of modifier rule, delete, which will modify the payload response, removing the specified entry from the payload (defined through the jsonPath property). The current limitation is that payload must be a json string in order to be able to apply rules based on modifiers.

In the snippet below is located a running example of modifier rule: the jsonPath field will be used to evaluate and remove following the specified object (dateOfBirth) from the payload.

[Delete field in transit Rule](https://github.com/Engineering-Research-and-Development/true-connector-uc_data_app/blob/master/src/main/resources/policy-examples/0.0.3/33%20anonymize-in-transit-delete.json)


Example of payload, on which policy will be applied:

```
{
   "firstName":"John",
   "lastName":"Doe",
   "address":"591  Franklin Street, Pennsylvania",
   "checksum":"ABC123 2020/11/03 11:56:25",
   "dateOfBirth":"2020/11/03 11:56:25"
}
```
Palyoad after policy is applied:

```
{
   "firstName":"John",
   "lastName":"Doe",
   "address":"591  Franklin Street, Pennsylvania",
   "checksum":"ABC123 2020/11/03 11:56:25"
}
```

