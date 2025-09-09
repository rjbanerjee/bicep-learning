@description('Prefix for all resources deployed')
param namePrefix string
param location string = resourceGroup().location
param sku string = 'B1'

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: '${namePrefix}-website'
  location: location
  kind: 'linux' // or 'ubuntu'
  sku: {
    name: sku
  }
  properties: {
    reserved: true //linux plan
  }

}

output planId string = appServicePlan.id
