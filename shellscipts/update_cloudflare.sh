#!/bin/bash

# Variables
ZONE_ID="67c26af8f3ad636c7ed357924aad55fd"        # Your Cloudflare Zone ID
API_TOKEN="4qcdMJ0ZD3fAM4xOyE90pmN05DFawlNvHgaSoO34"    # Your Cloudflare API Token

# IPv4 Variables
DNS_RECORD_ID_IPV4="4f8f6f74963022c7692550d0e2b073eb"  # DNS Record ID for IPv4
IPV4=$(curl -s http://ipv4.icanhazip.com)  # Get public IPv4 address
CF_API_IPV4="https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$DNS_RECORD_ID_IPV4"

# IPv6 Variables
DNS_RECORD_ID_IPV6="ed4450fef4db941f951f1491e02decf4"  # DNS Record ID for IPv6
IPV6=$(curl -s http://ipv6.icanhazip.com)  # Get public IPv6 address
CF_API_IPV6="https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$DNS_RECORD_ID_IPV6"

# Update IPv4 DNS Record
response_ipv4=$(curl -s -X PUT "$CF_API_IPV4" \
    -H "Authorization: Bearer $API_TOKEN" \
    -H "Content-Type: application/json" \
    --data "{\"type\":\"A\",\"name\":\"kiganoakuma.cc\",\"content\":\"$IPV4\",\"ttl\":120,\"proxied\":false}")

# Check IPv4 Response
if echo "$response_ipv4" | grep -q '"success":true'; then
    echo "IPv4 DNS record updated successfully: kiganoakuma.cc -> $IPV4"
else
    echo "Failed to update IPv4 DNS record:"
    echo "$response_ipv4"
fi

# Update IPv6 DNS Record
response_ipv6=$(curl -s -X PUT "$CF_API_IPV6" \
    -H "Authorization: Bearer $API_TOKEN" \
    -H "Content-Type: application/json" \
    --data "{\"type\":\"AAAA\",\"name\":\"kiganoakuma.cc\",\"content\":\"$IPV6\",\"ttl\":120,\"proxied\":false}")

# Check IPv6 Response
if echo "$response_ipv6" | grep -q '"success":true'; then
    echo "IPv6 DNS record updated successfully: kiganoakuma.cc -> $IPV6"
else
    echo "Failed to update IPv6 DNS record:"
    echo "$response_ipv6"
fi
