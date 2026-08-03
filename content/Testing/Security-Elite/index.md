---
title: "🔒 Security Testing"
description: "Penetration testing, security scanning và vulnerability assessment cho QA engineers."
---

# 🔒 Security Testing Elite

Chào mừng bạn đến với thư mục Security Testing - nơi cung cấp kiến thức về bảo mật, penetration testing và vulnerability assessment cho QA professionals.

## 📂 Nội dung chính

### [🛡️ Penetration Testing](./Penetration-Testing.md)
Hướng dẫn thực hành penetration testing:
*   **Reconnaissance**: Information gathering techniques
*   **Vulnerability Scanning**: Automated & manual approaches
*   **Exploitation**: Ethical hacking methods
*   **Reporting**: Security findings documentation

## 🎯 OWASP Top 10 (2021)

| Rank | Vulnerability | Description | Impact |
|------|--------------|-------------|--------|
| **A01** | Broken Access Control | Users can act outside permissions | High |
| **A02** | Cryptographic Failures | Sensitive data exposure | Critical |
| **A03** | Injection | SQL, NoSQL, OS, LDAP injection | Critical |
| **A04** | Insecure Design | Missing security controls | High |
| **A05** | Security Misconfiguration | Default configs, unused features | Medium-High |
| **A06** | Vulnerable Components | Outdated libraries, frameworks | High |
| **A07** | Authentication Failures | Weak passwords, session flaws | High |
| **A08** | Software & Data Integrity | CI/CD pipeline attacks | High |
| **A09** | Security Logging | Insufficient monitoring | Medium |
| **A10** | SSRF | Server-Side Request Forgery | High |

## 🔍 Security Testing Types

### 1. Vulnerability Assessment
*   Automated scanning
*   Known vulnerability detection
*   Compliance checking
*   **Frequency**: Regular (weekly/monthly)

### 2. Penetration Testing
*   Simulated real attacks
*   Manual exploitation
*   Business logic flaws
*   **Frequency**: Quarterly/Before major releases

### 3. Security Code Review
*   Static Application Security Testing (SAST)
*   Dynamic Application Security Testing (DAST)
*   Interactive AST (IAST)
*   **Frequency**: Every PR/Merge

### 4. API Security Testing
*   Authentication/Authorization
*   Input validation
*   Rate limiting
*   Data exposure
*   **Frequency**: Each API change

## 🛠️ Essential Security Tools

### Scanning Tools
| Tool | Type | Best For |
|------|------|----------|
| **OWASP ZAP** | DAST | Web app scanning |
| **Burp Suite** | Proxy/Scanner | Manual + automated testing |
| **Nessus** | Vulnerability Scanner | Infrastructure scanning |
| **Nikto** | Web Scanner | Web server vulnerabilities |
| **SQLMap** | SQL Injection | Database security testing |

### Code Analysis
| Tool | Type | Languages |
|------|------|-----------|
| **SonarQube** | SAST | Multi-language |
| **Semgrep** | SAST | Multi-language |
| **ESLint (security)** | Linting | JavaScript |
| **Bandit** | SAST | Python |
| **SpotBugs** | SAST | Java |

### Dependency Checking
| Tool | Purpose |
|------|---------|
| **OWASP Dependency-Check** | Known vulnerable dependencies |
| **Snyk** | Continuous dependency monitoring |
| **npm audit** | Node.js vulnerabilities |
| **pip-audit** | Python package vulnerabilities |
| **bundle-audit** | Ruby gem vulnerabilities |

## 🧪 Security Test Cases Checklist

### Authentication
- [ ] Password complexity requirements
- [ ] Account lockout after failed attempts
- [ ] Secure password reset flow
- [ ] Session timeout implementation
- [ ] MFA enforcement
- [ ] Credential stuffing protection

### Authorization
- [ ] Role-based access control (RBAC)
- [ ] Horizontal privilege escalation prevention
- [ ] Vertical privilege escalation prevention
- [ ] API endpoint authorization
- [ ] Direct object reference protection (IDOR)

### Input Validation
- [ ] SQL injection prevention
- [ ] XSS (Cross-Site Scripting) prevention
- [ ] CSRF token validation
- [ ] File upload restrictions
- [ ] Path traversal prevention
- [ ] Command injection prevention

### Data Protection
- [ ] HTTPS enforcement
- [ ] TLS 1.2+ configuration
- [ ] Sensitive data encryption at rest
- [ ] PII data masking
- [ ] Secure headers (CSP, HSTS, X-Frame-Options)

### Session Management
- [ ] Secure cookie flags (HttpOnly, Secure, SameSite)
- [ ] Session ID regeneration after login
- [ ] Concurrent session limits
- [ ] Proper logout functionality
- [ ] Token expiration and refresh

## 🚨 Common Vulnerabilities & Tests

### 1. SQL Injection
```
Test Inputs:
' OR '1'='1
'; DROP TABLE users; --
1; WAITFOR DELAY '0:0:5'--

Prevention:
✓ Parameterized queries
✓ ORM frameworks
✓ Input validation
✓ Least privilege DB accounts
```

### 2. Cross-Site Scripting (XSS)
```
Test Inputs:
<script>alert('XSS')</script>
javascript:alert(1)
<img src=x onerror=alert(1)>

Prevention:
✓ Output encoding
✓ Content Security Policy
✓ Input sanitization
✓ HTTP-only cookies
```

### 3. Broken Authentication
```
Test Scenarios:
- Default credentials
- Weak password policies
- Session fixation
- Credential enumeration
- Password reset token issues

Prevention:
✓ Strong password policies
✓ MFA implementation
✓ Secure session management
✓ Rate limiting
```

### 4. Sensitive Data Exposure
```
Check For:
- Unencrypted data in transit
- Unencrypted data at rest
- Debug information in responses
- Verbose error messages
- API keys in client code

Prevention:
✓ TLS everywhere
✓ Encryption at rest
✓ Proper logging practices
✓ Secret management systems
```

## 📊 Security Testing Process

```
1. Threat Modeling
   ↓
2. Security Requirements
   ↓
3. Automated Scanning
   ↓
4. Manual Testing
   ↓
5. Penetration Testing
   ↓
6. Remediation
   ↓
7. Verification
   ↓
8. Continuous Monitoring
```

## 🎓 Security Certifications for QA

*   **CEH** (Certified Ethical Hacker)
*   **OSCP** (Offensive Security Certified Professional)
*   **GWAPT** (GIAC Web Application Penetration Tester)
*   **CSSLP** (Certified Secure Software Lifecycle Professional)
*   **CompTIA Security+**

## 🔗 Tài nguyên liên quan

*   [API Security](../API/Security.md) - API-specific security testing
*   [OWASP Top 10](https://owasp.org/www-project-top-ten/) - Official resource
*   [Security-Elite Penetration Testing](./Penetration-Testing.md) - Deep dive guide

---

> 🔒 **Security Mindset**: Think like an attacker to defend like a pro. Security is not a feature—it's a fundamental requirement that must be baked into every layer of your application!
