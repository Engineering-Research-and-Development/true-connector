## Introduction <a href="#introduction" id="introduction"></a>

Once you clone or download repository, you will have following directory structure, with following directories:

```
be-dataapp_data_receiver - containing data needed for receiver/provider dataApp, files to share...
be-dataapp_data_sender
be-dataapp_resources - directory containing property file used for advanced configuration for both dataApps
ecc_cert - directory used to store certificate files (DAPS certificate, HTTPS certificate, truststore...)
ecc_resources_consumer - directory containing property file for consumer ECC advanced configuration
ecc_resources_provider - directory containing property file for provider ECC advanced configuration
kubernetes - directory containing yaml files to have TRUE Connector in a Kubernetes enviroment

Platoon Usage control related (contains property file for usage control data app):
uc-dataapp_resources_consumer
uc-dataapp_resources_provider
```

TRUE Connector comes as dockerized application, which consists of few docker containers:

* provider execution core container
* provider data application (sample data application)
* provider usage control application
* consumer execution core container
* consumer data application (sample data application)
* consumer usage control application