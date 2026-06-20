#!/bin/bash
if [ -z "$1" ]; then
    echo "[!] Usage: ./dns_enum.sh <domain>"
    exit 1
fi
target=$1
output_file="../scans/dns_${target}.txt"
echo "======================================="
echo "[+] DNS Enumeration"
echo "[+] Target: $target"
echo "======================================="
{
    echo "[*] A Records:"
    dig $target A +short
    echo "[*] MX Records:"
    dig $target MX +short
    echo "[*] NS Records:"
    dig $target NS +short
    echo "[*] TXT Records:"
    dig $target TXT +short
} > $output_file 2>&1
echo "[✓] Output saved to $output_file"
