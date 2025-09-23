FROM node:14.21.3-alpine AS builder

WORKDIR /app

# Copiar package files
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar código fuente
COPY . .

RUN npm run build

# Runtime con nginx
FROM nginx:al   

# Copiar archivos build
COPY --from=builder /app/dist /usr/share/nginx/html

# Configuración nginx
COPY nginx.conf /etc/nginx/nginx.conf

COPY entrypoint.sh /entrypoint.sh

# Hacer el script ejecutable
RUN chmod +x /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]