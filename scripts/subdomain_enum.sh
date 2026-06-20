#!/bin/bash
if [ -z "$1" ]; then
    echo "[!] Usage: ./subdomain_enum.sh <domain>"
    exit 1
fi
target=$1
output_file="../scans/subdomains_${target}.txt"
echo "======================================="
echo "[+] Subdomain Enumeration"
echo "[+] Target: $target"
echo "======================================="
timeout 60 theHarvester -d $target -b crtsh > $output_file 2>&1
echo "[✓] Output saved to $output_file"
