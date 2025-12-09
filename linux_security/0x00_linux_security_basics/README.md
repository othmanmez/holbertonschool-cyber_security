# 0x00 Linux Security Basics

## Resources
Read or watch:

- What is the Shell  
- What is Kali Linux  
- File System Hierarchy (FHS)  
- Linux File System  
- Linux Security Commands  
- Advantages of Using Linux in Cybersecurity  
- Linux Networking  
- How to Securely Transfer Files in Linux Using SCP  
- How to Set Up a Firewall with UFW on Ubuntu  
- Guide to the Linux Firewall (iptables, nftables)

---

## Learning Objectives

By the end of this project, you should be able to explain to anyone, **without looking at Google**:

### 🖥️ Linux Fundamentals
- What Linux is  
- What a Linux command is  
- The structure of the Linux operating system  
- The purpose of the **File Hierarchy Standard (FHS)**  
- The benefits of using FHS  
- The different directories in the Linux file system and their purposes  

### 🔐 Security & System Protection
- How to protect files and directories  
- How to monitor and investigate system activity  
- How to securely transfer files and data (SCP)  
- How to configure and manage a firewall  
- How to identify and terminate malicious processes  

### 🛠️ Using Linux Security Commands
You must know how to use:

- `ps` and `kill` → identify & terminate malicious processes  
- `netstat` and `ss` → monitor network traffic for suspicious activity  
- `nmap`, `lynis`, `tcpdump` → analyze network traffic  
- `iptables` and `ufw` → manage firewall rules in Linux  

---

## Requirements

### General Rules
- Allowed editors: **vi, vim, emacs**  
- All scripts will be tested on **Kali Linux**  
- All scripts must be **exactly 2 lines long**  
  - `wc -l file` must output **2**  
- When required, your script must use `$1` for the IP range  
- All files must end with a **new line**  
- The first line of all scripts must be:

```bash
#!/bin/bash
