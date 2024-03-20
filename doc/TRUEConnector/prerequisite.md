## Prerequisite <a href="doc/#prerequisite" id="prerequisite"></a>

To have secure and certification compliant environment, following prerequisites are mandatory to be performed before setting up TRUE Connector:

* NTP time server of the machine, where TRUE Connector will be deployed, has to be enabled and configured correctly. This will allow that once certificates are checked, correct time will be used to verify certificate, expired or not. This applies for both DAPS and TLS1.3 certificates. Connector will rely on OS time when checking certificates. How to setup NTP time server you can find [here.](../advancedConfiguration/ntp-server-configuration.md)
* Docker is mandatory "OS service" for running connector
* verify [System requirements](system-requirements.md) before starting the connector.

### Securing docker host

* The host OS should be audited and secure; OS should be as minimal as possible and it should be preferably used to host our Docker exclusively. There should not coexist other services like web servers or web applications so that attacker could not exploit it or lead to potential exploit (minimal threat attack surface).
* Monitoring mechanism (Linux auditd service for example) should be installed and configured as prerequisite before deploying connector. This will capture if someone tries to make changes on property files used by the connector.
* Make sure to create OS rules to monitor folders and property files of the TRUE Connector, more information available [here](../advancedConfiguration/os-logs-configuration.md#additional-monitoring-configuration)
* Make sure to create rules for monitoring docker service (dockerd, /run/containerc, /var/lib/docker, /etc/docker, docker.service...) This might differ based on OS distribution
* Rules for OS auditing should be persisted, more information available [here](../advancedConfiguration/os-logs-configuration.md#additional-monitoring-configuration)
* Make sure to create rules for mounted docker volumes (to be able to keep track of changes made over files present in those volumes)
* Make sure to create scripts to monitor storage capacity in order to notify when the OS system is reaching storage assigned capacity. Also use CroneTab to repeat those scripts at desired time interval. One example of how to write script and set CronTab to automate it can be found [here](https://tecadmin.net/shell-script-to-check-disk-space-and-send-alert/)
* User responsible for setting up environment where connector will run should isolate or disable other services. 
* If there is a need to create a new (SSH/OS) user which isn't admin (root) which is not recommendation, who would run the docker, be sure that new SSH/OS user is not the root one, so create a new user, assign new user to docker group, that user can run docker compose. How to manage OS users you can find [here.](../advancedConfiguration/manage-os-users.md)
* If there is a need to create a new user who would just inspect the TC logs via SSH access, follow the rest of the advices in this document, and then setup a crone job for copying logs from docker volumes to read-only folder on OS filesystem, which can be found [here](../advancedConfiguration/tc-logs-copying.md)
* Disable password login to the server for newly created user and allow only key-based authentication for accessing the server where connector will run
* Disable access for the root user by using a password when connecting to the server via ssh (key-based auth only)
* In case of adding some additional, more configurable and robust firewall, be sure to restrict access to the /api/* endpoints to only internal network, since those endpoints should not be exposed to the outside world, but intended to be used by "internal" user, to make modifications to the self description document.


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
AllowUsers sshUser1 sshUser2...
```

### Create SSH public and private keys for user accessing host machine

As the first step, a key pair needs to be created. Following best security practices, each ***user*** generates their asymmetric key pair and securely shares the public key with the OS administrator for implementation at the OS level.  The following command is used to create a new key pair.

```
ssh-keygen -t rsa -b 4096 -f ~/.ssh/desktop_key-rsa
```

* `ssh-keygen` - command used to create the public and private key pairs that SSH uses for secure communication between client and server.
* `-t rsa` - command used to create RSA (Rivest-Shamir-Adleman) key-pair widely used for secure data transmission, known for their security and efficiency
* `-b 4096` - specifies the key length, 4096 offers a good balance between security and performance, providing strong protection against brute-force attacks without being overly taxing on system resources.
* `-f ~/.ssh/desktop_key-rsa` -  specifies the filename for the key file

Using `-t rsa -b 4096` with `ssh-keygen` is essential for creating RSA keys of 4096 bits, improving security. The algorithm employed in the SSH communication protocol is the 4096-bit RSA asymmetric encryption algorithm. This method of key generation guarantees that the SSH keys for authentication are robust and secure against unauthorized access

In order to create the key, you will be asked for a password. This is the password for your key. It is recommended and considered as best practice (and also security related) to enter passphrase. It will be used as security step, avoiding the usage of a stolen or lost private key. The result of this command should be two files. The file "\~/.ssh/desktop_key-rsa" which is the private-key file, and the file "~/.ssh/desktop_key-rsa.pub" which contains your public-key file.
After the process is completed, the ***user*** must securely transfer the public-key to the OS administrator. This entails transferring the public-key without exposing the file's contents, following best practices for delivering files containing sensitive data. These practices may include using a password-protected zip archive, uploading to secure storage and providing a link to the responsible OS administrator, physically approaching the OS administrator and copying the key file from a USB stick, or employing any other applicable and suitable method for the company.

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
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABA...etc...mnMo7n1DD username
```

This will enforce that user can log in into server using key authentication.

Once public-key is uploaded to authorized_keys, user requesting access to the server should securely receive public and private key.
User can verify that connection with following:

```
ssh username@server.example.com -v -i .ssh/desktop_key-rsa
```

Note: username used in command to connect to the server needs to be added in sshd deamon configuration file and passphrase for that key needs to be entered when prompted.

```
AllowUsers sshUser1 sshUser2...
```


### Periodic SSH Key Update Procedure

To maintain security, OS administrators must periodically refresh SSH keys. This process must occur every three months (minimal, or even on lesser time frame if security policy requires). During each update cycle, administrators are responsible for informing users that they need to generate a new key pair and securely transfer the new public key. Failure to do so will make previous authorized keys invalid. This practice ensures that potential security risks associated with compromised or outdated keys are mitigated.

To facilitate this process, the following steps must be diligently followed:

* Generate New SSH Keys: Users must create new SSH key pairs.

* Distribute New Keys Securely: Once new keys are generated, the public-key must be securely transferred to OS administrator.

* Update the authorized_keys File: The new public keys must be added to the authorized_keys file on the server, replacing the old keys.

* Invalidate Old Keys: Remove the old public keys from the authorized_keys file to ensure they can no longer be used for server access.

* Communicate with Users: Inform all users about the key update and provide them with instructions on how to use the new keys for server access.

* Document the Changes: Keep a log of key updates and user assignments for administrative and security auditing purposes.

* Review and Test: After updating, conduct a thorough review and testing to ensure that only the new keys are operational and that server access is functioning as expected with the updated keys.


By regularly updating SSH keys every three months, OS administrators will enhance the security of server access, making sure these keys effectively protect against unauthorized entry.

## Secure DB

It's mandatory to set **AES-SECRET-KEY** as OS variable which is valid password for column encryption with AES/GCM/NoPadding algorithm.

## Post configuration steps

Once TRUE Connector is successfully configured and is up and running, responsible user for setting up environment and configuring connector should change existing TRUE Connector users, more information about user management can be found here [here](../user_management.md). 

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
