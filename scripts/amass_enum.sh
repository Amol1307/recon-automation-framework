#!/bin/bash

if [ -z "$1" ]; then
    echo "[!] Usage: ./amass_enum.sh <domain>"
    exit 1
fi

target=$1
output_file="../scans/amass_${target}.txt"

echo "======================================="
echo "[+] AMASS Subdomain Enumeration"
echo "[+] Target: $target"
echo "======================================="

if command -v amass &> /dev/null; then
    timeout 120 amass enum -d $target > $output_file 2>&1
    echo "[✓] Output saved to $output_file"
else
    echo "[!] AMASS not installed. Install: apt install amass"
    echo "[!] Skipping AMASS scan..."
fi
