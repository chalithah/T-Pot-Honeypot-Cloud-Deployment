# 🚀T-Pot-Honeypot-Cloud-Deployment (Ubuntu 24.04 on Vultr)
Real-world cyberattack monitoring using T-Pot honeypot on Vultr cloud with Elastic Stack, firewall configuration, and DevSecOps best practices.
This guide explains how to securely deploy the [T-Pot Honeypot Platform](https://github.com/telekom-security/tpotce) on a Vultr cloud server using Ubuntu 24.04 LTS.

---

## 1️⃣ Provision the Vultr Server

1. Go to [Vultr](https://www.vultr.com/)
2. Choose **Cloud Compute** as server type
3. Select **Ubuntu 24.04 LTS x64** as the operating system
4. Choose a server plan with at least:
   - 6 GB RAM
   - 2 vCPUs
   - 128 GB SSD
5. Add your **SSH key** for secure access
6. Deploy the server

---

## 2️⃣ Initial Setup (as Root)

SSH into the server:

```bash
ssh root@<your_server_ip>

---

Update the system:

```bash
apt update && apt upgrade -y

Install Git:

```bash
apt install git -y

---

## 3️⃣ Create a Non-Root User for T-Pot

T-Pot must be installed as a non-root user:

# Create a new user
adduser tsec

# Grant sudo access
usermod -aG sudo tsec

# Switch to the new user
su - tsec


