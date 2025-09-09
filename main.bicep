// targetScope = 'resourceGroup'

// param Location string = 'Southeast Asia'
// param storageName string = 'mystorageaccount'

// resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
//   name: storageName
//   location: Location
//   kind: 'StorageV2'
//   sku: {
//     name: 'Premium_LRS' //different sizes for our resource
//   }
//   properties: {
//     accessTier: 'Hot'
//   }

// }

// resource webApplication 'Microsoft.Web/sites@2022-03-01' = {
//   name: 'zed${storageName}'
//   location: Location
//   properties: {
//     serverFarmId: 'appServicePlan.id'
//     httpsOnly: true

//   }

// }

// @secure()
// @description('password will not saved in deployment history or in the state file and will be masked in the deployment logs and not be logged in plain text')
// param demoPassword string 

@minLength(5)
@maxLength(24)
@description('Name of the storage account, must be globally unique. Storage account names must be between 3 and 24 characters in length and use numbers and lower-case letters only.')
param storageName string = 'spacetestapp'

@allowed([
  'eastus'
  'westus3'
  'southeastasia'
  'centralindia'
])
param location string = 'westus3'

param dockerImage string = 'nginxdemos/hello'
param dockerImageTag string = 'latest'
param namePrefix string = 'paulon'

targetScope = 'resourceGroup'

//how do consume modules
module storage 'modules/storage.bicep' = {
  name: storageName
  params: {
    storageName: storageName
    location: location
  }
}

module appPlanDeploy 'modules/servicePlan.bicep' = {
  name: '${namePrefix}-appPlanDeploy'
  params: {
    namePrefix: namePrefix
    location: location
  }
}
module deployWebsite 'modules/webApp.bicep' = {
  name: '${namePrefix}-deploy-site'
  params: {
    location: location
    appPlanId: appPlanDeploy.outputs.planId
    dockerImage: dockerImage
    dockerImageTag: dockerImageTag
  }
}

output siteUrl string = deployWebsite.outputs.siteUrl

