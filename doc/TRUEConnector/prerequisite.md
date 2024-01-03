## Prerequisite <a href="doc/#prerequisite" id="prerequisite"></a>

To have secure and certification compliant environment, following prerequisites are mandatory to be performed before setting up TRUE Connector:

* NTP time server of the machine, where TRUE Connector will be deployed, has to be enabled and configured correctly. This will allow that once certificates are checked, correct time will be used to verify certificate, expired or not. This applies for both DAPS and TLS1.3 certificates. Connector will rely on OS time when checking certificates. How to setup NTP time server you can find [here.](../advancedConfiguration/ntp-server-configuration.md)
* Docker is mandatory "OS service" for running connector
* verify [System requirements](system-requirements.md) before starting the connector.

### Securing docker host

* The host OS should be audited and secure; OS should be as minimal as possible and it should be preferably used to host our Docker exclusively. There should not coexist other services like web servers or web applications so that attacker could not exploit it or lead to potential exploit (minimal threat attack surface).
* Monitoring mechanism (Linux auditd service for example) should be installed and configured as prerequisite before deploying connector. This will capture if someone tries to make changes on property files used by the connector.
* make sure to create rules to monitor folders and property files of the TRUE Connector (for example auditctl -w /xxxx/TRUEConnector/* -k trueconnector, depending on the location where TRUE Connector is deployed)
* make sure to create rules for monitoring docker service (dockerd, /run/containerc, /var/lib/docker, /etc/docker, docker.service...) This might differ based on OS distribution
* rules for auditing should be persisted (/etc/audit/audit.d/rules/audit.rules file, depending on the OS distribution, location might differ)
* make sure to create rules for mounted docker volumes (to be able to keep track of changes made over files present in those volumes)


* User responsible for setting up environment where connector will run should isolate or disable other services. 
* OS user for running docker should not be root user; be sure to create new user, assign new user to docker group, that user can run docker compose. How to manage OS users you can find [here.](../advancedConfiguration/manage-os-users.md)
* disable password login to the server for newly created user and allow only key-based authentication for accessing the server where connector will run
* disable access for the root user by using a password when connecting to the server via ssh (key-based auth only)
* in case of adding some additional, more configurable and robust firewall, be sure to restrict access to the /api/* endpoints to only internal network, since those endpoints should not be exposed to the outside world, but intended to be used by "internal" user, to make modifications to the self description document.


* 2 types of certificate are required: DAPS and TLS. 
DAPS certificate should be obtained from Certified Authority responsible for the Dataspace, while TLS certificate can be self signed or signed by some CA. More information about TLS certificate can be found [here](../security.md).


## Secure SSH server access

It is good practice to prevent any user that is not necessary from logging in via ssh. 
The ssh daemon provides configuration to only allow logins from users that are a member of a specific group.

```
 groupadd ssh_login_group
```

With this new group created the users who need to access the server via ssh need to be added to this group:

```
 usermod username -a -G ssh_login_group
```

With the users added to the group, the ssh daemon needs to be configured. 
Open the config file /etc/ssh/sshd_config with your favorite editor and add these lines:

```
PermitRootLogin no
AllowGroups ssh_login_group

```

### Disable password login

You probably want to disable password login to avoid someone logging in from somewhere else then the hosts you have configured in the authorized_keys file. To disable password authentication globally for all users, the following 3 settings need to be changed to "no" in the /etc/ssh/sshd_config file:

```
ChallengeResponseAuthentication no
PasswordAuthentication no
UsePAM no
AllowUsers bob alice...
```

### Create SSH public and private keys for user accessing host machine

As a first step, a key-pair needs to be created. This is usually done on the server. 
With the following command a new key-pair is created. 

```
ssh-keygen -t rsa -b 4096 -f ~/.ssh/desktop_key-rsa
```

In order to create the key, you will be asked for a password. This is the password for your key. If you don't want to have a password for your key, just press Enter at the password prompt. It is recommended and considered as best practice (and also security related) to enter passphrase. It will be used as security step, avoiding the usage of a stolen or lost private key. The result of this command should be two files. The file "\~/.ssh/desktop_key-rsa" which is the private-key file, and the file "~/.ssh/desktop_key-rsa.pub" which contains your public-key file. 
This public-key and private-key will be securely transferred to the client. This means that keys are transferred to the client machine without exposing the content of the file, following best practices for delivering files containing sensitive data.

public-key needs to be added to the authorized keys. To make sure we do not override any already configured authorized key, 
we add the public-key to the authorized_keys file. If the file does not yet exist, it will create it automatically:

```
cat desktop_key-rsa.pub >>~/.ssh/authorized_keys
```

### Authenticate with SSH key

The format of the "authorized_keys" file is as follows:

**options keytype base64-encoded-key comment**

options can contain filter like 

```
from="192.168.1.12" ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABA...etc...mnMo7n1DD username
```

This will enforce that user can log in into server using key authentication only from IP address 192.168.1.12

Make sure to change IP address to fit real use case. This additional layer of security, with IP address restriction , should be taken with caution. Client IP address should be fixed and must not change in time. Also, if client is behind some router or firewall then client machine IP address will not be the one reaching server.

Once public-key is uploaded to authorized_keys, user requesting access to the server should securely receive public and private key.
User can verify that connection with following:

```
ssh username@server.example.com -v -i .ssh/desktop_key-rsa
```

Note: username used in command to connect to the server needs to be added in sshd deamon configuration file

```
AllowUsers bob alice...
```

## Post configuration steps

Once TRUE Connector is successfully configured and is up and running, responsible user for setting up environment and configuring connector should generate new passwords for 2 type of users required for operating with connector. More information how to do this can be found [here](https://github.com/Engineering-Research-and-Development/true-connector-execution_core_container/blob/1.14.6/doc/SECURITY.md#change-default-password). 

Make sure to update following properties to address your usecase:


.env file

```
PROVIDER_ISSUER_CONNECTOR_URI=http://w3id.org/engrd/connector/provider
CONSUMER_ISSUER_CONNECTOR_URI=http://w3id.org/engrd/connector/consumer
```
and in ecc_resources_consumer and ecc_resources_provider application.property file:

```
application.selfdescription.description=Data Consumer Connector description
application.selfdescription.title=Data Consumer Connector title
application.selfdescription.curator=http://consumer.curatorURI.com
application.selfdescription.maintainer=http://consumer.maintainerURI.com

```
