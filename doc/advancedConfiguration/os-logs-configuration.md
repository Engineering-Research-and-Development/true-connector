# OS Log Access Configuration Guide

The purpose of this guide is to provide instructions for configuring access to system logs on a Linux machine. Access to system logs is crucial for monitoring system activities, troubleshooting issues, and ensuring system security on which TRUE Connector is running. The guide is intended for Administrators who are setting up TRUE Connector and managing and monitoring Linux systems. It assumes a basic understanding of Linux file system structure and permissions.

***NOTE*** OS logs should not be mistaken for TRUE Connector audit or trace logs. 
### Prerequisites
- Root or sudo privileges on the Linux system.
- Basic understanding of Linux file system and permissions.

### Steps

1. **Open Terminal**
   - Access the terminal on the Linux machine.

2. **Add User to Required Groups**
   - Add the user to the `adm` group to allow reading system logs: 
     ```
     sudo usermod -a -G adm [username]
     ```

3. **Set Permissions for Log Files**
   - Change permissions of the log files (if necessary) to ensure readability:
     ```
     sudo chmod o+r /var/log/syslog
     ```

4. **Verify Access**
   - Switch to the user account and verify access to the logs:
     ```
     su - [username]
     cat /var/log/syslog
     ```

5. **Review and Confirm**
   - Ensure the user can read the necessary logs without issues.

### Additional Monitoring Configuration <a name="additional-monitoring-configuration"></a>

In addition to configuring access to system logs, it's important to establish rules for monitoring folders and property files associated with the TRUE Connector. This ensures comprehensive monitoring of relevant system activities. Follow these steps to set up monitoring rules:

- **Create Monitoring Rules with auditctl**: `auditctl` is a command-line utility that allows you to interact with the Linux audit framework, enabling you to define rules for monitoring system activities, for more details please refer to [manual page](https://manpages.ubuntu.com/manpages/xenial/en/man8/auditctl.8.html). When setting up monitoring for the TRUE Connector, you can use `auditctl` to create specific rules that define which files or directories to monitor and what actions to audit.

  For example, you can use the following command to create a rule for monitoring all files within the TRUE Connector directory: `auditctl -w /path/to/TRUEConnector -p war -k trueconnector`
  
  
  In this command:
	- `-w /path/to/TRUEConnector/*` specifies the path to the TRUE Connector directory and the asterisk (`*`) wildcard to monitor all files within it.
	- `-p war `  makes sure that all write, attribute change and read operations are logged.
	- `-k trueconnector` assigns a unique key (`trueconnector`) which makes the changes searchable via ausearch.
  
  The logs can be searched by using ausearch on the key: `ausearch -ts today -k trueconnector`

***NOTE:*** Make sure to replace `/path/to/TRUEConnector/` with the actual location where the TRUE Connector is deployed.

- **Persist Rules**: It's crucial to persist the auditing rules so that they are applied upon system restarts. Depending on the distribution of your operating system, you may need to add these rules to the `/etc/audit/audit.rules` file. Be mindful that the location may differ based on the OS distribution. Ensure these rules are correctly placed for effective monitoring.

By using `auditctl` to set up monitoring rules, you gain visibility into system activities related to the TRUE Connector, enabling proactive detection of any suspicious or unauthorized actions.
  

