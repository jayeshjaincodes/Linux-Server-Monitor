# Linux Server Monitor

A lightweight, automated Linux system monitoring tool built using Bash. It tracks system performance and service health, logs activity, and generates alerts when predefined thresholds are exceeded.

---

## Features

- System Monitoring
  - CPU usage tracking
  - RAM usage monitoring
  - Disk space monitoring

- Service Health Checks
  - Docker
  - Apache (`apache2`)
  - Nginx

- Logging
  - System logs (`server.log`)
  - Alert logs (`alerts.log`)

- Threshold-based Alerts
  - Configurable via `config.yaml`
  - Detects high resource usage

- Automation
  - Runs via cron job

- Log Maintenance
  - Automatically deletes old logs

---

## Quick Start (Clone & Run)

### 1. Clone the repository

    git clone https://github.com/jayeshjaincodes/Linux-Server-Monitor.git
    cd linux-server-monitor

### 2. Make script executable

    chmod +x monitor.sh

### 3. Configure thresholds

Edit `config.yaml`:

    ram_threshold: 80
    cpu_threshold: 85
    disk_threshold: 90

### 4. Run the script

    ./monitor.sh

---

## Run Automatically (Cron Job)

    crontab -e

Add:

    * * * * * /full/path/to/monitor.sh

---

## Project Structure

    linux-server-monitor/
    │
    ├── monitor.sh
    ├── config.yaml
    ├── logs/
    │   ├── server.log
    │   └── alerts.log
    └── README.md

---

## Sample Output

server.log

    2026-03-30 12:00:01 RAM=45% CPU=22% DISK=60%

alerts.log

    WARNING: 2026-03-30 12:01:01 HIGH RAM USAGE:82%
    WARNING: 2026-03-30 12:02:01 nginx is inactive

---

## Requirements

- bash  
- awk  
- top  
- df  
- bc  

Install bc if needed:

    sudo apt install bc

---

## Notes

- Apache service name:
  - Ubuntu/Debian → `apache2`
  - CentOS/RHEL → `httpd`
- Alerts are logged locally (no external notifications yet)

---

## Learning Outcomes

- Bash scripting  
- Linux monitoring  
- Cron jobs  
- Logging systems  
- Service health checks  

---

## License

MIT License
