# Holberton School Domain - Reconnaissance Report

**Domain:** holbertonschool.com
**Date:** 2025-12-12
**Tool:** Shodan API
**Scope:** Passive reconnaissance of holbertonschool.com infrastructure

---

## Executive Summary

This report documents the findings from passive reconnaissance performed on the holbertonschool.com domain using Shodan and DNS enumeration techniques. The investigation revealed 24 subdomains spanning 20 unique IP addresses across multiple cloud providers and content delivery networks.

### Key Findings:
- **24 subdomains** discovered
- **20 unique IP addresses** identified
- **3 primary infrastructure providers**: Amazon AWS, Cloudflare, Automattic (WordPress)
- **Primary technologies**: Nginx, Cloudflare CDN, WordPress, Ruby on Rails

---

## 1. IP Ranges and Addresses

### 1.1 IP Address Inventory

| IP Address | Associated Subdomains | Organization |
|------------|----------------------|--------------|
| 99.83.190.102 | holbertonschool.com | Amazon.com, Inc. (AS16509) |
| 75.2.70.75 | help.holbertonschool.com | Amazon.com, Inc. (AS16509) |
| 63.35.51.142 | www, fr, webflow, smile2021 | AWS CloudFront |
| 192.0.78.131 | blog.holbertonschool.com | Automattic, Inc (AS2635) |
| 104.16.53.111 | support.holbertonschool.com | Cloudflare, Inc. (AS13335) |
| 151.139.128.10 | fr.webflow, en.fr | Unknown Provider |
| 54.157.56.129 | alpha.holbertonschool.com | Amazon AWS (us-east-1) |
| 52.85.96.82 | rails-assets.holbertonschool.com | Amazon CloudFront |
| 52.85.96.95 | assets.holbertonschool.com | Amazon CloudFront |
| 13.37.98.87 | read.holbertonschool.com | Amazon AWS (eu-west-3) |
| 34.203.198.145 | v2.holbertonschool.com | Amazon AWS (us-east-1) |
| 13.38.122.220 | staging-apply-forum | Amazon AWS (eu-west-3) |
| 54.86.136.129 | v1.holbertonschool.com | Amazon AWS (us-east-1) |
| 13.38.216.13 | lvl2-discourse-staging | Amazon AWS (eu-west-3) |
| 54.89.246.137 | v3.holbertonschool.com | Amazon AWS (us-east-1) |
| 13.36.10.99 | apply.holbertonschool.com | Amazon AWS (eu-west-3) |
| 52.47.143.83 | yriry2.holbertonschool.com | Amazon AWS (eu-west-3) |
| 35.180.20.42 | staging-apply | Amazon AWS (eu-west-3) |
| 18.66.196.8 | staging-rails-assets-apply | Amazon AWS (eu-west-3) |
| 44.214.9.111 | beta.holbertonschool.com | Amazon AWS (us-east-1) |

### 1.2 IP Ranges by Provider

#### Amazon Web Services (AWS)
**ASN:** AS16509
**IP Ranges:**
- `13.36.0.0/16` - EU West 3 (Paris) region
- `13.37.0.0/16` - EU West 3 (Paris) region
- `13.38.0.0/16` - EU West 3 (Paris) region
- `18.66.0.0/16` - EU West 3 (Paris) region
- `34.203.0.0/16` - US East 1 (N. Virginia) region
- `35.180.0.0/16` - EU West 3 (Paris) region
- `44.214.0.0/16` - US East 1 (N. Virginia) region
- `52.47.0.0/16` - EU West 3 (Paris) region
- `52.85.0.0/16` - CloudFront CDN
- `54.86.0.0/16` - US East 1 (N. Virginia) region
- `54.89.0.0/16` - US East 1 (N. Virginia) region
- `54.157.0.0/16` - US East 1 (N. Virginia) region
- `63.35.0.0/16` - CloudFront CDN
- `75.2.0.0/16` - AWS Global Accelerator
- `99.83.0.0/16` - AWS Global Accelerator

**Geographic Distribution:**
- US East 1 (N. Virginia): 6 IPs
- EU West 3 (Paris): 7 IPs
- Global Accelerator/CloudFront: 5 IPs

#### Cloudflare
**ASN:** AS13335
**IP Range:** `104.16.0.0/16`
**Purpose:** CDN and DDoS protection for support.holbertonschool.com

#### Automattic (WordPress.com)
**ASN:** AS2635
**IP Range:** `192.0.78.0/24`
**Purpose:** WordPress hosting for blog.holbertonschool.com

