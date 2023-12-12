# NTP Server Setup Guide

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
