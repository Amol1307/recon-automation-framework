#!/bin/bash

if [ -z "$1" ]; then
    echo "[!] Usage: ./nikto_scan.sh <domain>"
    exit 1
fi

target=$1
output_file="../scans/nikto_${target}.txt"

echo "======================================="
echo "[+] Nikto Web Vulnerability Scan"
echo "[+] Target: $target"
echo "======================================="

if command -v nikto &> /dev/null; then
    timeout 120 nikto -h "$target" -o $output_file 2>&1
    echo "[✓] Output saved to $output_file"
else
    echo "[!] Nikto not installed. Install: apt install nikto"
    echo "[!] Skipping Nikto scan..."
fi
