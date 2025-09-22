FROM node:14.21.3-alpine AS builder

WORKDIR /app

# Copiar package files
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar código fuente
COPY . .

# Build para producción con variables de entorno
ARG AUTH_API_ADDRESS
ARG ZIPKIN_URL

ENV AUTH_API_ADDRESS=$AUTH_API_ADDRESS
ENV ZIPKIN_URL=$ZIPKIN_URL

RUN npm run build

# Runtime con nginx
FROM nginx:alpine

# Copiar archivos build
COPY --from=builder /app/dist /usr/share/nginx/html

# Configuración nginx
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]