# NTP Server Setup Guide

## Setting Up an NTP Server on Linux

### Requirements
- A Linux system (e.g., Debian, Ubuntu, CentOS)
- Sudo or root access
- Internet connection

### Steps
1. **Install NTP**
   - Update package list: `sudo apt update` (Debian/Ubuntu) or equivalent.
   - Install NTP package: `sudo apt install ntp` (Debian/Ubuntu) or equivalent.

2. **Configure NTP Server**
   - Edit the NTP configuration file: `sudo nano /etc/ntp.conf`.
   - Add NTP server lines, e.g., `server 0.pool.ntp.org`.

3. **Start and Enable NTP Service**
   - Start NTP service: `sudo systemctl start ntp`.
   - Enable NTP service on boot: `sudo systemctl enable ntp`.

4. **Verify NTP Service**
   - Check service status: `sudo systemctl status ntp`.
   - Check synchronization: `ntpq -p`.

5. **Synchronize OS Clock**
   - Manually update system clock: `sudo ntpdate pool.ntp.org`.

### Additional Notes
- Ensure firewall settings allow UDP traffic on port 123.
- Regularly monitor service status and synchronization.

---

## Setting Up an NTP Server on Windows

### Requirements
- A Windows machine (Windows Server recommended)
- Administrator access

### Steps
1. **Enable Windows NTP Server**
   - Open Registry Editor: `regedit`.
   - Navigate to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpServer`.
   - Set `Enabled` to `1`.

2. **Configure Windows Time Service**
   - Open Services: `services.msc`.
   - Locate `Windows Time`, set to `Automatic`, and start the service.

3. **Set NTP Settings**
   - Open Command Prompt as Admin.
   - Configure NTP source: `w32tm /config /manualpeerlist:"time.windows.com" /syncfromflags:manual /reliable:YES /update`.

4. **Restart Windows Time Service**
   - Restart service: `net stop w32time && net start w32time`.

5. **Manual Sync and Status Check**
   - Force sync: `w32tm /resync`.
   - Check status: `w32tm /query /status`.

### Additional Notes
- Adjust firewall to allow NTP traffic (UDP port 123).
- Regular checks of the service are recommended.

