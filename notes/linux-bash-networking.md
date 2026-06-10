# 🐧 Linux, Bash & Networking

## 1. File & Text Manipulation
### Find and replace text in file(s)
```bash
# Single file
sed -i 's/old-text/new-text/g' input.txt
sed -i 's|old string|new string|g' filename

# Multiple files
grep -rli 'search string' */*.json | xargs -i@ sed -i "s|data|new string|g" @

# Replace XML tag value
sed -i 's#<name>\([^<][^<]*\)</name>#<name>SOMETHING</name>#' file.xml
```

### Find files and execute commands
```bash
# Add __init__.py to all directories
find . -type d -exec touch {}/__init__.py \;
find . -type d -exec rm {}/__init__.py \;

# Remove __pycache__
find . -type d -name "__pycache__" -exec rm -rf {} +
```

### Search string excluding folders
```bash
grep -rli --exclude-dir=node_modules 'openapi' */*
grep -rli --exclude-dir=node_modules 'openapi' */*.json
grep -rli 'mm' --include="*.robot" .
```

## 2. Process & Port Management
### Check port & Kill process
```bash
# Check listening ports
lsof -i -P -n | grep LISTEN
sudo netstat -ntlp | grep :8080

# Kill by port
sudo fuser -k 80/tcp
sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill

# Kill by name
pidof <program_name>
ps aux | awk '/chrome/ { print $2 } ' | xargs kill -9
```

## 3. Network & Troubleshooting
### Capture trace (tcpdump)
```bash
tcpdump -i eth0 -A -nn -vv -s 2048 -w capture.pcap

# Fix permission: You don't have permission to capture on that device
sudo groupadd pcap
sudo usermod -a -G pcap $USER
sudo setcap cap_net_raw,cap_net_admin=eip /usr/sbin/tcpdump
```

### Change IP
```bash
sudo ifconfig eth0 <ip> netmask <netmask>
```

### Set DNS
```bash
echo "nameserver 192.168.1.3" >> /etc/resolv.conf
echo "nameserver 192.168.1.4" >> /etc/resolv.conf
```

### Fix SFTP "Broken pipe / Connection reset by peer"
```bash
sudo chown root:root /var/sftp
sudo chmod 755 /var/sftp
sudo chown user:user /var/sftp/uploads
```

### Reset Root Password (Ubuntu/Debian)
1. Reboot -> Hold `ESC` -> Press `e`
2. Append `rw init=/bin/bash` to the `linux` line. Press `Ctrl+X` or `F10`.
3. Run: `mount | grep -w /`
4. Run: `passwd` -> set new pass
5. Run: `exec /sbin/init`

### Compress & Extract
```bash
# Compress
tar cvf - <folder> | gzip -9 - > <file>.tar.gz
# Extract
tar -zxvf <file>.tar.gz
```

### Zip excluding specific folders
```bash
zip -r archive.zip /path/to/folder -x "*/node_modules/*"
zip -r att-validation.zip . \
  -x "**/__pycache__/*" \
  -x "**/*.pyc" \
  -x "**/*.pyo" \
  -x ".env" \
  -x ".venv/*" \
  -x ".git/*"
```

### Find file by extension
```bash
find -name *.txt
wc -l access.log
grep "81.143.211.90" access.log
```