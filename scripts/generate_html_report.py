#!/usr/bin/env python3

import os
import sys
import glob
from datetime import datetime

def read_scan_file(filepath):
    """Read scan output file"""
    try:
        with open(filepath, 'r') as f:
            return f.read()
    except:
        return "No data available"

def generate_html_report(target):
    """Generate HTML report from scan results"""
    
    # Find latest scan files
    scans_dir = "scans"
    
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    html_file = f"reports/{target}_report_{timestamp}.html"
    
    # Read all scan files
    whois_data = read_scan_file(f"{scans_dir}/whois_{target}.txt")
    dns_data = read_scan_file(f"{scans_dir}/dns_{target}.txt")
    headers_data = read_scan_file(f"{scans_dir}/headers_{target}.txt")
    whatweb_data = read_scan_file(f"{scans_dir}/whatweb_{target}.txt")
    subdomains_data = read_scan_file(f"{scans_dir}/subdomains_{target}.txt")
    amass_data = read_scan_file(f"{scans_dir}/amass_{target}.txt")
    nmap_data = read_scan_file(f"{scans_dir}/nmap_{target}.txt")
    gobuster_data = read_scan_file(f"{scans_dir}/gobuster_{target}.txt")
    nikto_data = read_scan_file(f"{scans_dir}/nikto_{target}.txt")
    nuclei_data = read_scan_file(f"{scans_dir}/nuclei_{target}.txt")
    
    html_content = f"""
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recon Report - {target}</title>
    <style>
        * {{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }}
        
        body {{
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #333;
            line-height: 1.6;
        }}
        
        .container {{
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }}
        
        header {{
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            text-align: center;
        }}
        
        header h1 {{
            color: #667eea;
            margin-bottom: 10px;
            font-size: 2.5em;
        }}
        
        header p {{
            color: #666;
            font-size: 1.1em;
        }}
        
        .info {{
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-top: 20px;
        }}
        
        .info-box {{
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            border-left: 4px solid #667eea;
        }}
        
        .info-box strong {{
            color: #667eea;
        }}
        
        section {{
            background: white;
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            overflow: hidden;
        }}
        
        section h2 {{
            background: #667eea;
            color: white;
            padding: 20px;
            margin: 0;
            font-size: 1.5em;
            border-bottom: 3px solid #764ba2;
        }}
        
        .section-content {{
            padding: 20px;
        }}
        
        pre {{
            background: #f4f4f4;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            overflow-x: auto;
            font-family: 'Courier New', monospace;
            font-size: 0.9em;
            max-height: 500px;
            overflow-y: auto;
        }}
        
        footer {{
            background: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            color: #666;
            margin-top: 30px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }}
        
        .badge {{
            display: inline-block;
            background: #28a745;
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.9em;
            margin: 5px 5px 5px 0;
        }}
        
        .toc {{
            background: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }}
        
        .toc h3 {{
            margin-bottom: 10px;
            color: #667eea;
        }}
        
        .toc a {{
            display: inline-block;
            margin: 5px 10px 5px 0;
            padding: 8px 15px;
            background: white;
            color: #667eea;
            text-decoration: none;
            border-radius: 5px;
            border: 1px solid #667eea;
            transition: 0.3s;
        }}
        
        .toc a:hover {{
            background: #667eea;
            color: white;
        }}
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>🔥 Reconnaissance Report</h1>
            <p>Automated OSINT & Vulnerability Assessment</p>
            
            <div class="info">
                <div class="info-box">
                    <strong>Target:</strong><br>{target}
                </div>
                <div class="info-box">
                    <strong>Date:</strong><br>{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
                </div>
                <div class="info-box">
                    <strong>Framework:</strong><br>Recon Automation v2.0
                </div>
            </div>
        </header>
        
        <div class="toc">
            <h3>📋 Report Sections</h3>
            <a href="#whois">WHOIS</a>
            <a href="#dns">DNS</a>
            <a href="#headers">Headers</a>
            <a href="#whatweb">WhatWeb</a>
            <a href="#subdomains">Subdomains</a>
            <a href="#amass">AMASS</a>
            <a href="#nmap">Nmap</a>
            <a href="#gobuster">Gobuster</a>
            <a href="#nikto">Nikto</a>
            <a href="#nuclei">Nuclei</a>
        </div>
        
        <section id="whois">
            <h2>📋 WHOIS Information</h2>
            <div class="section-content">
                <pre>{whois_data}</pre>
            </div>
        </section>
        
        <section id="dns">
            <h2>🔍 DNS Records</h2>
            <div class="section-content">
                <pre>{dns_data}</pre>
            </div>
        </section>
        
        <section id="headers">
            <h2>🔐 HTTP Headers</h2>
            <div class="section-content">
                <pre>{headers_data}</pre>
            </div>
        </section>
        
        <section id="whatweb">
            <h2>🛠️ Web Technologies (WhatWeb)</h2>
            <div class="section-content">
                <pre>{whatweb_data}</pre>
            </div>
        </section>
        
        <section id="subdomains">
            <h2>🌐 Subdomains (theHarvester)</h2>
            <div class="section-content">
                <pre>{subdomains_data}</pre>
            </div>
        </section>
        
        <section id="amass">
            <h2>🌐 Subdomains (AMASS)</h2>
            <div class="section-content">
                <pre>{amass_data}</pre>
            </div>
        </section>
        
        <section id="nmap">
            <h2>🔌 Nmap Service Enumeration</h2>
            <div class="section-content">
                <pre>{nmap_data}</pre>
            </div>
        </section>
        
        <section id="gobuster">
            <h2>📁 Gobuster Directory Scan</h2>
            <div class="section-content">
                <pre>{gobuster_data}</pre>
            </div>
        </section>
        
        <section id="nikto">
            <h2>⚠️ Nikto Web Vulnerabilities</h2>
            <div class="section-content">
                <pre>{nikto_data}</pre>
            </div>
        </section>
        
        <section id="nuclei">
            <h2>🎯 Nuclei Vulnerability Scan</h2>
            <div class="section-content">
                <pre>{nuclei_data}</pre>
            </div>
        </section>
        
        <footer>
            <p>Generated by Recon Automation Framework v2.0</p>
            <p>Author: Amol Nimade | GitHub: Amol1307</p>
            <p>© 2026 | All Rights Reserved</p>
        </footer>
    </div>
</body>
</html>
"""
    
    # Write HTML file
    with open(html_file, 'w') as f:
        f.write(html_content)
    
    print(f"[✓] HTML report generated: {html_file}")
    return html_file

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("[!] Usage: python3 generate_html_report.py <target>")
        sys.exit(1)
    
    target = sys.argv[1]
    generate_html_report(target)
