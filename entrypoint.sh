#!/bin/sh

# Valores por defecto para desarrollo local
AUTH_API_ADDRESS=${AUTH_API_ADDRESS:-"http://localhost:8000"}
TODOS_API_ADDRESS=${TODOS_API_ADDRESS:-"http://localhost:8082"}

echo "=== Configurando Frontend ==="
echo "AUTH_API_ADDRESS: $AUTH_API_ADDRESS"
echo "TODOS_API_ADDRESS: $TODOS_API_ADDRESS"
echo "=============================="

# Reemplazar placeholders en todos los archivos JavaScript
echo "Reemplazando URLs en archivos JavaScript..."
find /usr/share/nginx/html -name "*.js" -type f -exec sed -i "s|__AUTH_API_ADDRESS__|$AUTH_API_ADDRESS|g" {} \;
find /usr/share/nginx/html -name "*.js" -type f -exec sed -i "s|__TODOS_API_ADDRESS__|$TODOS_API_ADDRESS|g" {} \;

echo "URLs configuradas exitosamente"

# Iniciar nginx
exec nginx -g "daemon off;"
