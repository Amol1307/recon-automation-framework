#!/bin/bash
if [ -z "$1" ]; then
    echo "[!] Usage: ./headers.sh <domain>"
    exit 1
fi
target=$1
output_file="../scans/headers_${target}.txt"
echo "======================================="
echo "[+] HTTP Header Enumeration"
echo "[+] Target: $target"
echo "======================================="
for protocol in https http; do
    echo "[*] Checking $protocol://$target" >> $output_file
    curl -I -s "$protocol://$target" >> $output_file 2>&1
done
echo "[✓] Output saved to $output_file"