---

## 2. DNS Information

### 2.1 Nameservers
holbertonschool.com uses AWS Route 53 nameservers:
- `ns-1244.awsdns-27.org`
- `ns-1991.awsdns-56.co.uk`
- `ns-343.awsdns-42.com`
- `ns-957.awsdns-55.net`

### 2.2 Mail Servers (MX Records)
Email is handled by Google Workspace:
- Priority 1: `aspmx.l.google.com`
- Priority 5: `alt1.aspmx.l.google.com`, `alt2.aspmx.l.google.com`
- Priority 10: `alt3.aspmx.l.google.com`, `alt4.aspmx.l.google.com`

### 2.3 Main Domain Resolution
- **holbertonschool.com** → `99.83.190.102`, `75.2.70.75` (AWS Global Accelerator)
- **www.holbertonschool.com** → CNAME to `proxy-ssl-geo-2.webflow.com` → Multiple IPs

---

## 3. Subdomain Enumeration

### 3.1 Complete Subdomain List

| Subdomain | IP Address | Purpose/Notes |
|-----------|------------|---------------|
| holbertonschool.com | 99.83.190.102 | Main domain |
| www.holbertonschool.com | 63.35.51.142 | Main website (Webflow) |
| apply.holbertonschool.com | 13.36.10.99 | Application portal |
| blog.holbertonschool.com | 192.0.78.131 | WordPress blog |
| support.holbertonschool.com | 104.16.53.111 | Support/Help desk |
| help.holbertonschool.com | 75.2.70.75 | Help resources |
| api.holbertonschool.com | - | Not currently resolving |
| intranet.holbertonschool.com | - | Not publicly accessible |
| v1.holbertonschool.com | 54.86.136.129 | Legacy version 1 |
| v2.holbertonschool.com | 34.203.198.145 | Legacy version 2 |
| v3.holbertonschool.com | 54.89.246.137 | Legacy version 3 |
| alpha.holbertonschool.com | 54.157.56.129 | Alpha/testing environment |
| beta.holbertonschool.com | 44.214.9.111 | Beta environment |
| staging-apply.holbertonschool.com | 35.180.20.42 | Staging: Application |
| staging-apply-forum.holbertonschool.com | 13.38.122.220 | Staging: Forum |
| lvl2-discourse-staging.holbertonschool.com | 13.38.216.13 | Staging: Discourse forum |
| fr.holbertonschool.com | 63.35.51.142 | French version |
| en.fr.holbertonschool.com | 151.139.128.10 | English-French version |
| fr.webflow.holbertonschool.com | 151.139.128.10 | French Webflow |
| webflow.holbertonschool.com | 63.35.51.142 | Webflow site |
| smile2021.holbertonschool.com | 63.35.51.142 | Campaign/Special site |
| assets.holbertonschool.com | 52.85.96.95 | Static assets CDN |
| rails-assets.holbertonschool.com | 52.85.96.82 | Rails application assets |
| staging-rails-assets-apply.holbertonschool.com | 18.66.196.8 | Staging: Rails assets |
| read.holbertonschool.com | 13.37.98.87 | Reading materials/docs |
| yriry2.holbertonschool.com | 52.47.143.83 | Unknown purpose |

### 3.2 Subdomain Categories

**Production:**
- Main site: www, holbertonschool.com
- Applications: apply
- Content: blog, read
- Support: support, help
- Localized: fr, en.fr

**Development/Staging:**
- staging-apply, staging-apply-forum
- staging-rails-assets-apply
- lvl2-discourse-staging
- alpha, beta
- v1, v2, v3 (legacy versions)

**Infrastructure:**
- assets, rails-assets
- webflow, fr.webflow

---

## 4. Technologies and Frameworks

### 4.1 Web Servers
- **Nginx**: Primary web server
  - Detected on: holbertonschool.com, help, blog, apply
  - Version: 1.20.0 (on apply.holbertonschool.com)
  - Used as reverse proxy and load balancer

- **Cloudflare**: CDN and edge server
  - Detected on: www, support
  - Provides DDoS protection and caching

### 4.2 Content Management Systems
- **WordPress**: blog.holbertonschool.com
  - Hosted on: Automattic (WordPress.com)
  - Plugins/Features: REST API, Batcache
  - Server-side caching enabled

- **Webflow**: www.holbertonschool.com
  - CMS platform for main website
  - CNAME: proxy-ssl-geo-2.webflow.com
  - Content delivery optimized

