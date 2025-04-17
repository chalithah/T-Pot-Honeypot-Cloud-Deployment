#!/bin/bash
# Export Suricata alerts for the last 24h
docker exec -it logstash bash -c 'cat /var/log/suricata/eve.json' > logs/suricata_$(date +%F).json
