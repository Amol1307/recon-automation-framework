#!/bin/bash

if [ -z "$1" ]; then
    echo "[!] Usage: ./gobuster_scan.sh <domain>"
    exit 1
fi

target=$1
output_file="../scans/gobuster_${target}.txt"

echo "======================================="
echo "[+] Gobuster Directory Enumeration"
echo "[+] Target: $target"
echo "======================================="

if command -v gobuster &> /dev/null; then
    # Try multiple wordlist paths
    if [ -f "/usr/share/dirbuster/wordlists/common.txt" ]; then
        wordlist="/usr/share/dirbuster/wordlists/common.txt"
    elif [ -f "/usr/share/wordlists/dirbuster/common.txt" ]; then
        wordlist="/usr/share/wordlists/dirbuster/common.txt"
    else
        wordlist="/usr/share/wordlists/dirb/common.txt"
    fi
    
    timeout 120 gobuster dir -u "https://$target" -w $wordlist -o $output_file 2>&1
    echo "[✓] Output saved to $output_file"
else
    echo "[!] Gobuster not installed"
fi
