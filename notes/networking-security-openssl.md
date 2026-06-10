# 🔒 Networking, Security & OpenSSL

## 1. OpenSSL & Certificates
### Generate Private Key (No Password) & CSR
```bash
openssl genpkey -algorithm RSA -out private.key
openssl req -new -key private.key -out request.csr
```

### Convert PFX to KEY and CRT
```bash
# Extract private key (will ask for password)
openssl pkcs12 -in "cert 1.pfx" -nocerts -out werbi-cert.key

# Remove password from private key
openssl rsa -in werbi-cert.key -out werbi-cert-nopass.key

# Extract certificate
openssl pkcs12 -in "cert 1.pfx" -clcerts -nokeys -out werbi-cert.crt
```

### Test SSL Connection
```bash
openssl s_client -connect dns:8443 -servername dns
```

## 2. Proxies
### JMeter Proxy Configuration (`bin/system.properties`)
```properties
http.proxyHost=host
http.proxyPort=port
http.proxyUser=User
http.proxyPass=xxxxx
https.proxyHost=host
https.proxyPort=port
https.proxyUser=User
https.proxyPass=xxxxx
```

### CNTLM (NTLM Proxy) - Generate Hash
```bash
cntlm -u your_username -d your_domain -H
```

### Telnet alternative (PowerShell)
```powershell
Test-NetConnection -Port 800 -ComputerName 192.168.0.1 -InformationLevel Detailed
```

### Curl - Return only status code
```bash
curl -I http://www.example.org
```