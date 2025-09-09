targetScope = 'resourceGroup'

@minLength(5)
@maxLength(24)
@description('Name of the storage account, must be globally unique. Storage account names must be between 3 and 24 characters in length and use numbers and lower-case letters only.')
param storageName string
param location string = 'westus3'

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }

}
