# 🛡️ T-Pot Honeypot Deployment on Vultr (Ubuntu 24.04)

This project documents the secure deployment of the [T-Pot Honeypot Platform](https://github.com/telekom-security/tpotce) on a Vultr cloud instance using Ubuntu 24.04 LTS. The honeypot collects, analyzes, and visualizes real-world cyberattacks through Docker-based sensors and Kibana dashboards.

---

## 1️⃣ Provision the Vultr Server

1. Go to [Vultr](https://www.vultr.com/)
2. Choose **Cloud Compute**
3. Select **Ubuntu 24.04 LTS x64**
4. Choose a plan with at least:
   - 6 GB RAM  
   - 2 vCPUs  
   - 128 GB SSD  
5. Add your **SSH key**
6. Click **Deploy**

---

## 2️⃣ Initial Setup (as Root)

SSH into your new server:

```bash
ssh root@<your_server_ip>
```

Update and upgrade the system:

```bash
apt update && apt upgrade -y
```

Install Git:

```bash
apt install git -y
```

---

## 3️⃣ Create a Non-Root User for T-Pot

Create a secure user to run the honeypot platform:

```bash
adduser tsec
usermod -aG sudo tsec
su - tsec
```

---

## 4️⃣ Install T-Pot

Clone the T-Pot repository and run the installer:

```bash
git clone https://github.com/telekom-security/tpotce
cd tpotce
./install.sh --type=user
```

- Choose the **Standard** installation when prompted.
- Set a strong password for the web UI.

---

## 5️⃣ Reboot the Server

After installation:

```bash
reboot
```

> ⚠️ The first boot may take 5–10 minutes while containers initialize.

---

## 6️⃣ Configure Vultr Firewall

Create inbound rules in your Vultr firewall group:

| Action | Protocol | Ports       | Source     | Description                                 |
|--------|----------|-------------|------------|---------------------------------------------|
| Accept | TCP      | 1–65535     | 0.0.0.0/0  | Allow all TCP traffic for honeypots         |
| Accept | UDP      | 1–65535     | 0.0.0.0/0  | Allow all UDP traffic for honeypots         |
| Accept | TCP      | 64294–64297 | 0.0.0.0/0  | Access to Web UI, Kibana, and Admin         |
| Drop   | Any      | All         | 0.0.0.0/0  | Block all other traffic                     |


---

## 7️⃣ Access the Dashboards

Once the system is up, open the following URLs in your browser:

- T-Pot Admin UI: `https://<your-ip>:64294`
- Kibana Dashboard: `https://<your-ip>:64297/kibana`
- Real-Time Map: `https://<your-ip>:64297/map/`

> 🔒 Note: Accept the browser warning for self-signed certificates.

---

## ✅ Done!

Your honeypot is now live, collecting real-world attack data and exposing it via rich dashboards. This project demonstrates:

- Cloud infrastructure setup on Vultr
- Secure firewall configuration
- Honeypot monitoring using Elastic Stack
- DevSecOps operational deployment

---

## 📘 Next Steps

- [ ] Analyze logs with custom scripts
- [ ] Integrate alerts or reports
- [ ] Lock down admin access with VPN or IP whitelisting
- [ ] Export logs to SIEM (Splunk, Sentinel, etc.)

---

## 👤 Author

**Chalitha Handapangoda**  
Cloud Security | DevSecOps | Honeypots | AWS  
🔗 [LinkedIn](https://www.linkedin.com/in/chalitha-handapangoda/) • 📝 [Medium](https://chalithah.medium.com)

