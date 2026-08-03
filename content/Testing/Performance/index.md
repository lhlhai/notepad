---
title: "⚡ Performance Testing"
description: "Quick reference cho performance testing - từ load testing basics đến advanced monitoring techniques."
---

# ⚡ Performance Testing Quick Guide

Chào mừng bạn đến với thư mục Performance Testing - nơi cung cấp kiến thức và công cụ để kiểm thử hiệu năng ứng dụng.

## 📂 Nội dung chính

### [📈 Quick Check Guide](./Quick-Check.md)
Hướng dẫn nhanh các kỹ thuật performance testing:
*   **Load Testing**: Test under expected load
*   **Stress Testing**: Find breaking points
*   **Endurance Testing**: Long-running stability
*   **Spike Testing**: Sudden traffic surge handling

## 🎯 Performance Testing Types

| Type | Purpose | When to Use |
|------|---------|-------------|
| **Load Testing** | Verify behavior under expected load | Before each major release |
| **Stress Testing** | Find system's breaking point | Capacity planning |
| **Endurance Testing** | Detect memory leaks, degradation | Long-term stability check |
| **Spike Testing** | Handle sudden traffic spikes | E-commerce, ticketing systems |
| **Scalability Testing** | Measure horizontal/vertical scaling | Infrastructure decisions |

## 📊 Key Metrics to Monitor

### Application Metrics
*   **Response Time**: P50, P90, P95, P99 percentiles
*   **Throughput**: Requests per second (RPS)
*   **Error Rate**: % of failed requests
*   **Concurrency**: Active users/connections

### System Metrics
*   **CPU Usage**: Should stay below 70-80%
*   **Memory Usage**: Watch for leaks (steady increase)
*   **Disk I/O**: Read/write operations per second
*   **Network I/O**: Bandwidth utilization

### Database Metrics
*   **Query Response Time**: Slow queries identification
*   **Connection Pool**: Active/idle connections
*   **Lock Waits**: Database contention
*   **Cache Hit Ratio**: Efficiency of caching

## 🛠️ Popular Tools

| Tool | Best For | Learning Curve |
|------|----------|----------------|
| **k6** | Developer-friendly, code-based | Low |
| **JMeter** | GUI-based, versatile | Medium |
| **Gatling** | High performance, Scala-based | Medium-High |
| **Locust** | Python-based, distributed | Low-Medium |
| **Artillery** | API load testing | Low |

## 🚀 Quick Start with k6

```javascript
// script.js
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  vus: 100,           // 100 virtual users
  duration: '5m',     // Run for 5 minutes
  thresholds: {
    http_req_duration: ['p(95)<500'], // 95% of requests < 500ms
  },
};

export default function () {
  const res = http.get('https://api.example.com/users');
  
  check(res, {
    'status is 200': (r) => r.status === 200,
    'response time OK': (r) => r.timings.duration < 500,
  });
  
  sleep(1);
}
```

```bash
# Run the test
k6 run script.js

# Run with cloud
k6 cloud script.js
```

## 🔍 Performance Bottleneck Patterns

### 1. Database Bottlenecks
**Symptoms**: Slow queries, high DB CPU
**Solutions**: 
*   Add indexes
*   Optimize queries
*   Implement caching
*   Connection pooling

### 2. Memory Issues
**Symptoms**: Gradual slowdown, OOM errors
**Solutions**:
*   Profile memory usage
*   Fix memory leaks
*   Increase heap size
*   Implement proper cleanup

### 3. Network Latency
**Symptoms**: High response times, timeouts
**Solutions**:
*   Use CDN
*   Enable compression
*   Reduce payload size
*   Implement connection keep-alive

### 4. CPU Saturation
**Symptoms**: High CPU, slow processing
**Solutions**:
*   Optimize algorithms
*   Scale horizontally
*   Use async processing
*   Cache expensive computations

## 📈 Performance Testing Process

```
1. Define Goals
   ↓
2. Design Tests
   ↓
3. Setup Environment
   ↓
4. Execute Tests
   ↓
5. Analyze Results
   ↓
6. Identify Bottlenecks
   ↓
7. Optimize & Retest
```

## ✅ Performance Checklist

### Pre-Test
- [ ] Define performance requirements (SLAs)
- [ ] Setup isolated test environment
- [ ] Prepare realistic test data
- [ ] Configure monitoring tools
- [ ] Baseline current performance

### During Test
- [ ] Monitor all metrics in real-time
- [ ] Document any anomalies
- [ ] Capture logs and traces
- [ ] Note resource utilization peaks

### Post-Test
- [ ] Analyze results against SLAs
- [ ] Identify bottlenecks
- [ ] Create optimization recommendations
- [ ] Document findings
- [ ] Schedule retest after fixes

## 🔗 Tài nguyên liên quan

*   [API Testing](../API/Cheatsheet.md) - API performance considerations
*   [Infrastructure-Docker](../Infrastructure-Docker/Docker-for-Testers.md) - Containerized performance testing
*   [Systems - Linux](../../Systems/Linux-Bash.md) - System monitoring commands

---

> ⚡ **Pro Tip**: Performance testing should be continuous, not a one-time activity. Integrate performance checks into your CI/CD pipeline!
