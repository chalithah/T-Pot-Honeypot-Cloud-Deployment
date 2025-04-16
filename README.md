# T-Pot Honeypot Deployment Guide

This project documents the secure deployment of the T-Pot Honeypot([https://www.vultr.com/](https://github.security.telekom.com/2024/04/honeypot-tpot-24.04-released.html#get-and-install-t-pot)) Platform on a Vultr cloud instance using Ubuntu 24.04 LTS. The honeypot collects, analyzes, and visualizes real-world cyberattacks through Docker-based sensors and Kibana dashboards.

## 1️⃣ Provision the Vultr Server

# Launch a cloud instance on Vultr
1. Log in to [Vultr](https://www.vultr.com/)
2. Choose "Cloud Compute"
3. Select "Ubuntu 24.04 LTS x64"
4. Pick a server plan:
   - 6 GB RAM
   - 2+ vCPUs
   - 128 GB SSD
5. Add your public SSH key
6. Click "Deploy"

## 2️⃣ Initial Setup (as Root)

# SSH into the cloud instance
```bash
ssh root@<your_server_ip>
```

# Update and upgrade the system
```bash
apt update && apt upgrade -y
```

# Install Git version control
```bash
apt install git -y
```

## 3️⃣ Create a Non-Root User for T-Pot

# Create a new user to run T-Pot
```bash
adduser tsec
```

# Give the new user sudo privileges
```bash
usermod -aG sudo tsec
```

# Switch to the newly created user
```bash
su - tsec
```

## 4️⃣ Install T-Pot

# Clone the official T-Pot repository
```bash
git clone https://github.com/telekom-security/tpotce
```

# Navigate into the T-Pot directory
```bash
cd tpotce
```

# Run the T-Pot installation script in user mode
```bash
./install.sh --type=user
```

# Select 'Standard' installation when prompted and set a secure password.

## 5️⃣ Reboot the Server

# After install, reboot and wait for T-Pot to initialize
```bash
reboot
```

Note: First boot may take 5–10 minutes.

## 6️⃣ Configure Vultr Firewall

# Allow only necessary traffic into the server
| Action | Protocol | Ports       | Source     | Description                                 |
|--------|----------|-------------|------------|---------------------------------------------|
| Accept | TCP      | 1–65535     | 0.0.0.0/0  | Allow all TCP traffic for honeypots         |
| Accept | UDP      | 1–65535     | 0.0.0.0/0  | Allow all UDP traffic for honeypots         |
| Accept | TCP      | 64294–64297 | 0.0.0.0/0  | Access to Web UI, Kibana, and Admin         |
| Drop   | Any      | All         | 0.0.0.0/0  | Block all other traffic                     |

## 7️⃣ Access the Dashboards

# Web interfaces for monitoring honeypot activity
- T-Pot Admin UI: `https://<your-ip>:64294`
- Kibana Dashboard: `https://<your-ip>:64297/kibana`
- Real-Time Map: `https://<your-ip>:64297/map/`

Note: Accept browser warning for self-signed certificate.

## ✅ Done!

# Your honeypot is now live and collecting attack data.

## 📘 Next Steps

- Review Kibana analytics dashboard
- Automate log exports using Bash or Python
- Secure access with IP whitelisting or VPN

---

