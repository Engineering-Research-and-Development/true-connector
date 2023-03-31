# Step to replicate True Connector installation in **minikube**.

Minikube is local Kubernetes, focusing on making it easy to learn and develop for Kubernetes. To install Minikube refer to the [official site](https://minikube.sigs.k8s.io/docs/start/ "official site").

- Start minikube:

```bash
foo@bar:~$ minikube start
```

- Start the consumer and provider configmaps: 

> Consumer Data APP configmap

```bash
foo@bar:~$ kubectl apply -f https://raw.githubusercontent.com/Engineering-Research-and-Development/true-connector/main/kubernetes/be-dataapp-consumer-configmap.yaml
```

expected result: 

`configmap/be-dataapp-consumer-configmap created`

------

> Provider Data APP configmap

```bash
foo@bar:~$ kubectl apply -f https://raw.githubusercontent.com/Engineering-Research-and-Development/true-connector/main/kubernetes/be-dataapp-provider-configmap.yaml
```

expected result: 

`configmap/be-dataapp-provider-configmap created`

------

> Consumer Execution Core Container configmap

```bash
foo@bar:~$ kubectl apply -f https://raw.githubusercontent.com/Engineering-Research-and-Development/true-connector/main/kubernetes/ecc-consumer-configmap-v.2.yaml
```

expected result: 

`configmap/ecc-consumer-configmap created`

------

> Provider Execution Core Container configmap

```bash
foo@bar:~$ kubectl apply -f https://raw.githubusercontent.com/Engineering-Research-and-Development/true-connector/main/kubernetes/ecc-provider-configmap-v.2.yaml
```

expected result: 

`configmap/ecc-provider-configmap created`

- Start the certificates configmap: 
  
Inside this configmap are present **ssl-server.jks** and **truststoreEcc.jks**.

```bash
foo@bar:~$ kubectl apply -f https://raw.githubusercontent.com/Engineering-Research-and-Development/true-connector/main/kubernetes/ca-pemstore.yaml
```

expected result: 

`configmap/ca-pemstore configured`

- Start the consumer and provider pods:

> Counsumer pod

```bash
foo@bar:~$ kubectl apply -f https://raw.githubusercontent.com/Engineering-Research-and-Development/true-connector/main/kubernetes/consumer-compiled-v-0.3.yaml
```

expected result: 

```
service/tc-consumer created
persistentvolumeclaim/be-dataapp-consumer-claim0 created
persistentvolumeclaim/be-dataapp-consumer-claim1 created
persistentvolumeclaim/be-dataapp-consumer-claim2 created
persistentvolumeclaim/ecc-consumer-claim0 created
persistentvolumeclaim/ecc-consumer-claim1 created
deployment.apps/tc-consumer created
```

------

> Provider pod

```bash
foo@bar:~$ kubectl apply -f https://raw.githubusercontent.com/Engineering-Research-and-Development/true-connector/main/kubernetes/provider-compiled-v-0.3.yaml
```

expected result: 

```
service/tc-provider created
persistentvolumeclaim/be-dataapp-provider-claim0 created
persistentvolumeclaim/be-dataapp-provider-claim1 created
persistentvolumeclaim/be-dataapp-provider-claim2 created
persistentvolumeclaim/ecc-provider-claim0 created
persistentvolumeclaim/ecc-provider-claim1 created
deployment.apps/tc-provider created
```

------

- Verify that the pods start up correctly:

```bash
foo@bar:~$ kubectl get all
```

expected result: 

```
NAME                               READY   STATUS    RESTARTS   AGE
pod/tc-consumer-6cc848947f-8sntk   2/2     Running   0          115s
pod/tc-provider-656c4f4f7c-nrqml   2/2     Running   0          46s

NAME                  TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)                                                                                                    AGE
service/kubernetes    ClusterIP      10.96.0.1      <none>        443/TCP                                                                                                    22d
service/tc-consumer   LoadBalancer   10.99.69.138   <pending>     8091:32294/TCP,8890:32639/TCP,8087:30477/TCP,8085:31467/TCP,9001:30996/TCP,8887:32061/TCP,8888:31512/TCP   115s
service/tc-provider   LoadBalancer   10.97.5.116    <pending>     8083:30392/TCP,9000:32497/TCP,8090:30782/TCP,8889:30036/TCP,8086:31100/TCP                                 46s

NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/tc-consumer   1/1     1            1           115s
deployment.apps/tc-provider   1/1     1            1           46s

NAME                                     DESIRED   CURRENT   READY   AGE
replicaset.apps/tc-consumer-6cc848947f   1         1         1       115s
replicaset.apps/tc-provider-656c4f4f7c   1         1         1       46s
```
To test the True Connector in minikube environment have to enable the **tunnel**. It creates a route to services deployed with type LoadBalancer and sets their Ingress to their ClusterIP. It must be run in a separate terminal window to keep the LoadBalancer running. Ctrl-C in the terminal can be used to terminate the process at which time the network routes will be cleaned up. 

```bash
foo@bar:~$ minikube tunnel
```

expected result: 

```
Status:	
	machine: minikube
	pid: 1463064
	route: 10.96.0.0/12 -> 192.168.49.2
	minikube: Running
	services: [tc-consumer, tc-provider]
    errors: 
		minikube: no errors
		router: no errors
		loadbalancer emulator: no errors
```

Now the services tc-consumer and tc-provider have an EXTERNAL-IP. In fact:

```bash
foo@bar:~$ kubectl get services
```

expected result: 

```
NAME          TYPE           CLUSTER-IP     EXTERNAL-IP    PORT(S)                                                                                                    AGE
kubernetes    ClusterIP      10.96.0.1      <none>         443/TCP                                                                                                    25d
tc-consumer   LoadBalancer   10.99.69.138   10.99.69.138  8091:32294/TCP,8890:32639/TCP,8087:30477/TCP,8085:31467/TCP,9001:30996/TCP,8887:32061/TCP,8888:31512/TCP   2d23h
tc-provider   LoadBalancer   10.97.5.116    10.97.5.116    8083:30392/TCP,9000:32497/TCP,8090:30782/TCP,8889:30036/TCP,8086:31100/TCP                                 2d23h
```

Test the true connector. Note that the ip in the request url is the tc-consumer EXTERNAL-IP. Note also the value of *Forward-To* property in the body is '**tc-provider**'. 

```bash
foo@bar:~$ curl -k --location 'https://10.99.69.138:8085/proxy' \
 --header 'fizz: buzz' \
 --header 'Content-Type: text/plain' \
 --header 'Authorization: Basic Y29ubmVjdG9yOnBhc3N3b3Jk' \
 --data '{ "multipart": "form", "Forward-To": "https://tc-provider:8889/data", "messageType": "ArtifactRequestMessage" , "requestedArtifact": "http://w3id.org/engrd/connector/artifact/1" , "payload" : { "catalog.offers.0.resourceEndpoints.path":"/pet2" } }'
```

expected result: 

```
{"firstName":"John","lastName":"Doe","address":"591  Franklin Street, Pennsylvania","checksum":"ABC123 2023/03/27 13:44:56","dateOfBirth":"2023/03/27 13:44:56"}
```

Using these two changes you can try same request present in Postman collection which can be used to initiate requests that are most commonly used.

[TRUEConnector.postman_collection](TRUEConnector.postman_collection.json)</br>

[TRUEConnector enviroment.postman_environment](TRUEConnector_enviroment.postman_environment.json)

This collection comes with predefined environments so be sure to also import environment file.
