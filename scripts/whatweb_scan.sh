#!/bin/bash
if [ -z "$1" ]; then
    echo "[!] Usage: ./whatweb_scan.sh <domain>"
    exit 1
fi
target=$1
output_file="../scans/whatweb_${target}.txt"
echo "======================================="
echo "[+] WhatWeb Fingerprinting"
echo "[+] Target: $target"
echo "======================================="
timeout 15 whatweb -a 1 $target > $output_file 2>&1
echo "[✓] Output saved to $output_file"

