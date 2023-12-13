
# OS Log Access Configuration Guide


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
