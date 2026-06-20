#!/bin/bash
if [ -z "$1" ]; then
    echo "[!] Usage: ./nmap_scan.sh <domain/IP>"
    exit 1
fi
target=$1
output_file="../scans/nmap_${target}.txt"
echo "======================================="
echo "[+] Nmap Service Enumeration"
echo "[+] Target: $target"
echo "======================================="
nmap -sV -sC -O $target > $output_file 2>&1
echo "[✓] Output saved to $output_file"
