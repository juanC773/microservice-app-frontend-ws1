# Frontend Microservice - Vue.js

Vue.js frontend for the microservices TODO application with automated CI/CD pipeline and Azure deployment.

## Architecture

The frontend communicates with backend APIs:
- **Auth API** for user authentication
- **Users API** (via Auth API) for user data
- **TODOs API** for task management

## Configuration

The service uses environment variables for API endpoints:
- `AUTH_API_ADDRESS` - URL of the Auth API service
- `TODOS_API_ADDRESS` - URL of the TODOs API service

## Run Locally

**Prerequisites:**
- Node.js 14.21.3

**PowerShell (Windows):**
```powershell
$env:AUTH_API_ADDRESS="http://127.0.0.1:8000"; $env:TODOS_API_ADDRESS="http://127.0.0.1:8082"; npm install; npm run dev
```

**CMD (Windows):**
```cmd
set AUTH_API_ADDRESS=http://127.0.0.1:8000 && set TODOS_API_ADDRESS=http://127.0.0.1:8082 && npm install && npm run dev
```

**Linux/macOS/Git Bash:**
```bash
AUTH_API_ADDRESS=http://127.0.0.1:8000 TODOS_API_ADDRESS=http://127.0.0.1:8082 npm run dev
```

App runs on http://localhost:8080

## Testing

With Redis, Auth API, Users API, and TODOs API running locally, test with these credentials:
- Username: `admin`, Password: `admin`
- Username: `johnd`, Password: `foo`
- Username: `janed`, Password: `ddd`

Complete local stack for testing:
```bash
# Required services
docker run -d -p 6379:6379 --name redis redis:7.0
docker run -d -p 8083:8083 -e JWT_SECRET=PRFT -e SERVER_PORT=8083 --name users-api torres05/users-api-ws1:latest
docker run -d -p 8000:8000 -e JWT_SECRET=PRFT -e AUTH_API_PORT=8000 -e USERS_API_ADDRESS=http://host.docker.internal:8083 --name auth-api torres05/auth-api-ws1:latest
docker run -d -p 8082:8082 -e JWT_SECRET=PRFT -e TODO_API_PORT=8082 -e REDIS_HOST=host.docker.internal -e REDIS_PORT=6379 -e REDIS_CHANNEL=log_channel --name todos-api torres05/todos-api-ws1:latest
```

## Run with Docker

```bash
docker build -t juanc7773/frontend-ws1 .
docker run -p 8080:80 -e AUTH_API_ADDRESS=http://127.0.0.1:8000 -e TODOS_API_ADDRESS=http://127.0.0.1:8082 juanc7773/frontend-ws1
```

## CI/CD Pipeline

### Setup Requirements:
**GitHub Secrets (Repository → Settings → Secrets):**
- `DOCKERHUB_USERNAME`: juanc7773
- `DOCKERHUB_TOKEN`: Your Docker Hub access token

### Automated Process:
1. **Push to master** → GitHub Actions triggers
2. **Build & Test** → npm install, npm run build, lint
3. **Docker Build** → Multi-stage build with Node.js + nginx
4. **Push to Registry** → Uploads to Docker Hub as `juanc7773/frontend-ws1:latest`

### Pipeline File:
`.github/workflows/main.yml` - Runs on every push to master branch

## Infrastructure (Terraform)

Deploys to Azure Container Apps with environment variables:
- **Local:** `AUTH_API_ADDRESS=http://127.0.0.1:8000`, `TODOS_API_ADDRESS=http://127.0.0.1:8082`
- **Azure:** `AUTH_API_ADDRESS=https://auth-app.microservices-env.westeurope.azurecontainerapps.io`, `TODOS_API_ADDRESS=https://todos-app.microservices-env.westeurope.azurecontainerapps.io`

## Key Files

- `package.json` - Dependencies and scripts
- `Dockerfile` - Multi-stage container build
- `nginx.conf` - Production web server configuration
- `config/index.js` - Development proxy configuration
- `.github/workflows/main.yml` - CI/CD pipeline

## Common Issues

**Environment variable not working (Windows PowerShell):**
Use `$env:VARIABLE="value"` syntax, not `VARIABLE=value`

**npm install fails:**
Ensure you're using Node.js 14.21.3 (Vue 2.x compatibility)

**CI/CD fails with "access denied":**
Check Docker Hub credentials in GitHub secrets

## Dependencies
- Vue.js 2.x
- Node.js 14.21.3
- Docker (for containerization)
- nginx (for production serving)