#!/bin/bash

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

if [ -z "$1" ]; then
    ./banner.sh
    echo -e "${RED}[!] Usage: ./recon.sh <domain>${NC}"
    exit 1
fi

target=$1
timestamp=$(date +%Y%m%d_%H%M%S)
report_file="../reports/recon_${target}_${timestamp}.txt"
log_file="../logs/recon_${timestamp}.log"

# Create logs directory if it doesn't exist
mkdir -p ../logs

# Show banner
./banner.sh

echo ""
echo -e "${BLUE}=========================================${NC}"
echo -e "${GREEN}[+] Target: $target${NC}"
echo -e "${GREEN}[+] Timestamp: $timestamp${NC}"
echo -e "${BLUE}=========================================${NC}"
echo ""

# Log function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> $log_file
}

log "Started reconnaissance scan for $target"

# Tool detection
echo -e "${YELLOW}[*] Detecting tools...${NC}"
tools_found=0
tools_missing=0

check_tool() {
    if command -v $1 &> /dev/null; then
        echo -e "${GREEN}[✓] $1 found${NC}"
        ((tools_found++))
        log "Tool found: $1"
    else
        echo -e "${RED}[!] $1 not found${NC}"
        ((tools_missing++))
        log "Tool missing: $1"
    fi
}

check_tool "whois"
check_tool "dig"
check_tool "curl"
check_tool "whatweb"
check_tool "nmap"
check_tool "theHarvester"
check_tool "gobuster"
check_tool "nikto"
check_tool "amass"
check_tool "nuclei"

echo ""
echo -e "${GREEN}[+] Tools: $tools_found found, $tools_missing missing${NC}"
echo ""

# Run all scripts
echo -e "${YELLOW}[*] [1/10] Running WHOIS Enumeration...${NC}"
./whois_enum.sh $target
log "Completed: WHOIS enumeration"

echo ""
echo -e "${YELLOW}[*] [2/10] Running DNS Enumeration...${NC}"
./dns_enum.sh $target
log "Completed: DNS enumeration"

echo ""
echo -e "${YELLOW}[*] [3/10] Running HTTP Header Analysis...${NC}"
./headers.sh $target
log "Completed: HTTP header analysis"

echo ""
echo -e "${YELLOW}[*] [4/10] Running WhatWeb Fingerprinting...${NC}"
./whatweb_scan.sh $target
log "Completed: WhatWeb fingerprinting"

echo ""
echo -e "${YELLOW}[*] [5/10] Running Subdomain Enumeration (theHarvester)...${NC}"
./subdomain_enum.sh $target
log "Completed: Subdomain enumeration"

echo ""
echo -e "${YELLOW}[*] [6/10] Running AMASS Subdomain Enumeration...${NC}"
./amass_enum.sh $target
log "Completed: AMASS enumeration"

echo ""
echo -e "${YELLOW}[*] [7/10] Running Nmap Service Scan...${NC}"
./nmap_scan.sh $target
log "Completed: Nmap service scan"

echo ""
echo -e "${YELLOW}[*] [8/10] Running Gobuster Directory Scan...${NC}"
./gobuster_scan.sh $target
log "Completed: Gobuster directory scan"

echo ""
echo -e "${YELLOW}[*] [9/10] Running Nikto Web Vulnerability Scan...${NC}"
./nikto_scan.sh $target
log "Completed: Nikto scan"

echo ""
echo -e "${YELLOW}[*] [10/10] Running Nuclei Vulnerability Scan...${NC}"
./nuclei_scan.sh $target
log "Completed: Nuclei scan"

echo ""
echo -e "${BLUE}=========================================${NC}"
echo -e "${GREEN}[+] All scans completed!${NC}"
echo -e "${BLUE}=========================================${NC}"
echo ""

# Generate Report
echo -e "${YELLOW}[*] Generating comprehensive report...${NC}"

{
    echo "========================================="
    echo "RECONNAISSANCE REPORT"
    echo "========================================="
    echo "Target: $target"
    echo "Scan Date: $(date)"
    echo "========================================="
    echo ""
    
    echo "1. WHOIS INFORMATION"
    echo "----------------------------------------"
    cat ../scans/whois_${target}.txt 2>/dev/null || echo "No data"
    echo ""
    
    echo "2. DNS RECORDS"
    echo "----------------------------------------"
    cat ../scans/dns_${target}.txt 2>/dev/null || echo "No data"
    echo ""
    
    echo "3. HTTP HEADERS"
    echo "----------------------------------------"
    cat ../scans/headers_${target}.txt 2>/dev/null || echo "No data"
    echo ""
    
    echo "4. WEB TECHNOLOGIES (WhatWeb)"
    echo "----------------------------------------"
    cat ../scans/whatweb_${target}.txt 2>/dev/null || echo "No data"
    echo ""
    
    echo "5. SUBDOMAINS (theHarvester)"
    echo "----------------------------------------"
    cat ../scans/subdomains_${target}.txt 2>/dev/null || echo "No data"
    echo ""
    
    echo "6. SUBDOMAINS (AMASS)"
    echo "----------------------------------------"
    cat ../scans/amass_${target}.txt 2>/dev/null || echo "No data"
    echo ""
    
    echo "7. NMAP RESULTS"
    echo "----------------------------------------"
    cat ../scans/nmap_${target}.txt 2>/dev/null || echo "No data"
    echo ""
    
    echo "8. GOBUSTER DIRECTORIES"
    echo "----------------------------------------"
    cat ../scans/gobuster_${target}.txt 2>/dev/null || echo "No data"
    echo ""
    
    echo "9. NIKTO VULNERABILITIES"
    echo "----------------------------------------"
    cat ../scans/nikto_${target}.txt 2>/dev/null || echo "No data"
    echo ""
    
    echo "10. NUCLEI FINDINGS"
    echo "----------------------------------------"
    cat ../scans/nuclei_${target}.txt 2>/dev/null || echo "No data"
    echo ""
    
    echo "========================================="
    echo "Report Generated: $(date)"
    echo "========================================="

} > $report_file

echo -e "${GREEN}[✓] Report saved: $report_file${NC}"
log "Report saved: $report_file"

echo ""
echo -e "${BLUE}=========================================${NC}"
echo -e "${GREEN}[✓] SCAN COMPLETE!${NC}"
echo -e "${BLUE}=========================================${NC}"
echo ""
echo "Files generated:"
echo "  - Scans: ../scans/"
echo "  - Report: $report_file"
echo "  - Logs: $log_file"
echo ""

log "Reconnaissance scan completed successfully"