### 4.3 Application Frameworks
- **Ruby on Rails**: apply.holbertonschool.com
  - Evidence: rails-assets subdomain
  - Nginx/1.20.0 as application server
  - Content-Security-Policy headers implemented
  - X-Runtime header exposed (0.030052s)

### 4.4 CDN and Edge Services
- **AWS CloudFront**:
  - Used for: assets, rails-assets
  - Global content distribution
  - IP ranges: 52.85.0.0/16, 63.35.0.0/16

- **AWS Global Accelerator**:
  - Used for: Main domain routing
  - Anycast IP addresses
  - Improved global availability

- **Cloudflare CDN**:
  - Used for: www, support
  - Features: HTTP/3 (h3), Brotli compression
  - Cache hit optimization

### 4.5 Security Technologies
- **SSL/TLS**:
  - Certificate Authorities: Let's Encrypt (R12, R13, E7)
  - HSTS enabled: max-age=31536000
  - TLS termination at edge

- **Security Headers**:
  - `X-Frame-Options: SAMEORIGIN`
  - `X-XSS-Protection: 1; mode=block`
  - `X-Content-Type-Options: nosniff`
  - `Content-Security-Policy: frame-ancestors 'self'`
  - `Referrer-Policy: strict-origin-when-cross-origin`
  - `Strict-Transport-Security` (HSTS)

### 4.6 Email Infrastructure
- **Google Workspace**: Email hosting
  - MX records point to Google servers
  - Professional email services

### 4.7 Database (Inferred)
Based on Rails application and WordPress:
- Likely **PostgreSQL** or **MySQL** for Rails apps
- **MySQL** for WordPress
- Hosted on AWS RDS (inferred)

### 4.8 Discourse Forum
- **Discourse**: Forum software
  - Subdomains: staging-apply-forum, lvl2-discourse-staging
  - Ruby on Rails based
  - PostgreSQL database

---

## 5. Infrastructure Analysis

### 5.1 Cloud Provider Distribution

**Primary Provider: Amazon Web Services (AWS)**
- **Percentage**: ~80% of infrastructure
- **Services Used**:
  - EC2 instances (application servers)
  - CloudFront (CDN)
  - Global Accelerator (anycast routing)
  - Route 53 (DNS)
  - Likely: RDS, S3, ELB

**Geographic Distribution:**
- **US East (N. Virginia)**: Primary region for legacy and production
- **EU West (Paris)**: European operations, applications, staging
- **Global**: CDN and accelerator endpoints

### 5.2 Service Architecture

```
User Request
    ↓
Cloudflare / AWS Global Accelerator (Edge)
    ↓
AWS CloudFront / Webflow Proxy (CDN)
    ↓
Nginx (Reverse Proxy / Load Balancer)
    ↓
Application Servers (Rails / WordPress / Static)
    ↓
Database Layer (RDS - PostgreSQL/MySQL)
```

### 5.3 High Availability Setup
- Multiple IP addresses for main domain (99.83.190.102, 75.2.70.75)
- AWS Global Accelerator for automatic failover
- CloudFront multi-region distribution
- Cloudflare DDoS protection

---

## 6. Open Ports and Services

### 6.1 Standard Web Ports
- **Port 80 (HTTP)**: Open on most hosts, redirects to HTTPS
- **Port 443 (HTTPS)**: Primary secure web service

### 6.2 Cloudflare Infrastructure (104.16.53.111)
Additional ports detected:
- **2082, 2083**: cPanel HTTP/HTTPS
- **2086, 2087**: WHM (WebHost Manager)
- **2095, 2096**: Webmail HTTP/HTTPS
- **8080, 8443**: Alternative HTTP/HTTPS
- **8880**: Custom service

**Note**: These are Cloudflare infrastructure ports, not necessarily exposed by holbertonschool.com

### 6.3 Application Ports
- Standard ports only (80, 443)
- No database ports exposed externally
- No SSH ports visible (good security practice)

---

## 7. Security Observations

### 7.1 Positive Security Practices
1. **HTTPS Enforcement**:
   - HSTS enabled with 1-year max-age
   - Automatic HTTP to HTTPS redirects
   - Modern TLS certificates

2. **Security Headers**:
   - Comprehensive header implementation
   - XSS protection enabled
   - Frame injection protection
   - Content type sniffing prevention

3. **Infrastructure Security**:
   - No database ports exposed
   - No SSH access visible externally
   - Staging environments isolated

4. **DDoS Protection**:
   - Cloudflare integration
   - AWS Shield (implicit with AWS services)

5. **Network Segmentation**:
   - Separate environments (prod/staging/dev)
   - Geographic distribution
   - CDN layer protection

