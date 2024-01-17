# Managing OS Roles and Permissions

***NOTE:*** General advice is to have only one admin (root) user per OS, in case you have specific need for additional user, proceed with the next steps.

### Requirements
- A Linux system (e.g., Debian, Ubuntu, CentOS)
- Sudo or root access

### Steps

#### Managing Users and Groups
- **Add User**: `sudo adduser [username]`
- **Add Group**: `sudo addgroup [groupname]`
- **Add User to Group**: `sudo adduser [username] [groupname]`
- **List Users**: `cat /etc/passwd`
- **List Groups**: `cat /etc/group`

#### Managing File Permissions
- **Change File Ownership**: `sudo chown [user]:[group] [file]`
- **Change Permissions**: `chmod [permissions] [file]`
  - Permissions are represented as a number for owner, group, and others (e.g., 755).
- **View File Permissions**: `ls -l [file]`

#### Sudoers File for Role Assignment
- **Edit Sudoers File**: `sudo visudo`
  - This file controls who can run what commands as root.
- **Add User to Sudoers**: Add a line like `[username] ALL=(ALL) ALL`

#### Managing Services and Daemons
- **Start/Stop Service**: `sudo systemctl start [service]`
- **Enable/Disable Service on Boot**: `sudo systemctl enable [service]`

---

### Best Practices
- **Principle of Least Privilege**: Always assign the minimum necessary permissions.
- **Regular Audits**: Periodically review user roles and permissions.
- **Backup**: Always have a backup before making significant changes, especially in Linux `/etc` directory 
- **Mandatory Access Control**: As an OS administrator, it is essential to implement strict access control measures. Ensure that each user is assigned to the correct group with appropriate file permissions. Regularly verify that a user (User X) cannot access files belonging to another user (User Y), especially in shared or networked environments. This can be achieved through careful configuration of user accounts, groups, and permissions, along with the use of tools like Access Control Lists (ACLs) in Linux.
---

