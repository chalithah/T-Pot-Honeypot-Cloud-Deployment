#!/bin/bash
# Extract top attacking IPs and prepare a blocklist (sample logic)
grep 'src_ip' logs/suricata_*.json | awk '{print $NF}' | sort | uniq -c | sort -nr | head -n 10
