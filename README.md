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
$env:AUTH_API_ADDRESS="http://127.0.0.1:8000"; npm install; npm run dev
```

**CMD (Windows):**
```cmd
set AUTH_API_ADDRESS=http://127.0.0.1:8000 && npm install && npm run dev
```

**Linux/macOS/Git Bash:**
```bash
AUTH_API_ADDRESS=http://127.0.0.1:8000 npm run dev
```

App runs on http://localhost:8080

## Testing

With Auth and Users APIs running locally, test with these credentials:
- Username: `admin`, Password: `admin`
- Username: `johnd`, Password: `foo`
- Username: `janed`, Password: `ddd`

## Run with Docker

```bash
docker build -t juanc7773/frontend-ws1 .
docker run -p 8080:80 -e AUTH_API_ADDRESS=http://127.0.0.1:8000 juanc7773/frontend-ws1
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
- **Local:** `AUTH_API_ADDRESS=http://127.0.0.1:8000`
- **Azure:** `AUTH_API_ADDRESS=https://auth-app.microservices-env.westeurope.azurecontainerapps.io`

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