# 🪟 Windows, PowerShell & CMD

## 1. Network & Ports
### Test Network Connection
```powershell
Test-NetConnection -Port 800 -ComputerName 192.168.0.1 -InformationLevel Detailed
```

### Kill Port / Process
```cmd
netstat -ano | findstr :<yourPortNumber>
taskkill /PID <typeyourPIDhere> /F
taskkill -im chrome.exe -f
```

## 2. Environment & System
### Set Environment Variable (Reload CMD)
```cmd
SET ENV="TEST"
setx ENV "%ENV%" /m
```

### Remove `__pycache__` recursively (PowerShell)
```powershell
Get-ChildItem -Recurse -Directory __pycache__ | Remove-Item -Recurse -Force
```

### Remove `__pycache__` (CMD)
```cmd
for /d /r . %d in (__pycache__) do @if exist "%d" rd /s /q "%d"
```

### Rename multiple files (Bash-style on Windows)
```cmd
for f in *old*; do echo mv "$f" "${f//old/new}"; done
```

## 3. PowerShell Proxy
```powershell
$proxy = New-Object System.Net.WebProxy("http://IPv4:8080")
$proxy.Credentials = New-Object System.Net.NetworkCredential("user","XXX")
[System.Net.WebRequest]::DefaultWebProxy = $proxy
```

## 4. Windows Form (PowerShell)
- Reference: https://learn.microsoft.com/en-us/dotnet/desktop/wpf/overview/?view=netdesktop-9.0