#!/bin/bash
if [ -z "$1" ]; then
    echo "[!] Usage: ./whois_enum.sh <domain>"
    exit 1
fi
target=$1
output_file="../scans/whois_${target}.txt"
echo "======================================="
echo "[+] WHOIS Enumeration"
echo "[+] Target: $target"
echo "======================================="
whois $target > $output_file 2>&1
echo "[✓] Output saved to $output_file"
