#!/bin/bash

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Update and upgrade system
apt update && apt upgrade -y

# Install Git
apt install git -y

# Create non-root user 'tsec' with sudo privileges
adduser tsec
usermod -aG sudo tsec

# Switch to user 'tsec' and install T-Pot
sudo -u tsec bash << EOF

# Clone T-Pot repository
git clone https://github.com/telekom-security/tpotce

# Navigate into T-Pot directory
cd tpotce

# Install T-Pot (standard user mode)
./install.sh --type=user

EOF

# Reboot after installation
reboot
