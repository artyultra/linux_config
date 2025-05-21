#!/bin/bash
DOMAIN="kigavpn"
TOKEN="a3a912dd-a753-4210-a7e5-1e8f08d13dcc"

# Get current IPv4 and IPv6 addresses
IPV4=$(curl -s https://ipv4.icanhazip.com)
IPV6=$(curl -s https://ipv6.icanhazip.com)

# Update DuckDNS
RESPONSE=$(curl -s "https://www.duckdns.org/update?domains=${DOMAIN}&token=${TOKEN}&ip=${IPV4}&ipv6=${IPV6}")

if [[ $RESPONSE == "OK" ]]; then
    echo "$(date): DuckDNS update successful" >> ~/duckdns.log
else
    echo "$(date): DuckDNS update failed: $RESPONSE" >> ~/duckdns.log
fi
