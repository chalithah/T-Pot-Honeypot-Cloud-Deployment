# 🛡️ T-Pot Honeypot Cloud Deployment Project

This project documents the secure deployment of the [T-Pot Honeypot](https://github.com/telekom-security/tpotce) Platform on a Vultr cloud instance using Ubuntu 24.04 LTS. The honeypot collects, analyzes, and visualizes real-world cyberattacks through Docker-based sensors and Kibana dashboards.

---

## 🎯 Objective

The goal of this project is to observe common attack patterns on exposed cloud infrastructure. By running T-Pot in a controlled Vultr environment, I collected real-world threat data and analyzed it to gain insights on how attackers behave in the wild—especially relevant to airport and critical infrastructure security.

---

## 🛠️ Setup

### Vultr Instance Configuration

- OS: Ubuntu 24.04 LTS x64
- RAM: 16 GB
- SSD: 350 GB
- Region: Atlanta (Vultr)
- SSH: Key-based access only

---

## 🔧 Deployment Instructions

### 1️⃣ Provision the Vultr Server

1. Log in to [Vultr](https://www.vultr.com/)
2. Choose **Cloud Compute**
3. Select **Ubuntu 24.04 LTS x64**
4. Select a plan: 16 GB RAM, 350 GB SSD
5. Add your **SSH key**
6. Click **Deploy**

---

### 2️⃣ Initial Setup (as Root)

```bash
ssh root@<your_server_ip>
apt update && apt upgrade -y
apt install git -y
```

---

### 3️⃣ Create a Non-Root User for T-Pot

```bash
adduser tsec
usermod -aG sudo tsec
su - tsec
```

---

### 4️⃣ Install T-Pot

```bash
git clone https://github.com/telekom-security/tpotce
cd tpotce
./install.sh --type=user
```

- Select **Standard** installation
- Set a secure password for access

---

### 5️⃣ Reboot the Server

```bash
reboot
```

> ⚠️ First boot may take 5–10 minutes to initialize all containers.

---

### 6️⃣ Configure Vultr Firewall

| Action | Protocol | Ports       | Source     | Description                                 |
|--------|----------|-------------|------------|---------------------------------------------|
| Accept | TCP      | 1–65535     | 0.0.0.0/0  | Allow all TCP traffic for honeypots         |
| Accept | UDP      | 1–65535     | 0.0.0.0/0  | Allow all UDP traffic for honeypots         |
| Accept | TCP      | 64294–64297 | 0.0.0.0/0  | Access to Web UI, Kibana, and Admin         |
| Drop   | Any      | All         | 0.0.0.0/0  | Block all other traffic                     |

---

### 7️⃣ Access the Dashboards

- T-Pot Admin UI → `https://<your-ip>:64294`
- Kibana Dashboard → `https://<your-ip>:64297/kibana`
- Attack Map → `https://<your-ip>:64297/map/`

> 🔐 Accept browser warning for self-signed certificate.

---

## 🔐 Security Hardening

- Created non-root user (`tsec`) for deployment
- Disabled root SSH login and password authentication
- SSH secured with key-based access only
- Vultr Cloud Firewall rules applied to restrict traffic
- UI ports are public but can be locked to IP in production

---

## 📈 Findings – First 24 Hours

Collected insights using Elastic Stack visualizations:

- **45,000+ attacks** observed in under 24 hours
- **Top honeypots hit**: Cowrie (SSH), Dionaea, Honeytrap
- **Brute force usernames**: `root`, `admin`, `ubuntu`, `oracle`
- **Passwords tried**: `123456`, `admin123`, `Password1`, `ubuntu123`
- **Top IPs** from Iran, France, US, Netherlands
- **Suricata alerts** flagged:
  - IPv4 truncated packets
  - ICMP message anomalies
  - Suspicious TCP retransmissions

📸 Screenshots:

![Dashboard Summary](images/elastic-dashboard.png)
![Service Distribution](images/elastic-dashboard2.png)
![Raw Log View](images/kql-discovery.png)

---

## ✈️ Takeaways

- Infrastructure is scanned immediately upon exposure
- SSH remains a primary attack vector
- Public honeypots offer great learning for blue teams
- Highlights the importance of layered defense for high-risk targets (e.g., airports)

---

## 📘 What's Next

- Automate log archival and alerting
- Correlate attacks with threat intelligence feeds
- Weekly reports from dashboards
- Integration with SIEM platforms

---

## 🧠 Author

**Chalitha Handapangoda**  
Cloud & Security Enthusiast  
🔗 [LinkedIn](https://www.linkedin.com/in/chalitha-handapangoda/)  
📝 [Medium](https://chalithah.medium.com)



