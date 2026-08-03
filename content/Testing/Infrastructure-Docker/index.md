---
title: "🐳 Infrastructure & Docker"
description: "Hướng dẫn kiểm thử infrastructure, Docker containers và CI/CD pipelines cho QA."
---

# 🐳 Infrastructure & Docker Testing

Chào mừng bạn đến với thư mục Infrastructure Testing - nơi cung cấp kiến thức về kiểm thử Docker, containers và infrastructure cho QA engineers.

## 📂 Nội dung chính

### [🔧 Docker for Testers](./Docker-for-Testers.md)
Hướng dẫn toàn diện về Docker dành cho QA:
*   **Docker Basics**: Containers, images, volumes
*   **Test Environment Setup**: Spin up test environments instantly
*   **Selenium Grid**: Run tests in parallel with Docker
*   **Database Containers**: Isolated DB instances for testing

## 🏗️ Why QA Should Care About Infrastructure?

### 1. Environment Consistency
```
❌ Problem: "Works on my machine!"
✅ Solution: Docker containers ensure identical environments
```

### 2. Quick Setup & Teardown
*   Spin up test environments in seconds
*   Clean state for every test run
*   No more "environment issues"

### 3. Parallel Execution
*   Multiple browser versions simultaneously
*   Isolated database instances per test suite
*   Scale testing infrastructure on demand

## 🐳 Essential Docker Commands for QA

| Command | Purpose | Example |
|---------|---------|---------|
| `docker ps` | List running containers | `docker ps -a` |
| `docker logs` | View container logs | `docker logs -f <container>` |
| `docker exec` | Execute command in container | `docker exec -it <container> bash` |
| `docker-compose up` | Start multi-container app | `docker-compose up -d` |
| `docker-compose down` | Stop and cleanup | `docker-compose down -v` |

## 🧪 Testing Scenarios with Docker

### 1. Selenium Grid Setup
```yaml
# docker-compose.yml
version: '3'
services:
  hub:
    image: selenium/hub:latest
    ports:
      - "4442:4442"
      - "4443:4443"
      - "4444:4444"
  
  chrome:
    image: selenium/node-chrome:latest
    depends_on:
      - hub
    environment:
      - SE_EVENT_BUS_HOST=hub
  
  firefox:
    image: selenium/node-firefox:latest
    depends_on:
      - hub
```

### 2. Database for Testing
```bash
# Quick PostgreSQL instance
docker run --name test-db \
  -e POSTGRES_PASSWORD=test123 \
  -p 5432:5432 \
  -d postgres:15

# Connect and test
docker exec -it test-db psql -U postgres
```

### 3. API Testing Environment
```bash
# Run mock API server
docker run -p 3000:3000 \
  -v $(pwd)/mock-data:/data \
  mockserver/mockserver
```

## 🔍 Infrastructure Testing Checklist

### Container Level
- [ ] Container starts successfully
- [ ] Health checks pass
- [ ] Logs are accessible
- [ ] Resource limits are respected
- [ ] Network connectivity works

### Application Level
- [ ] App responds on expected port
- [ ] Database connections work
- [ ] External services are reachable
- [ ] Configuration is loaded correctly

### Integration Level
- [ ] Containers can communicate
- [ ] Volumes persist data correctly
- [ ] Secrets are properly injected
- [ ] Load balancing works (if applicable)

## 🛠️ Common Issues & Solutions

| Issue | Cause | Solution |
|-------|-------|----------|
| Container exits immediately | App crashed or missing config | Check logs with `docker logs` |
| Port already in use | Another service using same port | Change host port mapping |
| Can't connect to DB | Network not configured | Use Docker networks |
| Data lost after restart | Missing volume | Add `-v` or volumes in compose |
| Slow container startup | Large image or slow init | Optimize Dockerfile, use multi-stage builds |

## 📊 Performance Considerations

### Resource Allocation
```yaml
# Limit container resources
services:
  test-runner:
    image: my-tests
    deploy:
      resources:
        limits:
          cpus: '2'
          memory: 2G
        reservations:
          cpus: '1'
          memory: 1G
```

### Best Practices
*   Use specific image tags (not `latest`)
*   Minimize image size (alpine base images)
*   Clean up unused containers/images regularly
*   Use `.dockerignore` to exclude unnecessary files

## 🔗 Tài nguyên liên quan

*   [Systems - Linux Bash](../../Systems/Linux-Bash.md) - Linux commands for infrastructure
*   [DevOps - Git Cheatsheet](../../DevOps/Git-Cheatsheet.md) - Version control for infra code
*   [Performance Testing](../Performance/Quick-Check.md) - Performance testing techniques

---

> 🚀 **Pro Tip**: Học Docker không chỉ giúp bạn test tốt hơn mà còn mở ra cánh cửa DevOps. Bắt đầu với việc containerize test environment của bạn ngay hôm nay!
