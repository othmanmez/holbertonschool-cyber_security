# ARP Live Hosts Discovery

This project contains a simple Bash script that discovers live hosts on a local subnetwork using **Nmap ARP scan**.

## Description

The script performs **host discovery only** (no port scanning) by sending ARP requests.  
It works **only on the local network**, and MAC addresses are shown **only if the targets are in the same subnetwork**.

The script must be executed with **root privileges** (sudo).

## Requirements

- Linux
- Nmap installed
- Root or sudo privileges

## Script

`0-arp_scan.sh`
```bash
#!/bin/bash
sudo nmap -sn -PR $1

