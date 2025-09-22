# Frontend Microservice - Vue.js

Vue.js frontend for the microservices TODO application with automated CI/CD pipeline.

## Quick Start

### Run Locally
```bash
# Install Node.js 14.21.3 first
npm install
npm run dev
```
App runs on http://localhost:8080

### Run with Docker
```bash
docker build -t juanc773/frontend-ws1 .
docker run -p 8080:80 juanc773/frontend-ws1
```

## CI/CD Pipeline

### What happens automatically:
1. **Push to master** → GitHub Actions triggers
2. **Build & Test** → npm install, npm run build, lint
3. **Docker Build** → Creates production image with nginx
4. **Push to Registry** → Uploads to Docker Hub as `juanc773/frontend-ws1:latest`

### Setup Requirements:
**GitHub Secrets (Repository → Settings → Secrets):**
- `DOCKERHUB_USERNAME`: juanc773
- `DOCKERHUB_TOKEN`: Your Docker Hub access token

### Pipeline File:
`.github/workflows/main.yml` - Runs on every push to master branch

## Architecture

**Development:** Vue.js dev server with API proxy
- `/login` → http://127.0.0.1:8081 (Auth API)
- `/todos` → http://127.0.0.1:8082 (TODOs API)

**Production:** Nginx serves static files + SPA routing

**Docker:** Multi-stage build (Node.js build + nginx runtime)

## Key Files

- `package.json` - Dependencies and scripts
- `Dockerfile` - Container configuration  
- `nginx.conf` - Production web server config
- `.github/workflows/main.yml` - CI/CD pipeline

## Common Issues

**npm install fails:**
Use Node.js 14.21.3 (project is Vue 2.x, needs older Node)

**CI/CD fails with "access denied":**
Check Docker Hub username in workflow matches your actual username

**Build warnings:**
Normal for Vue 2.x projects, doesn't affect functionality

## Dependencies
- Vue.js 2.x
- Node.js 14.21.3
- Docker (for containerization)

---

**Result:** Automated deployment pipeline that builds and deploys frontend on every code change.