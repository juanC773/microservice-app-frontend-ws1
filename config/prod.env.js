// 
module.exports = {
  NODE_ENV: '"production"',
  AUTH_API_ADDRESS: JSON.stringify(process.env.AUTH_API_ADDRESS || 'https://auth-app.microservices-env.westeurope.azurecontainerapps.io'),
  ZIPKIN_URL: JSON.stringify(process.env.ZIPKIN_URL || 'http://127.0.0.1:9411/api/v2/spans')
}