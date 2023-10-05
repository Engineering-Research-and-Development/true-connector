
### Broker <a href="#broker" id="broker"></a>

Location of the broker can be set by editing .env file and updating property:

```
BROKER_URL=https://broker.ids.isst.fraunhofer.de/infrastructure
```

TRUE Connector can register itself on startup, and also unregister when shutting down. To enable this, set 

```
application.selfdescription.registrateOnStartup=true
```

Information on how TRUE Connector can interact with Broker, can be found on following [link](https://github.com/Engineering-Research-and-Development/true-connector-execution\_core\_container/blob/1.14.4/doc/BROKER.md)
