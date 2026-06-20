#!/bin/bash

if [ -z "$1" ]; then
    echo "[!] Usage: ./nuclei_scan.sh <domain>"
    exit 1
fi

target=$1
output_file="../scans/nuclei_${target}.txt"

echo "======================================="
echo "[+] Nuclei Vulnerability Scan"
echo "[+] Target: $target"
echo "======================================="

if command -v nuclei &> /dev/null; then
    timeout 120 nuclei -u "$target" -o $output_file 2>&1
    echo "[✓] Output saved to $output_file"
else
    echo "[!] Nuclei not installed. Install: apt install nuclei"
    echo "[!] Skipping Nuclei scan..."
fi
