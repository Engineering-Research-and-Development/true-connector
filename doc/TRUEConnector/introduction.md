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
uc-dataapp_resources_consumer - Usage Control property file
uc-dataapp_resources_provider - Usage Control property file
uc-dataapp-pip_resources_consumer - define Role and Purpose of the Connector used in Policies
uc-dataapp-pip_resources_provider - define Role and Purpose of the Connector used in Policies
```

TRUE Connector comes as dockerized application, which consists of few docker containers:

* provider execution core container
* provider data application (sample data application)
* provider usage control application
* provider pip service (used in conjunction with usage control)
* consumer execution core container
* consumer data application (sample data application)
* consumer usage control application
* consumer pip service (used in conjunction with usage control)