### 7.2 Potential Security Concerns

1. **Information Disclosure**:
   - Nginx version exposed on apply.holbertonschool.com (1.20.0)
   - X-Runtime header reveals application response time
   - Multiple staging/test environments publicly accessible
   - Server headers disclose technology stack

2. **Legacy Environments**:
   - v1, v2, v3 subdomains still accessible
   - May contain outdated code or vulnerabilities
   - Should be deprecated if not in use

3. **Staging Exposure**:
   - Staging environments publicly accessible via DNS
   - staging-apply, staging-apply-forum, staging-rails-assets-apply
   - Risk: Unauthorized access to test data

4. **Cloudflare Management Ports**:
   - Multiple cPanel/WHM ports open on 104.16.53.111
   - Should verify if necessary and properly secured

5. **API Endpoint**:
   - api.holbertonschool.com does not resolve
   - May indicate removed or relocated API
   - Should ensure proper deprecation

### 7.3 Recommendations

**High Priority:**
1. Remove or restrict access to staging environments
2. Disable server version disclosure in Nginx
3. Remove X-Runtime header from production
4. Audit and decommission legacy subdomains (v1, v2, v3)
5. Implement IP-based access control for staging sites

**Medium Priority:**
6. Implement rate limiting on public endpoints
7. Add CAA DNS records to control certificate issuance
8. Review and minimize exposed Cloudflare ports
9. Implement comprehensive logging and monitoring
10. Regular security audits of exposed services

**Low Priority:**
11. Consider subdomain takeover protection
12. Implement DNSSEC
13. Add additional security headers (Expect-CT, Feature-Policy)
14. Document and inventory all subdomains

---

## 8. Technology Stack Summary

### Production Stack
```
Frontend:
- Webflow CMS (www)
- Cloudflare CDN
- AWS CloudFront

Application:
- Ruby on Rails (apply)
- Nginx 1.20.0
- WordPress (blog)

Infrastructure:
- AWS EC2 (compute)
- AWS Route 53 (DNS)
- AWS Global Accelerator
- Google Workspace (email)

Security:
- Let's Encrypt SSL/TLS
- Cloudflare DDoS protection
- AWS Shield (implicit)
```

---

## 9. Conclusion

The holbertonschool.com infrastructure demonstrates a modern, cloud-native architecture built primarily on AWS services with CDN acceleration from Cloudflare and CloudFront. The organization utilizes:

- **Multi-region deployment** for reliability and performance
- **Content delivery networks** for global reach
- **Managed services** (Webflow, WordPress.com) for content management
- **Strong security posture** with HTTPS enforcement and security headers
- **Separation of concerns** with distinct environments and services

### Key Strengths:
- Robust CDN and edge caching strategy
- Geographic distribution for performance
- Strong SSL/TLS implementation
- Comprehensive security headers

### Areas for Improvement:
- Reduce information disclosure (server versions, headers)
- Secure or remove staging environments from public access
- Deprecate legacy subdomains (v1, v2, v3)
- Implement additional access controls for non-production environments

### Infrastructure Summary:
- **24 subdomains** across **20 unique IP addresses**
- **15+ AWS IP ranges** utilized
- **3 major hosting providers**: AWS, Cloudflare, Automattic
- **Primary technologies**: Nginx, Rails, WordPress, Webflow
- **Strong security baseline** with room for hardening

---

## Appendix A: Shodan Query Commands

Commands used during reconnaissance:
```bash
# Initialize Shodan
python -m shodan init API_KEY

# Host lookup
python -m shodan host <IP_ADDRESS>

# DNS lookups
nslookup holbertonschool.com
nslookup -type=NS holbertonschool.com
nslookup -type=MX holbertonschool.com

# HTTP header analysis
curl -I https://www.holbertonschool.com
curl -I https://apply.holbertonschool.com
curl -I https://blog.holbertonschool.com
```

---

## Appendix B: Methodology

**Reconnaissance performed:**
1. DNS enumeration (NS, MX, A records)
2. Subdomain discovery from provided data
3. Shodan API queries for IP intelligence
4. HTTP header analysis
5. Technology fingerprinting
6. Network topology mapping

**Tools used:**
- Shodan API (Python)
- nslookup (DNS queries)
- curl (HTTP header inspection)
- Custom Python scripts for automation

**Limitations:**
- Free Shodan API tier (limited queries)
- Passive reconnaissance only (no active scanning)
- Public DNS information only
- No authentication testing

---

**Report End**
