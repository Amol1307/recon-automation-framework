# 🔥 Recon Automation Framework v2.0

An automated reconnaissance framework built with Bash and Kali Linux tools for OSINT, DNS enumeration, web fingerprinting, subdomain discovery, service enumeration, and report generation.

## 🎯 Features

✅ **WHOIS Enumeration** - Domain registration & ownership info
✅ **DNS Records** - A, MX, NS, TXT, SOA records
✅ **HTTP Headers** - Server info & security headers
✅ **Web Fingerprinting** - Technology detection (WhatWeb)
✅ **Subdomain Enumeration** - Find subdomains (theHarvester + AMASS)
✅ **Service Enumeration** - Open ports & services (Nmap)
✅ **Directory Scanning** - Web directories (Gobuster)
✅ **Web Vulnerabilities** - Nikto scanning
✅ **Vulnerability Templates** - Nuclei scanning
✅ **Automated Reports** - Text + HTML comprehensive reports
✅ **Tool Detection** - Auto-detect missing tools
✅ **Logging** - Complete scan logs with timestamps

## 🚀 Installation

```bash
git clone https://github.com/Amol1307/recon-automation-framework.git
cd recon-automation-framework
chmod +x scripts/*.sh
chmod +x generate_html_report.py
```

## 📋 Requirements

Install Kali Linux with these tools:
```bash
apt update && apt install -y whois dnsutils curl nmap whatweb theharvester gobuster nikto amass nuclei
```

## 💻 Usage

### Master Script (Runs All 10 Scans)

```bash
./scripts/recon.sh example.com
```

This will automatically:
1. Run WHOIS enumeration
2. Enumerate DNS records
3. Retrieve HTTP headers
4. Perform web technology fingerprinting
5. Find subdomains (theHarvester)
6. Find subdomains (AMASS)
7. Scan services with Nmap
8. Scan directories with Gobuster
9. Scan vulnerabilities with Nikto
10. Scan vulnerabilities with Nuclei
11. Generate comprehensive text report
12. Create detailed logs

### Individual Scripts

```bash
./scripts/whois_enum.sh example.com
./scripts/dns_enum.sh example.com
./scripts/headers.sh example.com
./scripts/whatweb_scan.sh example.com
./scripts/subdomain_enum.sh example.com
./scripts/amass_enum.sh example.com
./scripts/nmap_scan.sh example.com
./scripts/gobuster_scan.sh example.com
./scripts/nikto_scan.sh example.com
./scripts/nuclei_scan.sh example.com
```

### Generate HTML Report

```bash
python3 generate_html_report.py example.com
```

This creates a professional HTML report with all scan results.

## 📁 Directory Structure
