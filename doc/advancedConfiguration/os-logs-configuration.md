
# OS Log Access Configuration Guide

## For Linux OS

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


## For Windows OS

### Prerequisites
- Administrative access to the Windows system.
- Basic knowledge of Windows security settings and User Account Control (UAC).

### Steps

1. **Open Local Security Policy**
   - Press `Win + R`, type `secpol.msc`, and press Enter.

2. **Navigate to User Rights Assignment**
   - In the Local Security Policy window, navigate to: `Security Settings` -> `Local Policies` -> `User Rights Assignment`.

3. **Edit Audit Policy**
   - Find and double-click on `Audit logon events`.
   - Add the user or group that needs log access.
   - Apply the changes.

4. **Grant Access to Event Viewer**
   - Right-click on `Start`, and select `Computer Management`.
   - Go to `System Tools` -> `Event Viewer`.
   - Right-click on `Event Viewer (Local)` and select `Properties`.
   - Under the `Security` tab, add the user or group and assign the appropriate permissions.

5. **Review and Apply Settings**
   - Confirm all settings are correctly applied.
   - Inform the user about the access granted.