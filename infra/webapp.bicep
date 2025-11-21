@description('Location for all resources')
param location string = resourceGroup().location

@description('Name of the App Service plan')
param appServicePlanName string = 'webapp-plan'

@description('Name of the Web App')
param webAppName string

@description('SKU of the App Service plan (e.g., F1, B1, S1)')
param sku string = 'F1'

// App Service Plan (Linux)
resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: sku
    capacity: 1
    tier: 'Free'
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

// Web App
resource webApp 'Microsoft.Web/sites@2022-09-01' = {
  name: webAppName
  location: location
  kind: 'app,linux'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'NODE|22-lts'
    }
    httpsOnly: true
  }
}

output webAppUrl string = 'https://${webApp.properties.defaultHostName}'
output appServicePlanId string = appServicePlan.id
output webAppId string = webApp.id