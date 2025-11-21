// Creates a resource group at subscription scope
targetScope = 'subscription'

@description('Name of the resource group to create or update.')
param rgName string

@description('Azure region where the resource group will reside.')
param rgLocation string

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: rgName
  location: rgLocation
}

output resourceGroupName string = rg.name
output resourceGroupLocation string = rg.location
