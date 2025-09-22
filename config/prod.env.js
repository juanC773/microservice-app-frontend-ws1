module.exports = {
  NODE_ENV: '"production"',
  AUTH_API_ADDRESS: JSON.stringify(process.env.AUTH_API_ADDRESS || 'https://auth-app.microservices-env.westeurope.azurecontainerapps.io'),
  TODOS_API_ADDRESS: JSON.stringify(process.env.TODOS_API_ADDRESS || 'https://todos-app.microservices-env.westeurope.azurecontainerapps.io')
}